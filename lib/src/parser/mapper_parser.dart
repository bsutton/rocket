part of '../../parser.dart';

/// Creates the [MapperParser] parser.
MapperParser<I, O> mapper<I, O>(Parser<I> p, Mapper<I, O> m) =>
    MapperParser(p, m);

/// The [MapperParser] invokes [p] and parses successfully if [p] succeed.
///
/// Returns the result of invoking `m.map` with the result of parsing [p] as an
/// argument.
/// ```
/// final p = mapper(chars, m);
/// ```
class MapperParser<I, O> extends Parser<O> {
  final Mapper<I, O> m;

  final Parser<I> p;

  MapperParser(this.p, this.m);

  @override
  bool fastParse(ParseState state) => p.fastParse(state);

  @override
  Tuple1<O>? parse(ParseState state) {
    final r1 = p.parse(state);
    if (r1 != null) {
      final v1 = r1.$0;
      final v2 = m.map(v1);
      return Tuple1(v2);
    }
  }
}

extension MapperParserExt<I> on Parser<I> {
  /// Creates the [MapperParser] parser.
  /// ```dart
  /// final p = chars.map(String.fromCharCodes);
  /// ```
  MapperParser<I, O> mapper<O>(Mapper<I, O> m) => MapperParser(this, m);
}
