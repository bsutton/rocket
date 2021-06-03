part of '../../parse.dart';

Never _throwError(StringParseState state) {
  final errors = state.buildErrors();
  final source = state.source;
  final failPos = state.failPos >> 1;
  throw FormatException(errors.join('\n'), source, failPos);
}

extension ParseExt<E> on Parser<E> {
  bool fastParseString(String s) {
    final state = StringParseState(s);
    if (fastParse(state)) {
      return true;
    }

    _throwError(state);
  }

  E parseString(String s) {
    final state = StringParseState(s);
    final r = parse(state);
    if (r != null) {
      return r.$0;
    }

    _throwError(state);
  }

  bool tryFastParseString(String s) {
    final state = StringParseState(s);
    return fastParse(state);
  }

  Tuple1<E>? tryParseString(String s) {
    final state = StringParseState(s);
    return parse(state);
  }
}
