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
  bool fastParse(ParseState state) => p.fastParse(state);

  @override
  Tuple1<String>? parse(ParseState state) {
    final start = state.pos;
    if (p.fastParse(state)) {
      final length = (state.pos - start) >> 1;
      final charCodes = state.data.buffer.asUint16List(start, length);
      final v1 = String.fromCharCodes(charCodes);
      return Tuple1(v1);
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
