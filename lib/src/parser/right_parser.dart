part of '../../parser.dart';

RightParser<E> right<E>(Parser p1, Parser<E> p2) => RightParser(p1, p2);

class RightParser<E> extends Parser<E> {
  final Parser p1;

  final Parser<E> p2;

  RightParser(this.p1, this.p2);

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
    if (p1.fastParse(state)) {
      final r1 = p2.parse(state);
      if (r1 != null) {
        final v1 = r1.$0;
        return Tuple1(v1);
      }
    }

    state.pos = pos;
    state.ch = ch;
  }
}

extension RightParserExt on Parser {
  RightParser<E> right<E>(Parser<E> p) => RightParser(this, p);
}
