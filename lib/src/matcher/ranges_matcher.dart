part of '../../matcher.dart';

RangesMatcher rangesMatcher(List<Range> ranges) => RangesMatcher(ranges);

abstract class RangesMatcher implements Matcher<int> {
  factory RangesMatcher(List<Range> ranges) {
    if (ranges.isEmpty) {
      throw ArgumentError.value(ranges, 'ranges', 'Must not be empty');
    }

    ranges = ranges.toList();
    ranges.sort();
    Range.check(ranges);
    final list = Uint64List(ranges.length << 1);
    final starts = Uint64List(ranges.length);
    final ends = Uint64List(ranges.length);
    var index1 = 0;
    var index2 = 0;
    for (final range in ranges) {
      final start = range.start;
      final end = range.end;
      list[index1++] = start;
      list[index1++] = end;
      starts[index2] = start;
      ends[index2] = end;
      index2++;
    }

    switch (list.length >> 1) {
      case 1:
        return _Ranges1Matcher(list[0], list[1]);
      case 2:
        return _Ranges2Matcher(list[0], list[1], list[2], list[3]);
      case 3:
        return _Ranges3Matcher(
            list[0], list[1], list[2], list[3], list[4], list[5]);
      case 4:
        return _Ranges4Matcher(list[0], list[1], list[2], list[3], list[4],
            list[5], list[6], list[7]);
      case 5:
        return _Ranges5Matcher(list[0], list[1], list[2], list[3], list[4],
            list[5], list[6], list[7], list[8], list[9]);
      case 6:
        return _Ranges6Matcher(list[0], list[1], list[2], list[3], list[4],
            list[5], list[6], list[7], list[8], list[9], list[10], list[11]);
      case 7:
        return _Ranges7Matcher(
            list[0],
            list[1],
            list[2],
            list[3],
            list[4],
            list[5],
            list[6],
            list[7],
            list[8],
            list[9],
            list[10],
            list[11],
            list[12],
            list[13]);
      case 8:
        return _Ranges8Matcher(
            list[0],
            list[1],
            list[2],
            list[3],
            list[4],
            list[5],
            list[6],
            list[7],
            list[8],
            list[9],
            list[10],
            list[11],
            list[12],
            list[13],
            list[14],
            list[15]);
    }

    return _RangesMatcher(starts, ends);
  }
}

class _Ranges1Matcher implements RangesMatcher {
  final int _v0;

  final int _v1;

  _Ranges1Matcher(this._v0, this._v1);

  @override
  bool match(int value) => value >= _v0 && value <= _v1;
}

class _Ranges2Matcher implements RangesMatcher {
  final int _v0;

  final int _v1;

  final int _v2;

  final int _v3;

  _Ranges2Matcher(this._v0, this._v1, this._v2, this._v3);

  @override
  bool match(int value) =>
      value >= _v0 && value <= _v3 && (value <= _v1 || value >= _v2);
}

class _Ranges3Matcher implements RangesMatcher {
  final int _v0;

  final int _v1;

  final int _v2;

  final int _v3;

  final int _v4;

  final int _v5;

  _Ranges3Matcher(this._v0, this._v1, this._v2, this._v3, this._v4, this._v5);

  @override
  bool match(int value) =>
      (value >= _v0 && value <= _v5) && (value <= _v1 || value >= _v4) ||
      (value >= _v2 && value <= _v3);
}

class _Ranges4Matcher implements RangesMatcher {
  final int _v0;

  final int _v1;

  final int _v2;

  final int _v3;

  final int _v4;

  final int _v5;

  final int _v6;

  final int _v7;

  _Ranges4Matcher(this._v0, this._v1, this._v2, this._v3, this._v4, this._v5,
      this._v6, this._v7);

  @override
  bool match(int value) =>
      (value >= _v0 && value <= _v7) && (value <= _v1 || value >= _v6) ||
      (value >= _v2 && value <= _v5) && (value <= _v3 || value >= _v4);
}

class _Ranges5Matcher implements RangesMatcher {
  final int _v0;

  final int _v1;

  final int _v2;

  final int _v3;

  final int _v4;

  final int _v5;

  final int _v6;

  final int _v7;

  final int _v8;

  final int _v9;

  _Ranges5Matcher(this._v0, this._v1, this._v2, this._v3, this._v4, this._v5,
      this._v6, this._v7, this._v8, this._v9);

  @override
  bool match(int value) =>
      (value >= _v0 && value <= _v9) && (value <= _v1 || value >= _v8) ||
      (value >= _v2 && value <= _v7) && (value <= _v3 || value >= _v6) ||
      (value >= _v4 && value <= _v5);
}

class _Ranges6Matcher implements RangesMatcher {
  final int _v0;

  final int _v1;

  final int _v2;

  final int _v3;

  final int _v4;

  final int _v5;

  final int _v6;

  final int _v7;

  final int _v8;

  final int _v9;

  final int _v10;

  final int _v11;

  _Ranges6Matcher(this._v0, this._v1, this._v2, this._v3, this._v4, this._v5,
      this._v6, this._v7, this._v8, this._v9, this._v10, this._v11);

  @override
  bool match(int value) =>
      (value >= _v0 && value <= _v11) && (value <= _v1 || value >= _v10) ||
      (value >= _v2 && value <= _v9) && (value <= _v3 || value >= _v8) ||
      (value >= _v4 && value <= _v7) && (value <= _v5 || value >= _v6);
}

class _Ranges7Matcher implements RangesMatcher {
  final int _v0;

  final int _v1;

  final int _v2;

  final int _v3;

  final int _v4;

  final int _v5;

  final int _v6;

  final int _v7;

  final int _v8;

  final int _v9;

  final int _v10;

  final int _v11;

  final int _v12;

  final int _v13;

  _Ranges7Matcher(
      this._v0,
      this._v1,
      this._v2,
      this._v3,
      this._v4,
      this._v5,
      this._v6,
      this._v7,
      this._v8,
      this._v9,
      this._v10,
      this._v11,
      this._v12,
      this._v13);

  @override
  bool match(int value) =>
      (value >= _v0 && value <= _v13) && (value <= _v1 || value >= _v12) ||
      (value >= _v2 && value <= _v11) && (value <= _v3 || value >= _v10) ||
      (value >= _v4 && value <= _v9) && (value <= _v5 || value >= _v8) ||
      (value >= _v6 && value <= _v7);
}

class _Ranges8Matcher implements RangesMatcher {
  final int _v0;

  final int _v1;

  final int _v2;

  final int _v3;

  final int _v4;

  final int _v5;

  final int _v6;

  final int _v7;

  final int _v8;

  final int _v9;

  final int _v10;

  final int _v11;

  final int _v12;

  final int _v13;

  final int _v14;

  final int _v15;

  _Ranges8Matcher(
      this._v0,
      this._v1,
      this._v2,
      this._v3,
      this._v4,
      this._v5,
      this._v6,
      this._v7,
      this._v8,
      this._v9,
      this._v10,
      this._v11,
      this._v12,
      this._v13,
      this._v14,
      this._v15);

  @override
  bool match(int value) =>
      (value >= _v0 && value <= _v15) && (value <= _v1 || value >= _v14) ||
      (value >= _v2 && value <= _v13) && (value <= _v3 || value >= _v12) ||
      (value >= _v4 && value <= _v11) && (value <= _v5 || value >= _v10) ||
      (value >= _v6 && value <= _v9) && (value <= _v7 || value >= _v8);
}

class _RangesMatcher implements RangesMatcher {
  final List<int> _ends;

  final List<int> _starts;

  _RangesMatcher(this._starts, this._ends);

  @override
  bool match(int value) {
    var low = 0;
    var high = _starts.length - 1;
    while (low <= high) {
      final mid = (low + high) >> 1;
      if (value > _ends[mid]) {
        low = mid + 1;
      } else {
        if (value >= _starts[mid]) {
          return true;
        }

        if (high == mid) {
          break;
        }

        high = mid;
      }
    }

    return false;
  }
}
