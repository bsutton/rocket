part of '../../parser.dart';

/// Creates the [CaptureParser] parser.
CaptureParser capture(Parser p) => CaptureParser(p);

/// Parser [CaptureParser] executes passively parser [p] and consumes the
/// string from the start and end positions of parsing [p] if parsing [p]
/// succeed.
///
/// The result is the consumed string.
///
/// Example: capture(p)
class CaptureParser extends Parser<String> {
  final Parser p;

  CaptureParser(this.p);

  @override
  bool fastParse(ParseState state) {
    if (p.fastParse(state)) {
      return true;
    }

    return false;
  }

  @override
  Tuple1<String>? parse(ParseState state) {
    final start = state.pos;
    if (p.fastParse(state)) {
      final result = state.source.substring(start, state.pos);
      return Tuple1(result);
    }
  }
}

extension CaptureParserExt on Parser {
  CaptureParser get capture => CaptureParser(this);
}
