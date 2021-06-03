part of '../../matcher.dart';

IntMatcher intMatcher(List<int> values) => IntMatcher(values);

abstract class IntMatcher implements Matcher<int> {
  factory IntMatcher(List<int> values) {
    if (values.isEmpty) {
      throw ArgumentError.value(values, 'values', 'Must not be empty');
    }

    final list = values.toList();
    switch (values.length) {
      case 1:
        return _Int1Matcher(list[0]);
      case 2:
        return _Int2Matcher(list[0], list[1]);
      case 3:
        return _Int3Matcher(list[0], list[1], list[2]);
      case 4:
        return _Int4Matcher(list[0], list[1], list[2], list[3]);
      case 5:
        return _Int5Matcher(list[0], list[1], list[2], list[3], list[4]);
    }

    return _IntMatcher(list);
  }
}

class _Int1Matcher implements IntMatcher {
  final int _v0;

  _Int1Matcher(this._v0);

  @override
  bool match(int value) => value == _v0;
}

class _Int2Matcher implements IntMatcher {
  final int _v0;

  final int _v1;

  _Int2Matcher(this._v0, this._v1);

  @override
  bool match(int value) => value == _v0 || value == _v1;
}

class _Int3Matcher implements IntMatcher {
  final int _v0;

  final int _v1;

  final int _v2;

  _Int3Matcher(this._v0, this._v1, this._v2);

  @override
  bool match(int value) => value == _v0 || value == _v1 || value == _v2;
}

class _Int4Matcher implements IntMatcher {
  final int _v0;

  final int _v1;

  final int _v2;

  final int _v3;

  _Int4Matcher(this._v0, this._v1, this._v2, this._v3);

  @override
  bool match(int value) =>
      value == _v0 || value == _v1 || value == _v2 || value == _v3;
}

class _Int5Matcher implements IntMatcher {
  final int _v0;

  final int _v1;

  final int _v2;

  final int _v3;

  final int _v4;

  _Int5Matcher(this._v0, this._v1, this._v2, this._v3, this._v4);

  @override
  bool match(int value) =>
      value == _v0 ||
      value == _v1 ||
      value == _v2 ||
      value == _v3 ||
      value == _v4;
}

class _IntMatcher implements IntMatcher {
  final List<int> _values;

  _IntMatcher(this._values);

  @override
  bool match(int value) {
    var low = 0;
    var high = _values.length - 1;
    while (low <= high) {
      final mid = (low + high) >> 1;
      if (value > _values[mid]) {
        low = mid + 1;
      } else {
        if (value == _values[mid]) {
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
