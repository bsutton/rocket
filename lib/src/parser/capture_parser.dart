part of '../../parser.dart';

/// Creates the [CaptureParser] parser.
CaptureParser capture(Parser p) => CaptureParser(p);

/// The [CaptureParser] parser invokes passively [p] and parses succefully
/// if [p] succeed.
///
/// Returns the captured string from the start and end position of parsing [p].
/// ```dart
/// final p = capture(ranges1(Range(48, 57)).skipMany1).map(int.parse);
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
  /// final p = ranges1(Range(48, 57)).skipMany1.capture.map(int.parse);
  /// ```
  CaptureParser get capture => CaptureParser(this);
}
