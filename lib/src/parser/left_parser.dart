part of '../../parser.dart';

LeftParser<E> left<E>(Parser<E> p1, Parser p2) => LeftParser(p1, p2);

class LeftParser<E> extends Parser<E> {
  final Parser<E> p1;

  final Parser p2;

  LeftParser(this.p1, this.p2);

  @override
  bool fastParse(ParseState state) {
    final ch = state.ch;
    final pos = state.pos;
    if (p1.fastParse(state)) {
      if (p2.fastParse(state)) {
        return true;
      }
    }

    state.pos = pos;
    state.ch = ch;
    return false;
  }

  @override
  Tuple1<E>? parse(ParseState state) {
    final ch = state.ch;
    final pos = state.pos;
    final r1 = p1.parse(state);
    if (r1 != null) {
      if (p2.fastParse(state)) {
        final v1 = r1.$0;
        return Tuple1(v1);
      }
    }

    state.pos = pos;
    state.ch = ch;
  }
}

extension LeftParserExt<E> on Parser<E> {
  LeftParser<E> left(Parser p) => LeftParser(this, p);
}
