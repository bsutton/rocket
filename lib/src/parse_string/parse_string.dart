part of '../../parse_string.dart';

Never _throwError(ParseState state, String source) {
  final errors = state.buildErrors();
  throw FormatException(errors.join('\n'), source, state.failPos);
}

extension ParseExt<O> on Parser<String, O> {
  O parseString(String source) {
    final input = ParseInput(source);
    final state = ParseState();
    final r = parse(input, state);
    if (r != null) {
      return r.$0;
    }

    _throwError(state, source);
  }

  Tuple1<O>? tryParseString(String source) {
    final input = ParseInput(source);
    final state = ParseState();
    return parse(input, state);
  }
}
