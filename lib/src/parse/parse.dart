part of '../../parse.dart';

extension ParseExt<E> on Parser<E> {
  bool fastParseString(String s) {
    final state = ParseState(s);
    if (fastParse(state)) {
      return true;
    }

    throw state.buildError();
  }

  E parseString(String s) {
    final state = ParseState(s);
    final r = parse(state);
    if (r != null) {
      return r.$0;
    }

    throw state.buildError();
  }

  bool tryFastParseString(String s) {
    final state = ParseState(s);
    return fastParse(state);
  }

  Tuple1<E>? tryParseString(String s) {
    final state = ParseState(s);
    return parse(state);
  }
}
