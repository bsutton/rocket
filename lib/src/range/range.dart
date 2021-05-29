part of '../../range.dart';

class Range implements Comparable<Range> {
  int end;

  int start;

  Range(this.start, this.end) {
    RangeError.checkValidRange(start, end, end);
  }

  @override
  int get hashCode => start ^ end;

  @override
  bool operator ==(other) {
    if (other is Range) {
      return other.start == start && other.end == end;
    }

    return false;
  }

  @override
  int compareTo(Range other) {
    if (start > other.start) {
      return 1;
    } else if (start < other.start) {
      return -1;
    } else if (end > other.end) {
      return 1;
    } else if (end < other.end) {
      return -1;
    }

    return 0;
  }

  @override
  String toString() => '[$start..$end]';

  static check(List<Range> list) {
    list = list.toList();
    list.sort();
    Range? prev;
    for (var i = 0; i < list.length; i++) {
      final range = list[i];
      if (prev != null) {
        if (range.start <= prev.end) {
          throw ArgumentError('Overlapping elements $prev and $range');
        }
      }

      prev = range;
    }
  }
}
