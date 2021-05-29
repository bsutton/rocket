part of '../../parser.dart';

SkipManyParser skipMany(Parser p) => SkipManyParser(p);

SkipMany1Parser skipMany1(Parser p) => SkipMany1Parser(p);

class SkipMany1Parser extends Parser {
  final Parser p;

  SkipMany1Parser(this.p);

  @override
  bool fastParse(ParseState state) {
    if (!p.fastParse(state)) {
      return false;
    }

    while (p.fastParse(state)) {
      //
    }

    return true;
  }

  @override
  Tuple1? parse(ParseState state) {
    if (!p.fastParse(state)) {
      return null;
    }

    while (p.fastParse(state)) {
      //
    }

    return const Tuple1(null);
  }
}

class SkipManyParser extends Parser {
  final Parser p;

  SkipManyParser(this.p);

  @override
  bool fastParse(ParseState state) {
    while (p.fastParse(state)) {
      //
    }

    return true;
  }

  @override
  Tuple1? parse(ParseState state) {
    while (p.fastParse(state)) {
      //
    }

    return const Tuple1(null);
  }
}

extension SkipMany1ParserExt on Parser {
  SkipMany1Parser get skipMany1 => SkipMany1Parser(this);
}

extension SkipManyParserExt on Parser {
  SkipManyParser get skipMany => SkipManyParser(this);
}
