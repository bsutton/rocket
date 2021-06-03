part of '../../parser.dart';

/// Creates the [AroundParser] parser.
AroundParser<E1, E2> around<E1, E2>(Parser<E1> p1, Parser p2, Parser<E2> p3) =>
    AroundParser(p1, p2, p3);

/// The [AroundParser] parser invokes sequentially [p1], [p2] and [p3] and
/// parses successfully if all parsers succeed.
///
/// Returns [Tuple2] of parsing results [p1] and [p3].
/// ```dart
/// final member = around(string, colon, value);
/// ```
class AroundParser<E1, E2> extends Parser<Tuple2<E1, E2>> {
  final Parser<E1> p1;

  final Parser p2;

  final Parser<E2> p3;

  AroundParser(this.p1, this.p2, this.p3) {
    label = 'around(' + [p1, p2, p3].map(_quote).join(' ') + ')';
    quote = false;
  }

  @override
  bool fastParse(ParseState state) {
    final pos = state.pos;
    if (p1.fastParse(state)) {
      if (p2.fastParse(state)) {
        if (p3.fastParse(state)) {
          return true;
        }
      }
    }

    state.pos = pos;
    return false;
  }

  @override
  Tuple1<Tuple2<E1, E2>>? parse(ParseState state) {
    final pos = state.pos;
    final r1 = p1.parse(state);
    if (r1 != null) {
      if (p2.fastParse(state)) {
        final r2 = p3.parse(state);
        if (r2 != null) {
          final v1 = Tuple2(r1.$0, r2.$0);
          return Tuple1(v1);
        }
      }
    }

    state.pos = pos;
  }
}

extension AroundParserExt on Parser {
  /// Creates the [AroundParser] parser.
  /// ```dart
  /// final p = colon.around(string, value);
  /// ```
  AroundParser<E1, E2> around<E1, E2>(Parser<E1> p1, Parser<E2> p2) =>
      AroundParser(p1, this, p2);
}
