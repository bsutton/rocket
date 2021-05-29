part of '../../parser.dart';

SepByParser<E> sepBy<E>(Parser<E> p, Parser sep) => SepByParser(p, sep);

class SepByParser<E> extends Parser<List<E>> {
  final Parser<E> p;

  final Parser sep;

  SepByParser(this.p, this.sep);

  @override
  bool fastParse(ParseState state) => p.fastParseSepBy(state, sep);

  @override
  Tuple1<List<E>>? parse(ParseState state) => p.parseSepBy(state, sep);
}

extension SepByParserExt<E> on Parser<E> {
  SepByParser<E> sepBy(Parser sep) => SepByParser(this, sep);
}