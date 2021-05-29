part of '../../parser.dart';

CharsParser chars(List<int> cs) => CharsParser(cs);

Chars2Parser chars2(int c1, int c2) => Chars2Parser(c1, c2);

Chars3Parser chars3(int c1, int c2, int c3) => Chars3Parser(c1, c2, c3);

Chars4Parser chars4(int c1, int c2, int c3, int c4) =>
    Chars4Parser(c1, c2, c3, c4);

Chars5Parser chars5(int c1, int c2, int c3, int c4, int c5) =>
    Chars5Parser(c1, c2, c3, c4, c5);

Chars6Parser chars6(int c1, int c2, int c3, int c4, int c5, int c6) =>
    Chars6Parser(c1, c2, c3, c4, c5, c6);

Chars7Parser chars7(int c1, int c2, int c3, int c4, int c5, int c6, int c7) =>
    Chars7Parser(c1, c2, c3, c4, c5, c6, c7);

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
