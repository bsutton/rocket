part of '../../parser.dart';

TokParser<E> tok<E>(Parser p, String label, E val, Parser ws) =>
    TokParser(p, label, val, ws);

class TokParser<E> extends Parser<E> {
  final Parser p;

  final E val;

  final Parser ws;

  final ExpectedError _err;

  final Tuple1<E> _res;

  TokParser(this.p, String label, this.val, this.ws)
      : _err = ExpectedError(label),
        _res = Tuple1(val) {
    this.label = label;
    quote = false;
  }

  @override
  bool fastParse(ParseState state) {
    final pos = state.pos;
    if (p.fastParse(state)) {
      ws.fastParse(state);
      return true;
    }

    state.fail(_err, pos);
    state.pos = pos;
    return false;
  }

  @override
  Tuple1<E>? parse(ParseState state) {
    final pos = state.pos;
    if (p.fastParse(state)) {
      ws.fastParse(state);
      return _res;
    }

    state.fail(_err, pos);
    state.pos = pos;
  }
}
