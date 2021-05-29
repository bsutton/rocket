part of '../../parser.dart';

CharParser char(int c) => CharParser(c);

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
