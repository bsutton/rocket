part of '../../parser.dart';

/// Creates the [MapParser] parser.
MapParser<I, O> map<I, O>(Parser<I> p, O Function(I) f) => MapParser(p, f);

/// The [MapParser] invokes [p] and parses successfully if [p] succeed.
///
/// Returns the result of invoking [f] with the result of parsing [p] as an
/// argument.
/// ```
/// final p = map(chars, String.fromCharCodes);
/// ```
class MapParser<I, O> extends Parser<O> {
  final O Function(I) f;

  final Parser<I> p;

  MapParser(this.p, this.f);

  @override
  bool handleFastParse(ParseState state) => p.fastParse(state);

  @override
  Tuple1<O>? handleParse(ParseState state) {
    final r1 = p.parse(state);
    if (r1 != null) {
      final v1 = r1.$0;
      final v2 = f(v1);
      return Tuple1(v2);
    }
  }
}

extension MapParserExt<I> on Parser<I> {
  /// Creates the [MapParser] parser.
  /// ```dart
  /// final p = chars.map(String.fromCharCodes);
  /// ```
  MapParser<I, O> map<O>(O Function(I) f) => MapParser(this, f);
}
