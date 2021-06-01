part of '../../parser.dart';

const inline = pragma('vm:prefer-inline');

String _quote(Parser p) {
  if (p.quote) {
    return '($p)';
  }

  return '$p';
}

/// The [DummyParser] is parser that doesn't parse anything and is used as a
/// temporary stub when defining recursive parsers.
class DummyParser<E> extends Parser<E> {
  @override
  bool handleFastParse(ParseState state) {
    throw UnsupportedError('fastParse');
  }

  @override
  Tuple1<E>? handleParse(ParseState state) {
    throw UnsupportedError('parse');
  }
}

abstract class Parser<E> {
  static ParseTracer? tracer;

  bool quote = true;

  String label = '';

  /// Parses input data passively, with minimal consumption of system resources
  /// during parsing.
  ///
  /// Returns [true] if parsing was successful; otherwise returns [false].
  /// ```dart
  /// if(!fastParse(state)) {
  ///   state.fail(err, state.pos);
  /// }
  /// ```
  bool fastParse(ParseState state) {
    final t = tracer;
    if (t == null) {
      return handleFastParse(state);
    } else {
      t.enterFast(this, state);
      final r1 = handleFastParse(state);
      t.leaveFast(this, state, r1);
      return r1;
    }
  }

  @experimental
  @protected
  bool fastParseMany(ParseState state) {
    while (true) {
      if (!fastParse(state)) {
        return true;
      }
    }
  }

  @experimental
  @protected
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
  @protected
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
  @protected
  bool fastParseSkipMany(ParseState state) {
    while (fastParse(state)) {
      //
    }

    return true;
  }

  @experimental
  @protected
  bool fastParseSkipMany1(ParseState state) {
    if (!fastParse(state)) {
      return false;
    }

    while (fastParse(state)) {
      //
    }

    return true;
  }

  @protected
  bool handleFastParse(ParseState state);

  @protected
  Tuple1<E>? handleParse(ParseState state);

  /// Parses input data actively and produces the result.
  ///
  /// Returns [Tuple1] of the result if parsing was successful; otherwise
  /// returns [null].
  /// ```
  /// final r1 = p.parse(state);
  /// ```
  Tuple1<E>? parse(ParseState state) {
    final t = tracer;
    if (t == null) {
      return handleParse(state);
    } else {
      t.enter(this, state);
      final r1 = handleParse(state);
      t.leave(this, state, r1);
      return r1;
    }
  }

  @experimental
  @protected
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
  @protected
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
  @protected
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
  @protected
  Tuple1? parseSkipMany(ParseState state) {
    while (fastParse(state)) {
      //
    }

    return const Tuple1(null);
  }

  @experimental
  @protected
  Tuple1? parseSkipMany1(ParseState state) {
    if (!fastParse(state)) {
      return null;
    }

    while (fastParse(state)) {
      //
    }

    return const Tuple1(null);
  }

  @override
  String toString() {
    if (label.isNotEmpty) {
      return label;
    }

    var name = '$runtimeType';
    final index = name.indexOf('<');
    if (index != -1) {
      name = name.substring(0, index);
    }

    if (name.endsWith('Parser')) {
      name = name.substring(0, name.length - 6);
    }

    name = name[0].toLowerCase() + name.substring(1);
    return name;
  }
}

abstract class ParseTracer {
  void enter<E>(Parser<E> parser, ParseState state);

  void enterFast<E>(Parser<E> parser, ParseState state);

  void leave<E>(Parser<E> parser, ParseState state, Tuple1<E>? result);

  void leaveFast<E>(Parser<E> parser, ParseState state, bool result);
}
