import 'package:charcode/ascii.dart';
import 'package:rocket/matcher.dart';
import 'package:rocket/parse.dart';

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

final parser = () {
  _value.p = choice7(_object, _array, _string, _number, _true, _false, _null);
  return _json;
}();

final _array = _Array();

final _chars = _Chars();

final _closeBrace = _CloseBrace();

final _closeBracket = _CloseBracket();

final _colon = _Colon();

final _comma = _Comma();

final _false = _False();

final _json = _Json();

final _member = _Member();

final _members = _Members();

final _null = _Null();

final _number = _Number();

final _object = _Object();

final _openBrace = _OpenBrace();

final _openBracket = _OpenBracket();

final _string = _String();

final _true = _True();

final _value = _Value();

final _values = _Values();

final _white = _White();

class _Array extends BetweenParser {
  _Array() : super(_openBracket, _values, _closeBracket);
}

class _Chars extends Parser<List<int>> {
  @override
  bool fastParse(ParseState state) {
    parse(state);
    return true;
  }

  @override
  Tuple1<List<int>>? parse(ParseState state) {
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

class _CloseBrace extends PunctParser {
  _CloseBrace() : super('}', $close_brace, _white);
}

class _CloseBracket extends PunctParser {
  _CloseBracket() : super(']', $close_bracket, _white);
}

class _Colon extends PunctParser {
  _Colon() : super(':', $colon, _white);
}

class _Comma extends PunctParser {
  _Comma() : super(',', $comma, _white);
}

class _False extends _Term {
  _False() : super('false', false);
}

class _Json extends BetweenParser {
  _Json() : super(_white, _value, not(anyChar()));
}

class _Member extends AroundParser<String, dynamic> {
  _Member() : super(_string, _colon, _value);
}

class _Members extends SepByParser<Tuple2<String, dynamic>> {
  _Members() : super(_member, _comma);

  @override
  bool fastParse(state) => super.fastParse(state);

  @override
  Tuple1<List<Tuple2<String, dynamic>>>? parse(state) => super.parse(state);
}

class _Null extends _Term {
  _Null() : super('null', null);
}

class _Number extends Parser<num> {
  static final _digit09 = range1(Range($0, $9));

  static final _digit19 = range1(Range($1, $9));

  static final _dot = char($dot);

  static final _eE = chars2($e, $E);

  static final _exp = seq3(_eE, _signs.opt, _digit09.many1);

  static final _frac = seq2(_dot, _digit09.many1);

  static final _integer = choice2(_zero, seq2(_digit19, _digit09.many));

  static final _minus = char($minus);

  static final _number =
      left(seq4(_minus.opt, _integer, _frac.opt, _exp.opt).capture, _white);

  static final _signs = chars2($plus, $minus);

  static final _zero = char($0);

  @override
  bool fastParse(ParseState state) => parse(state) != null;

  @override
  Tuple1<num>? parse(ParseState state) {
    final r1 = _number.parse(state);
    if (r1 == null) {
      state.fail('number', state.pos);
      return null;
    }

    final v1 = r1.$0;
    final v2 = parseNumber(v1);
    return Tuple1(v2);
  }
}

class _Object extends Parser<Map<String, dynamic>> {
  final BetweenParser<List<Tuple2<String, dynamic>>> p;

  _Object() : p = between(_openBrace, _members, _closeBrace);

  @override
  bool fastParse(ParseState state) => p.fastParse(state);

  @override
  Tuple1<Map<String, dynamic>>? parse(ParseState state) {
    final r1 = p.parse(state);
    if (r1 != null) {
      final v1 = r1.$0;
      final v2 = <String, dynamic>{};
      for (var i = 0; i < v1.length; i++) {
        final v3 = v1[i];
        v2[v3.$0] = v3.$1;
      }

      return Tuple1(v2);
    }
  }
}

class _OpenBrace extends PunctParser {
  _OpenBrace() : super('{', $open_brace, _white);
}

class _OpenBracket extends PunctParser {
  _OpenBracket() : super('[', $open_bracket, _white);
}

class _Ref<E> extends Parser<E> {
  Parser<E> p = DummyParser();

  @override
  bool fastParse(ParseState state) => p.fastParse(state);

  @override
  Tuple1<E>? parse(ParseState state) => p.parse(state);
}

class _String extends Parser<String> {
  final BetweenParser<List<int>> chars;

  _String()
      : chars = BetweenParser(char($quote), _chars, seq2(char($quote), _white));

  @override
  bool fastParse(ParseState state) {
    final r1 = chars.parse(state);
    if (r1 == null) {
      state.fail('string', state.pos);
      return false;
    }

    return true;
  }

  @override
  Tuple1<String>? parse(ParseState state) {
    final r1 = chars.parse(state);
    if (r1 == null) {
      state.fail('string', state.pos);
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

  final Tuple1<E> res;

  final Parser white = _white;

  _Term(this.name, E v)
      : p = str(name),
        res = Tuple1(v);

  @override
  bool fastParse(ParseState state) {
    if (p.fastParse(state)) {
      white.fastParse(state);
      return true;
    }

    state.fail(name, state.pos);
    return false;
  }

  @override
  Tuple1<E>? parse(ParseState state) {
    if (p.fastParse(state)) {
      white.fastParse(state);
      return res;
    }

    state.fail(name, state.pos);
  }
}

class _True extends _Term {
  _True() : super('true', true);
}

class _Value<E> extends _Ref<E> {
  //
}

class _Values extends SepByParser {
  _Values() : super(_value, _comma);
}

class _White extends Parser {
  final Matcher<int> m =
      AsciiMatcher(Ascii.cr | Ascii.lf | Ascii.ht | Ascii.space);

  @override
  bool fastParse(ParseState state) {
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
  Tuple1? parse(ParseState state) {
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
