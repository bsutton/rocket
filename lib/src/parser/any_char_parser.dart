part of '../../parser.dart';

/// Creates the [AnyCharParser] parser.
AnyCharParser anyChar() => AnyCharParser();

/// The [AnyCharParser] parser consumes any character and returns that
/// character as the result.
///
/// The result is the consumed character.
///
/// Example: not(anyChar())
class AnyCharParser extends Parser<int> {
  AnyCharParser();

  @override
  bool fastParse(ParseState state) {
    if (state.pos < state.length) {
      state.nextChar();
      return true;
    }

    return false;
  }

  @override
  Tuple1<int>? parse(ParseState state) {
    if (state.pos < state.length) {
      final ch = state.ch;
      state.nextChar();
      return Tuple1(ch);
    }
  }
}
