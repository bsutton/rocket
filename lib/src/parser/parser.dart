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

  @experimental
  bool fastParseMany(ParseState state) {
    while (true) {
      if (!fastParse(state)) {
        return true;
      }
    }
  }

  @experimental
  bool fastParseMany1(ParseState state) {
    if (!fastParse(state)) {
      return false;
    }

    while (true) {
      if (!fastParse(state)) {
        return true;
      }
    }
  }

  @experimental
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

  @experimental
  bool fastParseSkipMany1(ParseState state) {
    if (!fastParse(state)) {
      return false;
    }

    while (fastParse(state)) {
      //
    }

    return true;
  }

  @experimental
  bool fastParseSkipMany(ParseState state) {
    while (fastParse(state)) {
      //
    }

    return true;
  }

  Tuple1<E>? parse(ParseState state);

  @experimental
  Tuple1<List<E>>? parseMany(ParseState state) {
    final r1 = parse(state);
    if (r1 == null) {
      return Tuple1(<E>[]);
    }

    final list = [r1.$0];
    while (true) {
      final r1 = parse(state);
      if (r1 == null) {
        return Tuple1(list);
      }

      list.add(r1.$0);
    }
  }

  @experimental
  Tuple1<List<E>>? parseMany1(ParseState state) {
    final r1 = parse(state);
    if (r1 == null) {
      return null;
    }

    final list = [r1.$0];
    while (true) {
      final r1 = parse(state);
      if (r1 == null) {
        return Tuple1(list);
      }

      list.add(r1.$0);
    }
  }

  @experimental
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

  @experimental
  Tuple1? parseSkipMany(ParseState state) {
    while (fastParse(state)) {
      //
    }

    return const Tuple1(null);
  }

  @experimental
  Tuple1? parseSkipMany1(ParseState state) {
    if (!fastParse(state)) {
      return null;
    }

    while (fastParse(state)) {
      //
    }

    return const Tuple1(null);
  }
}
