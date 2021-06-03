part of '../../parser.dart';

TokStrParser<E> tokStr<E>(String s, String label, E val, Parser ws) =>
    TokStrParser(s, label, val, ws);

class TokStrParser<E> extends Parser<E> {
  final String s;

  final E val;

  final Parser ws;

  final int _c;

  final ExpectedError _err;

  final int _length;

  final Tuple1<E> _res;

  TokStrParser(this.s, String label, this.val, this.ws)
      : _c = s.isNotEmpty
            ? s.codeUnitAt(0)
            : throw ArgumentError.value(s, 's', 'Must not be empty'),
        _err = ExpectedError(label),
        _length = s.length << 1,
        _res = Tuple1(val) {
    this.label = label;
    quote = false;
  }

  @override
  bool fastParse(ParseState state) {
    final pos = state.pos;
    final data = state.data;
    if (pos + _length <= state.length) {
      final c = data.getUint16(pos, Endian.little);
      if (c == _c) {
        var ok = true;
        var newPos = pos + 2;
        for (var i = 1; i < s.length; i++) {
          final c = data.getUint16(newPos, Endian.little);
          if (c != s.codeUnitAt(i)) {
            ok = false;
            break;
          }

          newPos += 2;
        }

        if (ok) {
          state.pos = newPos;
          ws.fastParse(state);
          return true;
        }
      }
    }

    state.fail(_err, pos);
    state.pos = pos;
    return false;
  }

  @override
  Tuple1<E>? parse(ParseState state) {
    final pos = state.pos;
    final data = state.data;
    if (pos + _length <= state.length) {
      final c = data.getUint16(pos, Endian.little);
      if (c == _c) {
        var ok = true;
        var newPos = pos + 2;
        for (var i = 1; i < s.length; i++) {
          final c = data.getUint16(newPos, Endian.little);
          if (c != s.codeUnitAt(i)) {
            ok = false;
            break;
          }

          newPos += 2;
        }

        if (ok) {
          state.pos = newPos;
          ws.fastParse(state);
          return _res;
        }
      }
    }

    state.fail(_err, pos);
    state.pos = pos;
  }
}
