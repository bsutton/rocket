part of '../../parser.dart';

TokCharParser<E> tokChar<E>(int c, String label, E val, Parser ws) =>
    TokCharParser(c, label, val, ws);

class TokCharParser<E> extends Parser<E> {
  final int c;

  final E val;

  final Parser ws;

  final ExpectedError _err;

  final Tuple1<E> _res;

  TokCharParser(this.c, String label, this.val, this.ws)
      : _err = ExpectedError(label),
        _res = Tuple1(val) {
    this.label = label;
    quote = false;
  }

  @override
  bool handleFastParse(ParseState state) {
    final ch = state.ch;
    final pos = state.pos;
    if (state.ch == c) {
      state.nextChar();
      if (ws.fastParse(state)) {
        return true;
      }
    }

    state.fail(_err, pos);
    state.pos = pos;
    state.ch = ch;
    return false;
  }

  @override
  Tuple1<E>? handleParse(ParseState state) {
    final ch = state.ch;
    final pos = state.pos;
    if (state.ch == c) {
      state.nextChar();
      if (ws.fastParse(state)) {
        return _res;
      }
    }

    state.fail(_err, pos);
    state.pos = pos;
    state.ch = ch;
  }
}
