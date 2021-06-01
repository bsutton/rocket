part of '../../parser.dart';

WhiteParser white(Skipper ws) => WhiteParser(ws);

class WhiteParser extends Parser {
  final Skipper ws;

  WhiteParser(this.ws);

  @override
  bool handleFastParse(ParseState state) {
    ws.skip(state);
    return true;
  }

  @override
  Tuple1? handleParse(ParseState state) {
    ws.skip(state);
    return const Tuple1(null);
  }
}
