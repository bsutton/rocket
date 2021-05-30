part of '../../parser.dart';

/// Creates the [NotParser] parser.
NotParser not(Parser p) => NotParser(p);

/// The [NotParser] parser is a silent negative lookahead parser, it executes
/// the [p] parser and succeeds only if the [p] does not parse successfully.
///
/// The [NotParser] parser will remember the current [ParseState] before
/// executing the [p] parser and will restore the state when it finishes
/// running.
///
/// It doesn't consume any data and doesn't change anything.
///
/// It removes all error messages generated by the [p] parser.
class NotParser extends Parser {
  final Parser p;

  NotParser(this.p);

  @override
  bool fastParse(ParseState state) {
    final ch = state.ch;
    final pos = state.pos;
    final r1 = p.fastParse(state);
    state.pos = pos;
    state.ch = ch;
    if (r1) {
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
    if (!r1) {
      return const Tuple1(null);
    }
  }
}

extension NotParserExt on Parser {
  NotParser get not => NotParser(this);
}
