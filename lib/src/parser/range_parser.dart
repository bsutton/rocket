part of '../../parser.dart';

RangesParser ranges(List<Range> rs) => RangesParser(rs);

Ranges1Parser ranges1(Range r1) => Ranges1Parser(r1);

Ranges2Parser ranges2(Range r1, Range r2) => Ranges2Parser(r1, r2);

Ranges3Parser ranges3(Range r1, Range r2, Range r3) =>
    Ranges3Parser(r1, r2, r3);

Ranges4Parser ranges4(Range r1, Range r2, Range r3, Range r4) =>
    Ranges4Parser(r1, r2, r3, r4);

Ranges5Parser ranges5(Range r1, Range r2, Range r3, Range r4, Range r5) =>
    Ranges5Parser(r1, r2, r3, r4, r5);

Ranges6Parser ranges6(
        Range r1, Range r2, Range r3, Range r4, Range r5, Range r6) =>
    Ranges6Parser(r1, r2, r3, r4, r5, r6);

class Ranges1Parser extends Parser<int> {
  final int v1;

  final int v2;

  Ranges1Parser(Range r1)
      : v1 = r1.start,
        v2 = r1.end;

  ManyParser<int> get many => _Range1ManyParser(this, Range(v1, v2));

  @override
  bool handleFastParse(ParseState state) {
    final c = state.ch;
    if (c >= v1 && c <= v2) {
      state.nextChar();
      return true;
    }

    return false;
  }

  @override
  Tuple1<int>? handleParse(ParseState state) {
    final c = state.ch;
    if (c >= v1 && c <= v2) {
      state.nextChar();
      return Tuple1(c);
    }
  }
}

class Ranges2Parser extends Parser<int> {
  final int v1;

  final int v2;

  final int v3;

  final int v4;

  Ranges2Parser(Range r1, Range r2)
      : v1 = r1.start,
        v2 = r1.end,
        v3 = r2.start,
        v4 = r2.end {
    Range.check([r1, r2]);
  }

  @override
  bool handleFastParse(ParseState state) {
    final c = state.ch;
    if ((c >= v1 && c <= v4) && (c <= v2 || c >= v3)) {
      state.nextChar();
      return true;
    }

    return false;
  }

  @override
  Tuple1<int>? handleParse(ParseState state) {
    final c = state.ch;
    if ((c >= v1 && c <= v4) && (c <= v2 || c >= v3)) {
      state.nextChar();
      return Tuple1(c);
    }
  }
}

class Ranges3Parser extends Parser<int> {
  final int v1;

  final int v2;

  final int v3;

  final int v4;

  final int v5;

  final int v6;

  Ranges3Parser(Range r1, Range r2, Range r3)
      : v1 = r1.start,
        v2 = r1.end,
        v3 = r2.start,
        v4 = r2.end,
        v5 = r3.start,
        v6 = r3.end {
    Range.check([r1, r2, r3]);
  }

  @override
  bool handleFastParse(ParseState state) {
    final c = state.ch;
    if ((c >= v1 && c <= v6) && (c <= v2 || c >= v5) || (c >= v3 && c <= v4)) {
      state.nextChar();
      return true;
    }

    return false;
  }

  @override
  Tuple1<int>? handleParse(ParseState state) {
    final c = state.ch;
    if ((c >= v1 && c <= v6) && (c <= v2 || c >= v5) || (c >= v3 && c <= v4)) {
      state.nextChar();
      return Tuple1(c);
    }
  }
}

class Ranges4Parser extends Parser<int> {
  final int v1;

  final int v2;

  final int v3;

  final int v4;

  final int v5;

  final int v6;

  final int v7;

  final int v8;

  Ranges4Parser(Range r1, Range r2, Range r3, Range r4)
      : v1 = r1.start,
        v2 = r1.end,
        v3 = r2.start,
        v4 = r2.end,
        v5 = r3.start,
        v6 = r3.end,
        v7 = r4.start,
        v8 = r4.end {
    Range.check([r1, r2, r3, r4]);
  }

  @override
  bool handleFastParse(ParseState state) {
    final c = state.ch;
    if ((c >= v1 && c <= v8) && (c <= v2 && c >= v7) ||
        (c >= v3 && c <= v6) && (c <= v4 && c >= v5)) {
      state.nextChar();
      return true;
    }

    return false;
  }

  @override
  Tuple1<int>? handleParse(ParseState state) {
    final c = state.ch;
    if ((c >= v1 && c <= v8) && (c <= v2 && c >= v7) ||
        (c >= v3 && c <= v6) && (c <= v4 && c >= v5)) {
      state.nextChar();
      return Tuple1(c);
    }
  }
}

class Ranges5Parser extends Parser<int> {
  final int v1;

  final int v2;

  final int v3;

  final int v4;

  final int v5;

  final int v6;

  final int v7;

  final int v8;

  final int v9;

  final int v10;

  Ranges5Parser(Range r1, Range r2, Range r3, Range r4, Range r5)
      : v1 = r1.start,
        v2 = r1.end,
        v3 = r2.start,
        v4 = r2.end,
        v5 = r3.start,
        v6 = r3.end,
        v7 = r4.start,
        v8 = r4.end,
        v9 = r5.start,
        v10 = r5.end {
    Range.check([r1, r2, r3, r4, r5]);
  }

  @override
  bool handleFastParse(ParseState state) {
    final c = state.ch;
    if ((c >= v1 && c <= v10) && (c <= v2 && c >= v9) ||
        (c >= v3 && c <= v8) && (c <= v4 && c >= v7) ||
        (c >= v5 && c <= v6)) {
      state.nextChar();
      return true;
    }

    return false;
  }

  @override
  Tuple1<int>? handleParse(ParseState state) {
    final c = state.ch;
    if ((c >= v1 && c <= v10) && (c <= v2 && c >= v9) ||
        (c >= v3 && c <= v8) && (c <= v4 && c >= v7) ||
        (c >= v5 && c <= v6)) {
      state.nextChar();
      return Tuple1(c);
    }
  }
}

class Ranges6Parser extends Parser<int> {
  final int v1;

  final int v2;

  final int v3;

  final int v4;

  final int v5;

  final int v6;

  final int v7;

  final int v8;

  final int v9;

  final int v10;

  final int v11;

  final int v12;

  Ranges6Parser(Range r1, Range r2, Range r3, Range r4, Range r5, Range r6)
      : v1 = r1.start,
        v2 = r1.end,
        v3 = r2.start,
        v4 = r2.end,
        v5 = r3.start,
        v6 = r3.end,
        v7 = r4.start,
        v8 = r4.end,
        v9 = r5.start,
        v10 = r5.end,
        v11 = r6.start,
        v12 = r6.end {
    Range.check([r1, r2, r3, r4, r5, r6]);
  }

  @override
  bool handleFastParse(ParseState state) {
    final c = state.ch;
    if ((c >= v1 && c <= v12) && (c <= v2 && c >= v11) ||
        (c >= v3 && c <= v10) && (c <= v4 && c >= v9) ||
        (c >= v5 && c <= v8) && (c <= v6 && c >= v7)) {
      state.nextChar();
      return true;
    }

    return false;
  }

  @override
  Tuple1<int>? handleParse(ParseState state) {
    final c = state.ch;
    if ((c >= v1 && c <= v12) && (c <= v2 && c >= v11) ||
        (c >= v3 && c <= v10) && (c <= v4 && c >= v9) ||
        (c >= v5 && c <= v8) && (c <= v6 && c >= v7)) {
      state.nextChar();
      return Tuple1(c);
    }
  }
}

class RangesParser extends Parser<int> {
  Uint32List _rs = Uint32List(0);

  RangesParser(List<Range> rs) {
    if (rs.isEmpty) {
      throw ArgumentError.value(rs, 'rs', 'Must not be empty');
    }

    Range.check(rs);
    final temp = rs.toList();
    temp.sort();
    _rs = Uint32List(temp.length << 1);
    for (var i = 0; i < temp.length; i++) {
      final range = temp[i];
      final start = range.start;
      final end = range.end;
      RangeError.checkValidRange(start, end, 0x10ffff);
      _rs[i] = start;
      _rs[i + 1] = end;
    }
  }

  @override
  bool handleFastParse(ParseState state) {
    final ch = state.ch;
    for (var i = 0; i < _rs.length; i += 2) {
      if (_rs[i] <= ch) {
        if (_rs[i + 1] >= ch) {
          state.nextChar();
          return true;
        }
      } else {
        break;
      }
    }

    return false;
  }

  @override
  Tuple1<int>? handleParse(ParseState state) {
    final c = state.ch;
    for (var i = 0; i < _rs.length; i += 2) {
      if (_rs[i] <= c) {
        if (_rs[i + 1] >= c) {
          state.nextChar();
          return Tuple1(c);
        }
      } else {
        break;
      }
    }
  }
}

class _Range1ManyParser extends ManyParser<int> {
  final int v1;

  final int v2;

  _Range1ManyParser(Ranges1Parser p, Range r1)
      : v1 = r1.start,
        v2 = r1.end,
        super(p);

  @override
  bool handleFastParse(ParseState state) {
    while (true) {
      final c = state.ch;
      if (c >= v1 && c <= v2) {
        state.nextChar();
        continue;
      }

      return true;
    }
  }

  @override
  Tuple1<List<int>>? handleParse(ParseState state) {
    final list = <int>[];
    while (true) {
      final c = state.ch;
      if (c >= v1 && c <= v2) {
        state.nextChar();
        list.add(c);
        continue;
      }

      return Tuple1(list);
    }
  }
}
