part of '../../parser.dart';

TokChar16Parser<E> tokChar16<E>(int c, String label, E val, Parser ws) =>
    TokChar16Parser(c, label, val, ws);

class TokChar16Parser<E> extends Parser<E> {
  final int c;

  final E val;

  final Parser ws;

  final ExpectedError _err;

  final Tuple1<E> _res;

  TokChar16Parser(this.c, String label, this.val, this.ws)
      : _err = ExpectedError(label),
        _res = Tuple1(val) {
    if (c >= 0xd800 && c <= 0xdfff) {
      throw RangeError.value(c, 'c', 'Not a valid UTF-16 character');
    }

    this.label = label;
    quote = false;
  }

  @override
  bool fastParse(ParseState state) {
    final pos = state.pos;
    if (pos + 2 <= state.length) {
      final ch = state.data.getUint16(pos, Endian.little);
      if (ch == c) {
        state.pos += 2;
        ws.fastParse(state);
        return true;
      }
    }

    state.fail(_err, pos);
    state.pos = pos;
    return false;
  }

  @override
  Tuple1<E>? parse(ParseState state) {
    final pos = state.pos;
    if (pos + 2 <= state.length) {
      final ch = state.data.getUint16(pos, Endian.little);
      if (ch == c) {
        state.pos += 2;
        ws.fastParse(state);
        return _res;
      }
    }

    state.fail(_err, pos);
    state.pos = pos;
  }
}
