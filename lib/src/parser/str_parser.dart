part of '../../parser.dart';

/// Creates the [StrParser] parser.
StrParser str<E>(String s) => StrParser(s);

/// The [StrParser] parser consumes the string [s].
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
  }

  @override
  @inline
  bool fastParse(ParseState state) {
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
  Tuple1<String>? parse(ParseState state) {
    if (state.ch == _c) {
      if (state.source.startsWith(s, state.pos)) {
        state.pos += s.length;
        state.getChar(state.pos);
        return _res;
      }
    }
  }
}
