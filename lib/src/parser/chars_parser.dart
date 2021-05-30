part of '../../parser.dart';

/// Creates the [CharsParser] parser.
CharsParser chars(List<int> cs) => CharsParser(cs);

/// Creates the [Chars2Parser] parser.
Chars2Parser chars2(int c1, int c2) => Chars2Parser(c1, c2);

/// Creates the [Chars3Parser] parser.
Chars3Parser chars3(int c1, int c2, int c3) => Chars3Parser(c1, c2, c3);

/// Creates the [Chars4Parser] parser.
Chars4Parser chars4(int c1, int c2, int c3, int c4) =>
    Chars4Parser(c1, c2, c3, c4);

/// Creates the [Chars5Parser] parser.
Chars5Parser chars5(int c1, int c2, int c3, int c4, int c5) =>
    Chars5Parser(c1, c2, c3, c4, c5);

/// Creates the [Chars6Parser] parser.
Chars6Parser chars6(int c1, int c2, int c3, int c4, int c5, int c6) =>
    Chars6Parser(c1, c2, c3, c4, c5, c6);

/// Creates the [Chars7Parser] parser.
Chars7Parser chars7(int c1, int c2, int c3, int c4, int c5, int c6, int c7) =>
    Chars7Parser(c1, c2, c3, c4, c5, c6, c7);

/// The [Char2Parser] parser consumes one of 2 characters [c1], [c2].
///
/// The result is the consumed character.
///
/// Example: chars2(48, 49)
class Chars2Parser extends Parser<int> {
  final int c1;

  final int c2;

  Chars2Parser(this.c1, this.c2);

  @override
  bool fastParse(ParseState state) {
    final c = state.ch;
    if (c == c1 || c == c2) {
      state.nextChar();
      return true;
    }

    return false;
  }

  @override
  Tuple1<int>? parse(ParseState state) {
    final c = state.ch;
    if (c == c1 || c == c2) {
      state.nextChar();
      return Tuple1(c);
    }
  }
}

/// The [Char3Parser] parser consumes one of 3 characters [c1], [c2], [c3].
///
/// The result is the consumed character.
///
/// Example: chars3(48, 49, 50)
class Chars3Parser extends Parser<int> {
  final int c1;

  final int c2;

  final int c3;

  Chars3Parser(this.c1, this.c2, this.c3);

  @override
  bool fastParse(ParseState state) {
    final c = state.ch;
    if (c == c1 || c == c2 || c == c3) {
      state.nextChar();
      return true;
    }

    return false;
  }

  @override
  Tuple1<int>? parse(ParseState state) {
    final c = state.ch;
    if (c == c1 || c == c2 || c == c3) {
      state.nextChar();
      return Tuple1(c);
    }
  }
}

/// The [Char4Parser] parser consumes one of 4 characters [c1], [c2], [c3],
/// [c4].
///
/// The result is the consumed character.
///
/// Example: chars4(48, 49, 50, 51)
class Chars4Parser extends Parser<int> {
  final int c1;

  final int c2;

  final int c3;

  final int c4;

  Chars4Parser(this.c1, this.c2, this.c3, this.c4);

  @override
  bool fastParse(ParseState state) {
    final c = state.ch;
    if (c == c1 || c == c2 || c == c3 || c == c4) {
      state.nextChar();
      return true;
    }

    return false;
  }

  @override
  Tuple1<int>? parse(ParseState state) {
    final c = state.ch;
    if (c == c1 || c == c2 || c == c3 || c == c4) {
      state.nextChar();
      return Tuple1(c);
    }
  }
}

/// The [Char5Parser] parser consumes one of 5 characters [c1], [c2], [c3],
/// [c4], [c5].
///
/// The result is the consumed character.
///
/// Example: chars5(48, 49, 50, 51, 52)
class Chars5Parser extends Parser<int> {
  final int c1;

  final int c2;

  final int c3;

  final int c4;

  final int c5;

  Chars5Parser(this.c1, this.c2, this.c3, this.c4, this.c5);

  @override
  bool fastParse(ParseState state) {
    final c = state.ch;
    if (c == c1 || c == c2 || c == c3 || c == c4 || c == c5) {
      state.nextChar();
      return true;
    }

    return false;
  }

  @override
  Tuple1<int>? parse(ParseState state) {
    final c = state.ch;
    if (c == c1 || c == c2 || c == c3 || c == c4 || c == c5) {
      state.nextChar();
      return Tuple1(c);
    }
  }
}

/// The [Char6Parser] parser consumes one of 6 characters [c1], [c2], [c3],
/// [c4], [c5], [c6].
///
/// The result is the consumed character.
///
/// Example: chars6(48, 49, 50, 51, 52, 53)
class Chars6Parser extends Parser<int> {
  final int c1;

  final int c2;

  final int c3;

  final int c4;

  final int c5;

  final int c6;

  Chars6Parser(this.c1, this.c2, this.c3, this.c4, this.c5, this.c6);

  @override
  bool fastParse(ParseState state) {
    final c = state.ch;
    if (c == c1 || c == c2 || c == c3 || c == c4 || c == c5 || c == c6) {
      state.nextChar();
      return true;
    }

    return false;
  }

  @override
  Tuple1<int>? parse(ParseState state) {
    final c = state.ch;
    if (c == c1 || c == c2 || c == c3 || c == c4 || c == c5 || c == c6) {
      state.nextChar();
      return Tuple1(c);
    }
  }
}

/// The [Char7Parser] parser consumes one of 7 characters [c1], [c2], [c3],
/// [c4], [c5], [c6], [c7].
///
/// The result is the consumed character.
///
/// Example: chars7(48, 49, 50, 51, 52, 53, 54)
class Chars7Parser extends Parser<int> {
  final int c1;

  final int c2;

  final int c3;

  final int c4;

  final int c5;

  final int c6;

  final int c7;

  Chars7Parser(this.c1, this.c2, this.c3, this.c4, this.c5, this.c6, this.c7);

  @override
  bool fastParse(ParseState state) {
    final c = state.ch;
    if (c == c1 ||
        c == c2 ||
        c == c3 ||
        c == c4 ||
        c == c5 ||
        c == c6 ||
        c == c7) {
      state.nextChar();
      return true;
    }

    return false;
  }

  @override
  Tuple1<int>? parse(ParseState state) {
    final c = state.ch;
    if (c == c1 ||
        c == c2 ||
        c == c3 ||
        c == c4 ||
        c == c5 ||
        c == c6 ||
        c == c7) {
      state.nextChar();
      return Tuple1(c);
    }
  }
}

/// The [CharParser] parser consumes one of characters [cs].
///
/// The result is the consumed character.
///
/// Example: chars(cs)
class CharsParser extends Parser<int> {
  Uint32List _cs = Uint32List(0);

  int _maxChar = 0;

  CharsParser(List<int> cs) {
    if (cs.isEmpty) {
      throw ArgumentError.value(cs, 'cs', 'Must not be empty');
    }

    final temp = cs.toList();
    if (temp.toSet().length != cs.length) {
      throw ArgumentError.value(
          cs, 'chars', 'Must not not contain duplicate elements');
    }

    temp.sort();
    _cs = Uint32List.fromList(temp);
    _maxChar = _cs.last;
  }

  SkipManyParser get skipMany => _CharsSkipManyParser(this, _cs, _maxChar);

  @override
  bool fastParse(ParseState state) {
    final c = state.ch;
    if (c <= _maxChar) {
      for (var i = 0; i < _cs.length; i++) {
        if (c == _cs[i]) {
          state.nextChar();
          return true;
        }
      }
    }

    return false;
  }

  @override
  Tuple1<int>? parse(ParseState state) {
    final ch = state.ch;
    if (ch <= _maxChar) {
      for (var i = 0; i < _cs.length; i++) {
        if (ch == _cs[i]) {
          state.nextChar();
          return Tuple1(ch);
        }
      }
    }
  }
}

class _CharsSkipManyParser extends SkipManyParser {
  final List<int> _cs;

  final int _maxChar;

  _CharsSkipManyParser(CharsParser p, this._cs, this._maxChar) : super(p);

  @override
  bool fastParse(ParseState state) {
    while (true) {
      final c = state.ch;
      if (c <= _maxChar) {
        for (var i = 0; i < _cs.length; i++) {
          if (c == _cs[i]) {
            state.nextChar();
            continue;
          }
        }
      }

      return true;
    }
  }

  @override
  Tuple1? parse(ParseState state) {
    while (true) {
      final c = state.ch;
      if (c <= _maxChar) {
        for (var i = 0; i < _cs.length; i++) {
          if (c == _cs[i]) {
            state.nextChar();
            continue;
          }
        }
      }

      return const Tuple1(null);
    }
  }
}
