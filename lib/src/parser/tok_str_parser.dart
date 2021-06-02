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
      final source = state.source;
      final length = s.length;
      var ok = true;
      var newPos = pos + 1;
      if (pos + length <= state.length) {
        for (var i = 1; i < length; i++) {
          final ch = source.codeUnitAt(newPos++);
          if (ch != s.codeUnitAt(i)) {
            ok = false;
            break;
          }
        }

        if (ok) {
          state.pos = newPos;
          state.getChar(newPos);
          ws.skip(state);
          return true;
        }
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
      final source = state.source;
      final length = s.length;
      var ok = true;
      var newPos = pos + 1;
      if (pos + length <= state.length) {
        for (var i = 1; i < length; i++) {
          final ch = source.codeUnitAt(newPos++);
          if (ch != s.codeUnitAt(i)) {
            ok = false;
            break;
          }
        }

        if (ok) {
          state.pos = newPos;
          state.getChar(newPos);
          ws.skip(state);
          return _res;
        }
      }
    }

    state.fail(_err, pos);
    state.pos = pos;
    state.ch = ch;
  }
}
