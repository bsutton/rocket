part of '../../parser.dart';

/// Creates the [LeftParser] parser.
LeftParser<E> left<E>(Parser<E> p1, Parser p2) => LeftParser(p1, p2);

/// The [LeftParser] parser invokes sequentially [p1] and [p2] and parses
/// successfully if all parsers succeed.
///
/// Returns the result of parsing [p1].
/// ```dart
/// final p = left(p1, p2);
/// ```
class LeftParser<E> extends Parser<E> {
  final Parser<E> p1;

  final Parser p2;

  LeftParser(this.p1, this.p2) {
    label = [p1, p2].map(_quote).join(' .=> ');
  }

  @override
  bool handleFastParse(ParseState state) {
    final ch = state.ch;
    final pos = state.pos;
    if (p1.fastParse(state)) {
      if (p2.fastParse(state)) {
        return true;
      }
    }

    state.pos = pos;
    state.ch = ch;
    return false;
  }

  @override
  Tuple1<E>? handleParse(ParseState state) {
    final ch = state.ch;
    final pos = state.pos;
    final r1 = p1.parse(state);
    if (r1 != null) {
      if (p2.fastParse(state)) {
        final v1 = r1.$0;
        return Tuple1(v1);
      }
    }

    state.pos = pos;
    state.ch = ch;
  }
}

extension LeftParserExt<E> on Parser<E> {
  /// Creates the [LeftParser] parser.
  /// ```dart
  /// final p = p1.left(p2);
  /// ```
  LeftParser<E> left(Parser p) => LeftParser(this, p);
}
