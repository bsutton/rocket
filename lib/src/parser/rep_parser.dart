part of '../../parser.dart';

RepParser<E> rep<E>(Parser<E> p, int min, [int? max]) => RepParser(p, min, max);

class RepParser<E> extends RepParserBase<E> {
  RepParser(Parser<E> p, int min, [int? max]) : super(p, min, max);

  @override
  bool fastParse(ParseState state) {
    final ch = state.ch;
    final pos = state.pos;
    if (!p.fastParse(state)) {
      return min == 0;
    }

    var count = 0;
    while (count < max) {
      if (!p.fastParse(state)) {
        break;
      }

      count++;
    }

    if (count >= min) {
      return true;
    }

    state.pos = pos;
    state.ch = ch;
    return false;
  }

  @override
  Tuple1<List<E>>? parse(ParseState state) {
    final ch = state.ch;
    final pos = state.pos;
    final r1 = p.parse(state);
    if (r1 == null) {
      return min == 0 ? Tuple1(<E>[]) : null;
    }

    final list = [r1.$0];
    while (list.length < max) {
      final r1 = p.parse(state);
      if (r1 == null) {
        break;
      }

      list.add(r1.$0);
    }

    if (list.length >= min) {
      return Tuple1(list);
    }

    state.pos = pos;
    state.ch = ch;
  }
}

abstract class RepParserBase<E> extends Parser<List<E>> {
  static const int maxValue = 0xffffffff;

  final int max;

  final int min;

  final Parser<E> p;

  RepParserBase(this.p, this.min, [int? max]) : max = max ?? maxValue {
    RangeError.checkValidRange(min, max, maxValue);
    if (max == 0) {
      throw ArgumentError.value(max, 'max', 'Must be greater than 0');
    }
  }
}

extension RepParserExt<E> on Parser<E> {
  RepParser<E> rep(int min, [int? max]) => RepParser(this, min, max);
}
