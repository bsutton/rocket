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

  final Tuple1<String> _res;

  StrParser(this.s) : _res = Tuple1(s) {
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
  @inline
  bool handleFastParse(ParseState state) {
    if (state.ch == _c) {
      if (state.source.startsWith(s, state.pos)) {
        state.pos += s.length;
        state.getChar(state.pos);
        return true;
      }
    }

    return false;
  }

  @override
  @inline
  Tuple1<String>? handleParse(ParseState state) {
    if (state.ch == _c) {
      if (state.source.startsWith(s, state.pos)) {
        state.pos += s.length;
        state.getChar(state.pos);
        return _res;
      }
    }
  }
}
