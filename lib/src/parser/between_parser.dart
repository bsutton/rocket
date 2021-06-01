part of '../../parser.dart';

/// Creates the [BetweenParser] parser.
BetweenParser<E> between<E>(Parser p1, Parser<E> p2, Parser p3) =>
    BetweenParser(p1, p2, p3);

/// The [BetweenParser] parser invokes sequentially [p1], [p2] and [p3] and
/// parses successfully if all parsers succeed.
///
/// Returns the result of [p2].
/// ```
/// final string = between(char($quote), char.many, char($quote));
/// ```
class BetweenParser<E> extends Parser<E> {
  final Parser p1;

  final Parser<E> p2;

  final Parser p3;

  BetweenParser(this.p1, this.p2, this.p3) {
    label = 'between(' + [p1, p2, p3].map(_quote).join(' ') + ')';
  }

  @override
  bool handleFastParse(ParseState state) {
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
  Tuple1<E>? handleParse(ParseState state) {
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
  /// Creates the [BetweenParser] parser.
  /// ```dart
  /// final p = chars.many.between(quote, quote);
  /// ```
  BetweenParser<E> between(Parser p1, Parser p2) => BetweenParser(p1, this, p2);
}
