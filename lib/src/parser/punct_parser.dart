part of '../../parser.dart';

class PunctParser extends Parser {
  final int c;

  final String name;

  final Parser ws;

  PunctParser(this.name, this.c, this.ws);

  @override
  bool fastParse(ParseState state) {
    if (state.ch == c) {
      state.nextChar();
      ws.fastParse(state);
      return true;
    }

    state.fail(name, state.pos);
    return false;
  }

  @override
  Tuple1? parse(ParseState state) {
    if (state.ch == c) {
      state.nextChar();
      ws.fastParse(state);
      return const Tuple1(null);
    }

    state.fail(name, state.pos);
  }
}
