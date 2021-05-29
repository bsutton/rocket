part of '../../parser.dart';

CaptureParser capture(Parser p) => CaptureParser(p);

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
