import 'package:rocket/parser.dart';
import 'package:stack_trace/stack_trace.dart';

import 'example.dart';

void main() {
  final source = ' [true, 10.2]';
  final state = DebugParserState(source);
  final r = parser.parse(state);
  if (r == null) {
    throw state.buildError();
  }

  print(r.$0);
}

class DebugParserState extends ParseState {
  int indent = 0;

  DebugParserState(String source) : super(source);

  void _printSource() {
    var rest = length - pos;
    rest = rest > 48 ? 48 : rest;
    var str = source.substring(pos, pos + rest);
    str = str.replaceAll('\n', '\\n');
    str = str.replaceAll('\r', '\\r');
    print(str);
  }

  void _trace() {
    final st = StackTrace.current;
    final trace = Trace.from(st);
    final frames = trace.frames;
    final sink = StringBuffer();
    final members = <String>[];

    bool isParser(String method) {
      const methods = ['fastParse', 'parse'];
      return methods.contains(method);
    }

    var isFirst = true;
    for (var i = 0; i < frames.length; i++) {
      final frame = frames[i];
      final member = frame.member;
      if (member == null) {
        continue;
      }

      final parts = member.split('.');
      if (parts.length != 2) {
        continue;
      }

      final type = parts[0];
      final method = parts[1];
      if (!isParser(method)) {
        continue;
      }

      if (isFirst) {
        isFirst = false;
        members.add(type);
      } else {
        if (type.startsWith('_')) {
          members.add(type);
        }
      }
    }

    sink.write(members.reversed.join(' => '));
    print(sink);
  }

  @override
  set pos(int pos) {
    final inc = pos > super.pos;
    if (inc) {
      _trace();
      _printSource();
    }

    super.pos = pos;
    if (inc) {
      _printSource();
      print('---');
    }
  }
}
