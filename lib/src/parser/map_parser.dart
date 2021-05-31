part of '../../parser.dart';

MapParser<I, O> map<I, O>(Parser<I> p, O Function(I) f) => MapParser(p, f);

class MapParser<I, O> extends Parser<O> {
  final O Function(I) f;

  final Parser<I> p;

  MapParser(this.p, this.f);

  @override
  bool fastParse(ParseState state) => p.fastParse(state);

  @override
  Tuple1<O>? parse(ParseState state) {
    final r1 = p.parse(state);
    if (r1 != null) {
      final v1 = r1.$0;
      final v2 = f(v1);
      return Tuple1(v2);
    }
  }
}

extension MapParserExt<I> on Parser<I> {
  MapParser<I, O> map<O>(O Function(I) f) => MapParser(this, f);
}
