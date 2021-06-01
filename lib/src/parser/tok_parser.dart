part of '../../parser.dart';

TokParser<E> tok<E>(Parser p, String label, E val, Skipper ws) =>
    TokParser(p, label, val, ws);

class TokParser<E> extends Parser<E> {
  final Parser p;

  final E val;

  final Skipper ws;

  final ExpectedError _err;

  final Tuple1<E> _res;

  TokParser(this.p, String label, this.val, this.ws)
      : _err = ExpectedError(label),
        _res = Tuple1(val) {
    this.label = label;
    quote = false;
  }

  @override
  bool handleFastParse(ParseState state) {
    final ch = state.ch;
    final pos = state.pos;
    if (p.fastParse(state)) {
      ws.skip(state);
      return true;
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
    if (p.fastParse(state)) {
      ws.skip(state);
      return _res;
    }

    state.fail(_err, pos);
    state.pos = pos;
    state.ch = ch;
  }
}
