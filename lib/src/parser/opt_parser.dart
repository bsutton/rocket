part of '../../parser.dart';

OptParser<E> opt<E>(Parser<E> p) => OptParser(p);

class OptParser<E> extends Parser<E?> {
  final Parser<E> p;

  OptParser(this.p);

  @override
  bool fastParse(ParseState state) {
    p.fastParse(state);
    return true;
  }

  @override
  Tuple1<E?>? parse(ParseState state) {
    final r1 = p.parse(state);
    if (r1 == null) {
      return Tuple1<E?>(null);
    }

    return r1;
  }
}

extension OptParserExt<E> on Parser<E> {
  OptParser<E> get opt => OptParser(this);
}
