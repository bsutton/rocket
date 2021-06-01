import 'package:rocket/parse.dart';

import 'json_parser.dart';

void main() {
  Parser.tracer = _ParseTracer();
  final text = ' {"a": 0}';
  final p = parser;
  final r = p.tryParseString(text);
  print(r);
}

class _ParseTracer extends ParseTracer {
  @override
  void enter<E>(Parser<E> parser, ParseState state) {
    _trace(parser, state, fast: false, enter: true);
  }

  @override
  void enterFast<E>(Parser<E> parser, ParseState state) {
    _trace(parser, state, fast: true, enter: true);
  }

  @override
  void leave<E>(Parser<E> parser, ParseState state, Tuple1<E>? result) {
    _trace(parser, state, fast: false, enter: false, result: result);
  }

  @override
  void leaveFast<E>(Parser<E> parser, ParseState state, bool result) {
    _trace(parser, state, fast: true, enter: false, result: result);
  }

  void _trace(Parser parser, ParseState state,
      {required bool enter, required bool fast, result}) {
    final pos = state.pos;
    final source = state.source;
    final sink = StringBuffer();

    var length = source.length - pos;
    length = length < 48 ? length : 48;
    var text = state.source.substring(pos, pos + length);
    text = text.replaceAll('\n', '\\n');
    text = text.replaceAll('\r', '\\r');
    var ok = false;
    if (!enter) {
      if (fast) {
        ok = result == true;
      } else {
        ok = result != null;
      }
    }

    sink.write(text);
    sink.write(' ');
    if (enter) {
      sink.write('>> ');
    } else {
      sink.write(ok ? 'ok ' : '<< ');
    }

    sink.write('\'$parser\'');
    sink.write(': pos ');
    sink.write(pos);
    if (!enter && !fast && ok) {
      sink.write(', ');
      sink.write('${(result as Tuple1).$0}');
    }

    print(sink);
  }
}
