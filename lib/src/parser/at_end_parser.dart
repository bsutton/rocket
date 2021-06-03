part of '../../parser.dart';

AtEndParser atEnd() => AtEndParser();

class AtEndParser extends Parser {
  @override
  bool fastParse(ParseState state) {
    return state.pos >= state.length;
  }

  @override
  Tuple1? parse(ParseState state) {
    if (state.pos >= state.length) {
      return const Tuple1(null);
    }
  }
}
