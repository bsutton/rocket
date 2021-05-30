part of '../../parser.dart';

ValParser<E> val<E>(Parser p, E val) => ValParser(p, val);

class ValParser<E> extends Parser<E> {
  final Parser p;

  final E val;

  final Tuple1<E> _res;

  ValParser(this.p, this.val) : _res = Tuple1(val);

  @override
  bool fastParse(ParseState state) => p.fastParse(state);

  @override
  Tuple1<E>? parse(ParseState state) => p.fastParse(state) ? _res : null;
}

extension ValParserExt on Parser {
  ValParser<E> val<E>(E val) => ValParser(this, val);
}
