part of '../../parser.dart';

/// Creates the [StrParser] parser.
StrParser str<E>(String s) => StrParser(s);

/// The [StrParser] parses successfully if it can consume the string [s].
///
/// Returns the string [s].
/// ```dart
/// final p = str('hello');
/// ```
class StrParser extends Parser<String> {
  final String s;

  int _c = 0;

  final int _length;

  final Tuple1<String> _res;

  StrParser(this.s)
      : _length = s.length << 1,
        _res = Tuple1(s) {
    if (s.isEmpty) {
      ArgumentError.value(s, 's', 'Must not be empty');
    }

    _c = s.codeUnitAt(0);
    var str = s;
    str = str.replaceAll('\r', '\\r');
    str = str.replaceAll('\n', '\\n');
    str = str.replaceAll('\t', '\\t');
    label = 'str($str)';
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
          return true;
        }
      }
    }

    state.pos = pos;
    return false;
  }

  @override
  Tuple1<String>? parse(ParseState state) {
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
          return _res;
        }
      }
    }

    state.pos = pos;
  }
}
