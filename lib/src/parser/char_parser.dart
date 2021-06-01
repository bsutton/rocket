part of '../../parser.dart';

/// Creates the [CharParser] parser.
CharParser char(int c) => CharParser(c);

/// The [CharParser] parser consumes one character [c].
///
/// Returns the character [c].
/// ```dart
/// final a = char(97);
/// ```
class CharParser extends Parser<int> {
  final int c;

  final Tuple1<int> _res;

  CharParser(this.c) : _res = Tuple1(c) {
    label = '[0x${c.toRadixString(16)}]';
    quote = false;
  }

  @override
  bool handleFastParse(ParseState state) {
    if (state.ch == c) {
      state.nextChar();
      return true;
    }

    return false;
  }

  @override
  Tuple1<int>? handleParse(ParseState state) {
    if (state.ch == c) {
      state.nextChar();
      return _res;
    }
  }
}
