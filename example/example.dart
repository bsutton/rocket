import 'package:charcode/ascii.dart';
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

final _ws = _WS();

Parser _createParser() {
  final _closeBrace = tokChar($close_brace, '}', null, _ws);

  final _closeBracket = tokChar($close_bracket, ']', null, _ws);

  final _colon = tokChar($colon, ':', null, _ws);

  final _eof = tok(not(anyChar()), 'end of file', null, _ws);

  final _comma = tokChar($comma, ',', null, _ws);

  final _false = tokStr('false', 'false', false, _ws);

  final _null = tokStr('null', 'null', null, _ws);

  final _openBrace = tokChar($open_brace, '{', null, _ws);

  final _openBracket = tokChar($open_bracket, '[', null, _ws);

  final _true = tokStr('true', 'true', true, _ws);

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

  final _json = between(white(_ws), _value, _eof).as('json');

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
  static final _digit = digit().as('[0-9]');

  static final _digit19 = ranges1(Range($1, $9)).as('[1-9]');

  static final _dot = char($dot).as('.');

  static final _eE = chars2($e, $E).as('e | E');

  static final _exp = seq3(_eE, _signs.opt, _digit.skipMany1).as('exp');

  static final _frac = seq2(_dot, _digit.skipMany1).as('frac');

  static final _integer =
      choice2(_zero, seq2(_digit19, _digit.skipMany)).as('integer');

  static final _minus = char($minus).as('minus');

  static final _number =
      seq4(_minus.opt, _integer, _frac.opt, _exp.opt).capture.as('_number');

  static final _signs = chars2($plus, $minus).as('signs');

  static final _zero = char($0).as('zero');

  @override
  bool handleFastParse(ParseState state) => handleParse(state) != null;

  @override
  Tuple1<num>? handleParse(ParseState state) {
    final r1 = _number.parse(state);
    if (r1 == null) {
      state.fail(expectedError('number'), state.pos);
      return null;
    }

    _ws.skip(state);
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

class _String extends Parser<String> {
  static final _quote = char($quote).as('open_quote');

  final Parser<List<int>> chars;

  _String()
      : chars = between(_quote, _chars, tokChar($quote, '\'', null, _ws))
            .as('chars');

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

class _White extends Parser {
  @override
  bool handleFastParse(ParseState state) {
    _ws.skip(state);
    return true;
  }

  @override
  Tuple1? handleParse(ParseState state) {
    _ws.skip(state);
    return const Tuple1(null);
  }
}

class _WS implements Skipper {
  final Matcher<int> _m =
      AsciiMatcher(Ascii.cr | Ascii.lf | Ascii.ht | Ascii.space);

  @override
  void skip(ParseState state) {
    while (true) {
      if (_m.match(state.ch)) {
        state.nextChar();
        continue;
      }

      break;
    }
  }
}

extension<E> on Parser<E> {
  Parser<E> as(String label) {
    this.label = label;
    quote = label.contains(' ');
    return this;
  }
}
