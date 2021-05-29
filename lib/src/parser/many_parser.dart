part of '../../parser.dart';

ManyParser<E> many<E>(Parser<E> p) => ManyParser(p);

Many1Parser<E> many1<E>(Parser<E> p) => Many1Parser(p);

class Many1Parser<E> extends Parser<List<E>> {
  final Parser<E> p;

  Many1Parser(this.p);

  @override
  bool fastParse(ParseState state) {
    if (!p.fastParse(state)) {
      return false;
    }

    while (true) {
      if (!p.fastParse(state)) {
        return true;
      }
    }
  }

  @override
  Tuple1<List<E>>? parse(ParseState state) {
    final r1 = p.parse(state);
    if (r1 == null) {
      return null;
    }

    final list = [r1.$0];
    while (true) {
      final r1 = p.parse(state);
      if (r1 == null) {
        return Tuple1(list);
      }

      list.add(r1.$0);
    }
  }
}

class ManyParser<E> extends Parser<List<E>> {
  final Parser<E> p;

  ManyParser(this.p);

  @override
  bool fastParse(ParseState state) {
    while (true) {
      if (!p.fastParse(state)) {
        return true;
      }
    }
  }

  @override
  Tuple1<List<E>>? parse(ParseState state) {
    final r1 = p.parse(state);
    if (r1 == null) {
      return Tuple1(<E>[]);
    }

    final list = [r1.$0];
    while (true) {
      final r1 = p.parse(state);
      if (r1 == null) {
        return Tuple1(list);
      }

      list.add(r1.$0);
    }
  }
}

extension Many1ParserExt<E> on Parser<E> {
  Many1Parser<E> get many1 => Many1Parser(this);
}

extension ManyParserExt<E> on Parser<E> {
  ManyParser<E> get many => ManyParser(this);
}
