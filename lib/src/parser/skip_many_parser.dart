part of '../../parser.dart';

SkipManyParser skipMany(Parser p) => SkipManyParser(p);

SkipMany1Parser skipMany1(Parser p) => SkipMany1Parser(p);

class SkipMany1Parser extends Parser {
  final Parser p;

  SkipMany1Parser(this.p) {
    label = 'skipMany1($p)';
  }

  @override
  bool handleFastParse(ParseState state) => p.fastParseSkipMany1(state);

  @override
  Tuple1? handleParse(ParseState state) => p.parseSkipMany1(state);
}

class SkipManyParser extends Parser {
  final Parser p;

  SkipManyParser(this.p) {
    label = 'skipMany($p)';
  }

  @override
  bool handleFastParse(ParseState state) => p.fastParseSkipMany(state);

  @override
  Tuple1? handleParse(ParseState state) => p.parseSkipMany(state);
}

extension SkipMany1ParserExt on Parser {
  SkipMany1Parser get skipMany1 => SkipMany1Parser(this);
}

extension SkipManyParserExt on Parser {
  SkipManyParser get skipMany => SkipManyParser(this);
}
