part of '../../parser.dart';

/// Creates the [ValParser] parser.
ValParser<E> val<E>(Parser p, E val) => ValParser(p, val);

/// The [ValParser] invokes passively [p] and parses successfully if [p]
/// succeed.
///
/// Returns [val].
/// ```
/// final p = val(str('true'), true);
/// ```
class ValParser<E> extends Parser<E> {
  final Parser p;

  final E val;

  final Tuple1<E> _res;

  ValParser(this.p, this.val) : _res = Tuple1(val);

  @override
  bool fastParse(ParseState state) => p.fastParse(state);

  @override
  Tuple1<E>? parse(ParseState state) => p.fastParse(state) ? _res : null;
}

extension ValParserExt on Parser {
  /// Creates the [ValParser] parser.
  /// ```dart
  /// final p = str('true').val(true);
  /// ```
  ValParser<E> val<E>(E val) => ValParser(this, val);
}
