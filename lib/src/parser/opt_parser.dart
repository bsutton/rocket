part of '../../parser.dart';

/// Creates the [OptParser] parser.
OptParser<E> opt<E>(Parser<E> p) => OptParser(p);

/// The [OptParser] invokes [p] and parses successfully.
///
/// Returns the result of pasing [p] or [null].
/// ```dart
/// final p = opt(p1);
/// ```
class OptParser<E> extends Parser<E?> {
  final Parser<E> p;

  OptParser(this.p) {
    label = _quote(p) + '?';
    quote = false;
  }

  @override
  bool handleFastParse(ParseState state) {
    p.fastParse(state);
    return true;
  }

  @override
  Tuple1<E?>? handleParse(ParseState state) {
    final r1 = p.parse(state);
    if (r1 == null) {
      return Tuple1<E?>(null);
    }

    return r1;
  }
}

extension OptParserExt<E> on Parser<E> {
  /// Creates the [OptParser] parser.
  /// ```dart
  /// final p = p1.opt;
  /// ```
  OptParser<E> get opt => OptParser(this);
}
