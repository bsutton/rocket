part of '../../parser.dart';

ExpectedParser<E> expected<E>(Parser<E> p, String label) =>
    ExpectedParser(p, label);

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
  bool handleFastParse(ParseState state) {
    if (p.fastParse(state)) {
      return true;
    }

    state.fail(_err, state.pos);
    return false;
  }

  @override
  Tuple1<E>? handleParse(ParseState state) {
    final r1 = p.parse(state);
    if (r1 != null) {
      return r1;
    }

    state.fail(_err, state.pos);
  }
}

extension ExpectedParserExt<E> on Parser<E> {
  ExpectedParser<E> expected(String label) => ExpectedParser(this, label);
}
