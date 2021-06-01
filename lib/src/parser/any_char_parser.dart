part of '../../parser.dart';

/// Creates the [AnyCharParser] parser.
AnyCharParser anyChar() => AnyCharParser();

/// The [AnyCharParser] parser consumes any character from input.
///
/// Returns any character.
/// ```dart
/// final eof = not(anyChar());
/// ```
class AnyCharParser extends Parser<int> {
  AnyCharParser() {
    label = '.';
    quote = false;
  }

  @override
  bool handleFastParse(ParseState state) {
    if (state.pos < state.length) {
      state.nextChar();
      return true;
    }

    return false;
  }

  @override
  Tuple1<int>? handleParse(ParseState state) {
    if (state.pos < state.length) {
      final ch = state.ch;
      state.nextChar();
      return Tuple1(ch);
    }
  }
}
