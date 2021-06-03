part of '../../parser.dart';

/// Creates the [RefParser] parser.
RefParser<E> ref<E>() => RefParser();

/// The [RefParser] invokes [p] and parses successfully if [p] succeed.
///
/// Initially, the [p] is set to [DummyParser] and must be set to the required
/// parser before parsing.
///
/// Returns the result of pasing [p].
///
/// ```dart
/// final p = ref();
/// ```
class RefParser<E> extends Parser<E?> {
  Parser<E> _p = DummyParser();

  Parser<E> get p => _p;

  set p(Parser<E> p) {
    _p = p;
    label = 'ref(' + _quote(p) + ')';
  }

  @override
  bool fastParse(ParseState state) => _p.fastParse(state);

  @override
  Tuple1<E?>? parse(ParseState state) => _p.parse(state);

  @override
  Tuple1<List<E>>? parseSepBy(ParseState state, Parser sep) {
    final r1 = _p.parse(state);
    if (r1 == null) {
      return Tuple1(<E>[]);
    }

    final list = [r1.$0];
    while (true) {
      final pos = state.pos;
      if (!sep.fastParse(state)) {
        break;
      }

      final r2 = _p.parse(state);
      if (r2 == null) {
        state.pos = pos;
        break;
      }

      list.add(r2.$0);
    }

    return Tuple1(list);
  }
}
