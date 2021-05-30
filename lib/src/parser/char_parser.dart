part of '../../parser.dart';

/// Creates the [CharParser] parser.
CharParser char(int c) => CharParser(c);

/// The [CharParser] parser consumes one character [c].
///
/// The result is the consumed character [c].
///
/// Example: char(48)
class CharParser extends Parser<int> {
  final int c;

  final Tuple1<int> _res;

  CharParser(this.c) : _res = Tuple1(c);

  @override
  bool fastParse(ParseState state) {
    if (state.ch == c) {
      state.nextChar();
      return true;
    }

    return false;
  }

  @override
  Tuple1<int>? parse(ParseState state) {
    if (state.ch == c) {
      state.nextChar();
      return _res;
    }
  }
}
