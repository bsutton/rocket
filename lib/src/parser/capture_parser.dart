part of '../../parser.dart';

/// Creates the [CaptureParser] parser.
CaptureParser capture(Parser p) => CaptureParser(p);

/// Parser [CaptureParser] invokes passively [p] and consumes the string from
/// the start and end positions of parsing [p] if parsing [p] succeed.
///
/// Returns the consumed string.
/// ```
/// final n = capture(ranges1(Range(48, 57)).skipMany1).map(int.parse);
/// ```
class CaptureParser extends Parser<String> {
  final Parser p;

  CaptureParser(this.p) {
    label = '<' + _quote(p) + '>';
    quote = false;
  }

  @override
  bool handleFastParse(ParseState state) {
    if (p.fastParse(state)) {
      return true;
    }

    return false;
  }

  @override
  Tuple1<String>? handleParse(ParseState state) {
    final start = state.pos;
    if (p.fastParse(state)) {
      final result = state.source.substring(start, state.pos);
      return Tuple1(result);
    }
  }
}

extension CaptureParserExt on Parser {
  /// Creates the [CaptureParser] parser.
  /// ```dart
  /// final n = ranges1(Range(48, 57)).skipMany1.capture.map(int.parse);
  /// ```
  CaptureParser get capture => CaptureParser(this);
}
