part of '../../parser.dart';

/// Creates the [FailParser] parser.
FailParser<E> fail<E>(err) => FailParser(err);

/// Creates the [OrFailParser] parser.
OrFailParser<E> orFail<E>(Parser<E> p, err) => OrFailParser(p, err);

/// The [FailParser] parser invokes the method `state.fail (err, state.pos)` and
///  does not succeed.
///
/// Returns nothing.
/// ```dart
/// final p = choice2(str('true', fail(err)));
/// ```
class FailParser<E> extends Parser<E> {
  final dynamic err;

  FailParser(this.err);

  @override
  bool fastParse(ParseState state) {
    state.fail(err, state.pos);
    return false;
  }

  @override
  Tuple1<E>? parse(ParseState state) {
    state.fail(err, state.pos);
  }
}

/// The [OrFailParser] parser invokes [p] and parses successfully if [p]
/// succeed; otherwise invoke the method `state.fail (err, state.pos)` and does
/// not succeed.
///
/// Returns result of parsing [p].
/// ```dart
/// final p = choice2(str('true', fail(err)));
/// ```
class OrFailParser<E> extends Parser<E> {
  final dynamic err;

  Parser<E> p;

  OrFailParser(this.p, this.err);

  @override
  bool fastParse(ParseState state) {
    if (p.fastParse(state)) {
      return true;
    }

    state.fail(err, state.pos);
    return false;
  }

  @override
  Tuple1<E>? parse(ParseState state) {
    final r1 = p.parse(state);
    if (r1 != null) {
      return r1;
    }

    state.fail(err, state.pos);
  }
}

extension OrFailParserExt<E> on Parser<E> {
  /// Creates the [OrFailParser] parser.
  /// ```dart
  /// final p = str('true').orFail(err);
  /// ```
  OrFailParser<E> orFail(err) => OrFailParser(this, err);
}
