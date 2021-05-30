part of '../../parser.dart';

/// Creates the [BetweenParser] parser.
BetweenParser<E> between<E>(Parser p1, Parser<E> p2, Parser p3) =>
    BetweenParser(p1, p2, p3);

/// The [BetweenParser] parser executes sequentially the [p1], [p2] and [p3]
/// parsers and parses successfully if all parsers succeed.
///
/// The result is the result of parsing [p2] (between [p1] and [p3]).
///
/// Example: between(char($quote), char.many, char($quote))
class BetweenParser<E> extends Parser<E> {
  final Parser p1;

  final Parser<E> p2;

  final Parser p3;

  BetweenParser(this.p1, this.p2, this.p3);

  @override
  bool fastParse(ParseState state) {
    final ch = state.ch;
    final pos = state.pos;
    if (p1.fastParse(state)) {
      if (p2.fastParse(state)) {
        if (p3.fastParse(state)) {
          return true;
        }
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
        if (p3.fastParse(state)) {
          return r1;
        }
      }
    }

    state.pos = pos;
    state.ch = ch;
  }
}

extension BetweenParserExt<E> on Parser<E> {
  BetweenParser<E> between(Parser p1, Parser p2) => BetweenParser(p1, this, p2);
}
