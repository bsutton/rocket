import 'parser.dart';

export 'parser.dart';

extension ParserExt<E> on Parser<E> {
  E parseString(String s) {
    final state = ParseState(s);
    final r = parse(state);
    if (r != null) {
      return r.$0;
    }

    throw state.buildError();
  }
}
