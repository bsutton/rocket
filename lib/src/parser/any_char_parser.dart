part of '../../parser.dart';

AnyCharParser anyChar() => AnyCharParser();

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
