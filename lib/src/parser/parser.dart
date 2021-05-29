part of '../../parser.dart';

const inline = pragma('vm:prefer-inline');

class DummyParser<E> extends Parser<E> {
  @override
  bool fastParse(ParseState state) {
    throw UnsupportedError('fastParse');
  }

  @override
  Tuple1<E>? parse(ParseState state) {
    throw UnsupportedError('parse');
  }
}

abstract class Parser<E> {
  bool fastParse(ParseState state);

  @Deprecated("Can be removed")
  bool fastParseSepBy(ParseState state, Parser sep) {
    if (!fastParse(state)) {
      return true;
    }

    while (true) {
      final ch = state.ch;
      final pos = state.pos;
      if (!sep.fastParse(state)) {
        break;
      }

      if (!fastParse(state)) {
        state.pos = pos;
        state.ch = ch;
        break;
      }
    }

    return true;
  }

  Tuple1<E>? parse(ParseState state);

  @Deprecated("Can be removed")
  Tuple1<List<E>>? parseSepBy(ParseState state, Parser sep) {
    final r1 = parse(state);
    if (r1 == null) {
      return Tuple1(<E>[]);
    }

    final list = [r1.$0];
    while (true) {
      final ch = state.ch;
      final pos = state.pos;
      if (!sep.fastParse(state)) {
        break;
      }

      final r2 = parse(state);
      if (r2 == null) {
        state.pos = pos;
        state.ch = ch;
        break;
      }

      list.add(r2.$0);
    }

    return Tuple1(list);
  }
}
