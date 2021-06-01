import 'package:charcode/ascii.dart';
import 'package:rocket/matcher.dart';
import 'package:rocket/parse.dart';
import 'package:rocket/parse_error.dart';

import '_parse_number.dart';

export 'package:rocket/parse.dart';

void main() {
  final text = '''
{"rocket": "🚀 flies to the stars"}
''';
  final p = parser;
  final r = p.parseString(text);
  print(r);
}

final parser = _createParser();

final _chars = _Chars().as('chars');

final _white = _White().as('white');

Parser _createParser() {
  final _closeBrace = tokChar($close_brace, '}', null, _white);

  final _closeBracket = tokChar($close_bracket, ']', null, _white);

  final _colon = tokChar($colon, ':', null, _white);

  final _eof = not(anyChar()).expected('end of file').as('end of file');

  final _comma = tokChar($comma, ',', null, _white);

  final _false = _Term('false', false).orFail(expectedError('false'));

  final _null = _Term('null', null).orFail(expectedError('null'));

  final _openBrace = tokChar($open_brace, '{', null, _white);

  final _openBracket = tokChar($open_bracket, '[', null, _white);

  final _true = _Term('true', true).orFail(expectedError('true'));

  final _string = _String().as('string');

  final _value = ref().as('value') as RefParser;

  final _values = sepBy(_value, _comma).as('values');

  final _array = between(_openBracket, _values, _closeBracket).as('array');

  final _member = around(_string, _colon, _value).as('member');

  final _members = sepBy(_member, _comma).as('members');

  final _object = between(_openBrace, _members, _closeBrace)
      .mapper(_ObjectMapper())
      .as('object');

  final _number = _Number().as('number');

  _value.p = choice7(_object, _array, _string, _number, _true, _false, _null)
      .as('value');

  final _json = between(_white, _value, _eof).as('json');

  return _json;
}

class _Chars extends Parser<List<int>> {
  @override
  bool handleFastParse(ParseState state) {
    parse(state);
    return true;
  }

  @override
  Tuple1<List<int>>? handleParse(ParseState state) {
    final list = <int>[];
    int ch = 0;
    int pos = 0;
    loop:
    while (true) {
      ch = state.ch;
      pos = state.pos;
      var c = state.ch;
      if ((c >= 0x5d && c <= 0x10ffff) ||
          (c >= 0x23 && c <= 0x5b) ||
          (c >= 0x20 && c <= 0x21)) {
        state.nextChar();
        list.add(c);
        continue;
      }

      if (c != $backslash) {
        break loop;
      }

      c = state.nextChar();
      switch (c) {
        case $double_quote:
        case $slash:
        case $backslash:
          state.nextChar();
          list.add(c);
          continue;
        case $b:
          state.nextChar();
          list.add(0x08);
          continue;
        case $f:
          state.nextChar();
          list.add(0x0c);
          continue;
        case $n:
          state.nextChar();
          list.add(0x0d);
          continue;
        case $r:
          state.nextChar();
          list.add(0x0d);
          continue;
        case $t:
          state.nextChar();
          list.add(0x09);
          continue;
        case $u:
          state.nextChar();
          var c2 = 0;
          for (var i = 0; i < 4; i++) {
            final c = state.ch;
            if (c >= $0 && c <= $9) {
              c2 = (c2 << 4) | (c - 0x30);
            } else if (c >= $a && c <= $f) {
              c2 = (c2 << 4) | (c - $a + 10);
            } else if (c >= $A && c <= $F) {
              c2 = (c2 << 4) | (c - $A + 10);
            } else {
              break loop;
            }

            state.nextChar();
          }

          list.add(c2);
          break;
        default:
          break loop;
      }
    }

    state.pos = pos;
    state.ch = ch;
    return Tuple1(list);
  }
}

class _Number extends Parser<num> {
  static final _digit = digit();

  static final _digit19 = ranges1(Range($1, $9));

  static final _dot = char($dot);

  static final _eE = chars2($e, $E);

  static final _exp = seq3(_eE, _signs.opt, _digit.skipMany1);

  static final _frac = seq2(_dot, _digit.skipMany1);

  static final _integer = choice2(_zero, seq2(_digit19, _digit.skipMany));

  static final _minus = char($minus);

  static final _number =
      left(seq4(_minus.opt, _integer, _frac.opt, _exp.opt).capture, _white);

  static final _signs = chars2($plus, $minus);

  static final _zero = char($0);

  @override
  bool handleFastParse(ParseState state) => handleParse(state) != null;

  @override
  Tuple1<num>? handleParse(ParseState state) {
    final r1 = _number.parse(state);
    if (r1 == null) {
      state.fail(expectedError('number'), state.pos);
      return null;
    }

    final v1 = r1.$0;
    final v2 = parseNumber(v1);
    return Tuple1(v2);
  }
}

class _ObjectMapper
    implements Mapper<List<Tuple2<String, dynamic>>, Map<String, dynamic>> {
  @override
  Map<String, dynamic> map(List<Tuple2<String, dynamic>> value) {
    final r = <String, dynamic>{};
    for (var i = 0; i < value.length; i++) {
      final v = value[i];
      r[v.$0] = v.$1;
    }

    return r;
  }
}

class _ParseTracer extends ParseTracer {
  int _indent = 0;

  @override
  void enter<E>(Parser<E> parser, ParseState state) {
    _trace(parser, state, true);
  }

  @override
  void enterFast<E>(Parser<E> parser, ParseState state) {
    _trace(parser, state, true);
  }

  @override
  void leave<E>(Parser<E> parser, ParseState state, Tuple1<E>? result) {
    _trace(parser, state, false, result);
  }

  @override
  void leaveFast<E>(Parser<E> parser, ParseState state, bool result) {
    _trace(parser, state, false, result);
  }

  void _trace(Parser parser, ParseState state, bool enter, [result]) {
    final pos = state.pos;
    final source = state.source;
    final sink = StringBuffer();
    if (!enter) {
      _indent -= 2;
    }

    sink.write(' ' * _indent);
    sink.write(enter ? '>> ' : '<< ');
    sink.write(parser);
    sink.write(': pos ');
    sink.write(pos);
    if (!enter) {
      sink.write(', RESULT: ');
      sink.write(result);
    }

    sink.writeln();
    sink.write(' ' * _indent);
    var length = source.length - pos;
    length = length < 48 ? length : 48;
    var text = state.source.substring(pos, pos + length);
    text = text.replaceAll('\n', '\\n');
    text = text.replaceAll('\r', '\\r');
    sink.write(text);
    print(sink);
    if (enter) {
      _indent += 2;
    }
  }
}

class _String extends Parser<String> {
  final BetweenParser<List<int>> chars;

  _String()
      : chars = BetweenParser(char($quote), _chars, seq2(char($quote), _white));

  @override
  bool handleFastParse(ParseState state) {
    final r1 = chars.parse(state);
    if (r1 == null) {
      state.fail(expectedError('string'), state.pos);
      return false;
    }

    return true;
  }

  @override
  Tuple1<String>? handleParse(ParseState state) {
    final r1 = chars.parse(state);
    if (r1 == null) {
      state.fail(expectedError('string'), state.pos);
      return null;
    }

    final v1 = r1.$0;
    final v2 = String.fromCharCodes(v1);
    return Tuple1(v2);
  }
}

class _Term<E> extends Parser<E> {
  final String name;

  final Parser p;

  final Tuple1<E> _res;

  final Parser white = _white;

  _Term(this.name, E val)
      : p = str(name),
        _res = Tuple1(val);

  @override
  bool handleFastParse(ParseState state) {
    if (p.fastParse(state)) {
      white.fastParse(state);
      return true;
    }

    state.fail(expectedError(name), state.pos);
    return false;
  }

  @override
  Tuple1<E>? handleParse(ParseState state) {
    if (p.fastParse(state)) {
      white.fastParse(state);
      return _res;
    }

    state.fail(expectedError(name), state.pos);
  }
}

class _White extends Parser {
  final Matcher<int> m =
      AsciiMatcher(Ascii.cr | Ascii.lf | Ascii.ht | Ascii.space);

  @override
  bool handleFastParse(ParseState state) {
    while (true) {
      final c = state.ch;
      if (m.match(c)) {
        state.nextChar();
        continue;
      }

      return true;
    }
  }

  @override
  Tuple1? handleParse(ParseState state) {
    while (true) {
      final c = state.ch;
      if (m.match(c)) {
        state.nextChar();
        continue;
      }

      return const Tuple1(null);
    }
  }
}

extension<E> on Parser<E> {
  Parser<E> as(String label) {
    this.label = label;
    quote = label.contains(' ');
    return this;
  }

  Parser<E> expected(String msg) => this.orFail(expectedError(msg));
}
