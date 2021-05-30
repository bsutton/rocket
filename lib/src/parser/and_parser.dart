part of '../../parser.dart';

/// Creates the [AndParser] parser.
AndParser and(Parser p) => AndParser(p);

/// The [AndParser] parser is a silent positive lookahead parser, it executes
/// the [p] parser and succeeds only if the [p] parser succeeds.
///
/// The [AndParser] parser will remember the current [ParseState] before
/// executing the [p] parser and will restore the state when it finishes
/// running.
///
/// It doesn't consume any data and and removes all error messages generated
/// y the [p] parser.
///
/// Example: and(str('for'))
class AndParser extends Parser {
  final Parser p;

  AndParser(this.p);

  @override
  bool fastParse(ParseState state) {
    final ch = state.ch;
    final pos = state.pos;
    final r1 = p.fastParse(state);
    state.pos = pos;
    state.ch = ch;
    if (!r1) {
      return false;
    }

    return true;
  }

  @override
  Tuple1? parse(ParseState state) {
    final ch = state.ch;
    final pos = state.pos;
    final r1 = p.fastParse(state);
    state.pos = pos;
    state.ch = ch;
    if (r1) {
      return const Tuple1(null);
    }
  }
}

extension AndParserExt on Parser {
  AndParser get and => AndParser(this);
}
