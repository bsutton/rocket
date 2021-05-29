part of '../../parser.dart';

AndParser and(Parser p) => AndParser(p);

class AndParser extends Parser {
  final Parser p;

  AndParser(this.p);

  @override
  bool fastParse(ParseState state) {
    final ch = state.ch;
    final pos = state.pos;
    final r1 = p.fastParse(state);
    state.pos = pos;
    state.ch = ch;
    if (!r1) {
      return false;
    }

    return true;
  }

  @override
  Tuple1? parse(ParseState state) {
    final ch = state.ch;
    final pos = state.pos;
    final r1 = p.fastParse(state);
    state.pos = pos;
    state.ch = ch;
    if (r1) {
      return const Tuple1(null);
    }
  }
}

extension AndParserExt on Parser {
  AndParser get and => AndParser(this);
}
