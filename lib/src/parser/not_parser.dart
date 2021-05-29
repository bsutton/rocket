part of '../../parser.dart';

NotParser not(Parser p) => NotParser(p);

class NotParser extends Parser {
  final Parser p;

  NotParser(this.p);

  @override
  bool fastParse(ParseState state) {
    final ch = state.ch;
    final pos = state.pos;
    final r1 = p.fastParse(state);
    state.pos = pos;
    state.ch = ch;
    if (r1) {
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
    if (!r1) {
      return const Tuple1(null);
    }
  }
}

extension NotParserExt on Parser {
  NotParser get not => NotParser(this);
}
