part of '../../parser.dart';

/// Creates the [ExpectedParser] parser.
ExpectedParser<E> expected<E>(Parser<E> p, String label) =>
    ExpectedParser(p, label);

/// The [ExpectedParser] parser invokes [p] and parses succefully if [p]
/// succeed.
///
/// Also set the [label] to the [p] if no label is set.
///
/// Return the result of parsing [p]; otherwise generates the error
/// [ExpectedError] using [label] as an argument.
///
/// ```dart
/// final p = expected(digit(), 'some digit');
/// ```
class ExpectedParser<E> extends Parser<E> {
  final Parser<E> p;

  final ExpectedError _err;

  ExpectedParser(this.p, String label)
      : _err = label.isNotEmpty
            ? ExpectedError(label)
            : throw ArgumentError.value(label, 'label', 'Must not be empty') {
    if (p.label.isEmpty) {
      p.label = label;
    }

    label = label;
  }

  @override
  bool fastParse(ParseState state) {
    if (p.fastParse(state)) {
      return true;
    }

    state.fail(_err, state.pos);
    return false;
  }

  @override
  Tuple1<E>? parse(ParseState state) {
    final r1 = p.parse(state);
    if (r1 != null) {
      return r1;
    }

    state.fail(_err, state.pos);
  }
}

extension ExpectedParserExt<E> on Parser<E> {
  /// Creates the [ExpectedParser] parser.
  /// ```dart
  /// final p = digit().expected('some digit');
  /// ```
  ExpectedParser<E> expected(String label) => ExpectedParser(this, label);
}
