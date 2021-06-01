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
  bool handleFastParse(ParseState state) => _p.fastParse(state);

  @override
  Tuple1<E?>? handleParse(ParseState state) => _p.parse(state);
}
