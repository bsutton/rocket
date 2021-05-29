# rocket

Version 0.1.0 (BETA)  

Rocket is a parsing framework for parsing using efficient parsing algorithms.

The Rocket is a professional developers framework.  
The Rocket is a framework for the rapid development of fast parsers.  
Implement something properly once and reuse it everywhere.  
Parse data as efficiently as possible.  
Use the capabilities of the framework in combination with your own parsers.  
Combine handwritten algorithms with built-in parsers for maximum efficiency.  

### What planned

- More core parsers
- Examples
- Documentation
- Useful "how to"

***To make this project better you can make a donation for development.***  

### Perfomance

Below are the results of testing JSON parsers. Dart SDK JSON parser and JSON parser implemented using Rocket.  

JIT:

```
Dart SDK JSON: k: 1.00, 42.85 MB/s, 501.03 ms (50.71%),
Rocket JSON  : k: 1.97, 21.73 MB/s, 988.06 ms (100.00%),

Parse 10 times: E:\prj\test_dart_json_parsers\bin\data\citm_catalog.json
Dart SDK JSON: k: 1.00, 86.23 MB/s, 191.01 ms (58.23%),
Rocket JSON  : k: 1.72, 50.21 MB/s, 328.02 ms (100.00%),

Parse 10 times: E:\prj\test_dart_json_parsers\bin\data\twitter.json
Dart SDK JSON: k: 1.00, 53.62 MB/s, 101.01 ms (74.27%),
Rocket JSON  : k: 1.35, 39.82 MB/s, 136.01 ms (100.00%),
```

AOT:

```
Parse 10 times: E:\prj\test_dart_json_parsers\bin\data\canada.json
Dart SDK JSON: k: 1.00, 12.28 MB/s, 1748.10 ms (41.98%),
Rocket JSON  : k: 2.38, 5.16 MB/s, 4164.24 ms (100.00%),

Parse 10 times: E:\prj\test_dart_json_parsers\bin\data\citm_catalog.json
Dart SDK JSON: k: 1.16, 23.90 MB/s, 689.04 ms (100.00%),
Rocket JSON  : k: 1.00, 27.73 MB/s, 594.03 ms (86.21%),

Parse 10 times: E:\prj\test_dart_json_parsers\bin\data\twitter.json
Dart SDK JSON: k: 1.00, 45.90 MB/s, 118.01 ms (67.82%),
Rocket JSON  : k: 1.47, 31.13 MB/s, 174.01 ms (100.00%),
```

The Rocket JSON parser was written in a few hours.  
The parser can be complicated to improve performance by adding some kinds of tweaks (as it was done in the Dart SDK parser), but this will impair the clarity of the parsing algorithms and, in principle, reduce its reliability (theoretically).  

### JSON parser example

```dart
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

class _False extends _Term2 {
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
}

class _Null extends _Term2 {
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

class _Term2<E> extends Parser<E> {
  final String name;

  final Parser p;

  final Tuple1<E> res;

  final Parser white = _white;

  _Term2(this.name, E v)
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

class _True extends _Term2 {
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

```

### How to debug

The first way.  
Temporarily implement the overridden methods and set breakpoints on them.  

Original:

```dart
class _Members extends SepByParser<Tuple2<String, dynamic>> {
  _Members() : super(_member, _comma);
}
```

Modified:

```dart
class _Members extends SepByParser<Tuple2<String, dynamic>> {
  _Members() : super(_member, _comma);

  @override
   // Set breakpoint here
  bool fastParse(state) => super.fastParse(state);

  @override
   // Or here
  Tuple1<List<Tuple2<String, dynamic>>>? parse(state) => super.parse(state);
}
```

Second way.  
Use a modified implementation of `ParseState` for tracing.  
This will help you track how the parsing process is going. Not very informative, but at least better than nothing at all. Good for tracking small samples that are throwing errors.  
A usage example is in the `examples` folder.  

The parsing progress information may look like this (for source ` [true, 10.2]`):  

```
_White
 [true, 10.2]
[true, 10.2]
---
_Ref => PunctParser
[true, 10.2]
true, 10.2]
---
_Ref => _Ref => _Term => StrParser
true, 10.2]
, 10.2]
---
_Ref => PunctParser
, 10.2]
 10.2]
---
_Ref => _White
 10.2]
10.2]
---
_Ref => _Ref => _Number => Range1Parser
10.2]
0.2]
---
_Ref => _Ref => _Number => _Range1ManyParser
0.2]
.2]
---
_Ref => _Ref => _Number => CharParser
.2]
2]
---
_Ref => _Ref => _Number => Range1Parser
2]
]
---
_Ref => PunctParser
]
---
```

To be continued...