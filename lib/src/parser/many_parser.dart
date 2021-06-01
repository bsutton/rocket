part of '../../parser.dart';

ManyParser<E> many<E>(Parser<E> p) => ManyParser(p);

Many1Parser<E> many1<E>(Parser<E> p) => Many1Parser(p);

class Many1Parser<E> extends Parser<List<E>> {
  final Parser<E> p;

  Many1Parser(this.p) {
    label = _quote(p) + '+';
    quote = false;
  }

  @override
  bool handleFastParse(ParseState state) => p.fastParseMany1(state);

  @override
  Tuple1<List<E>>? handleParse(ParseState state) => p.parseMany1(state);
}

class ManyParser<E> extends Parser<List<E>> {
  final Parser<E> p;

  ManyParser(this.p) {
    label = _quote(p) + '*';
    quote = false;
  }

  @override
  bool handleFastParse(ParseState state) => p.fastParseMany(state);

  @override
  Tuple1<List<E>>? handleParse(ParseState state) => p.parseMany(state);
}

extension Many1ParserExt<E> on Parser<E> {
  Many1Parser<E> get many1 => Many1Parser(this);
}

extension ManyParserExt<E> on Parser<E> {
  ManyParser<E> get many => ManyParser(this);
}
