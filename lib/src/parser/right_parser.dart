part of '../../parser.dart';

/// Creates the [RightParser] parser.
RightParser<E> right<E>(Parser p1, Parser<E> p2) => RightParser(p1, p2);

/// The [RightParser] parser invokes sequentially [p1] and [p2] and parses
/// successfully if all parsers succeed.
///
/// Returns the result of parsing [p2].
/// ```
/// final p = right(p1, p2);
/// ```
class RightParser<E> extends Parser<E> {
  final Parser p1;

  final Parser<E> p2;

  RightParser(this.p1, this.p2) {
    label = [p1, p2].map(_quote).join(' =>. ');
  }

  @override
  bool fastParse(ParseState state) {
    final pos = state.pos;
    if (p1.fastParse(state)) {
      if (p2.fastParse(state)) {
        return true;
      }
    }

    state.pos = pos;
    return false;
  }

  @override
  Tuple1<E>? parse(ParseState state) {
    final pos = state.pos;
    if (p1.fastParse(state)) {
      final r1 = p2.parse(state);
      if (r1 != null) {
        final v1 = r1.$0;
        return Tuple1(v1);
      }
    }

    state.pos = pos;
  }
}

extension RightParserExt on Parser {
  /// Creates the [RightParser] parser.
  /// ```dart
  /// final p = p1.right(p2);
  /// ```
  RightParser<E> right<E>(Parser<E> p) => RightParser(this, p);
}
