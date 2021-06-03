part of '../../parser.dart';

MatchUint16Parser<E> matchUint16<E>(Matcher<int> m, E val,
        [Endian endian = Endian.big]) =>
    MatchUint16Parser(m, val, endian);

class MatchUint16Parser<E> extends Parser<E> {
  Endian endian;

  Matcher<int> m;

  E val;

  final Tuple1<E> _res;

  MatchUint16Parser(this.m, this.val, [this.endian = Endian.big])
      : _res = Tuple1(val);

  @override
  bool fastParse(ParseState state) {
    final pos = state.pos;
    if (pos + 2 <= state.length) {
      final v1 = state.data.getUint16(pos, endian);
      if (m.match(v1)) {
        state.pos += 2;
        return true;
      }
    }

    return false;
  }

  @override
  Tuple1<E>? parse(ParseState state) {
    final pos = state.pos;
    if (pos + 2 <= state.length) {
      final v1 = state.data.getUint16(pos, endian);
      if (m.match(v1)) {
        state.pos += 2;
        return _res;
      }
    }
  }
}
