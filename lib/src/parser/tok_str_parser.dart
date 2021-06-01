part of '../../parser.dart';

TokStrParser<E> tokStr<E>(String s, String label, E val, Skipper ws) =>
    TokStrParser(s, label, val, ws);

class TokStrParser<E> extends Parser<E> {
  final String s;

  final E val;

  final Skipper ws;

  final int _c;

  final ExpectedError _err;

  final Tuple1<E> _res;

  TokStrParser(this.s, String label, this.val, this.ws)
      : _c = s.isNotEmpty
            ? s.codeUnitAt(0)
            : throw ArgumentError.value(s, 's', 'Must not be empty'),
        _err = ExpectedError(label),
        _res = Tuple1(val) {
    this.label = label;
    quote = false;
  }

  @override
  bool handleFastParse(ParseState state) {
    final ch = state.ch;
    final pos = state.pos;
    if (state.ch == _c) {
      if (state.source.startsWith(s, pos)) {
        final pos2 = pos + s.length;
        state.pos = pos2;
        state.getChar(pos2);
        ws.skip(state);
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
    if (state.ch == _c) {
      if (state.source.startsWith(s, pos)) {
        final pos2 = pos + s.length;
        state.pos = pos2;
        state.getChar(pos2);
        ws.skip(state);
        return _res;
      }
    }

    state.fail(_err, pos);
    state.pos = pos;
    state.ch = ch;
  }
}
