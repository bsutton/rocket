part of '../../parser.dart';

class DummyParseState extends ParseState {
  DummyParseState(ParseState state) : super(state.data) {
    pos = state.pos;
  }

  @override
  void fail(error, int pos) {
    return;
  }
}

class ParseState {
  int failPos = 0;

  Buffer failures = Buffer(100);

  final int length;

  int pos = 0;

  final ByteData data;

  ParseState(this.data) : length = data.lengthInBytes;

  List<String> buildErrors() {
    final result = <String>[];
    final sink = StringBuffer();
    final parseErrors = failures.whereType<ParseError>();
    if (parseErrors.isNotEmpty) {
      final keys = parseErrors.map((e) => e.key).toSet();
      for (final key in keys) {
        final elements = parseErrors.where((e) => e.key == key);
        final quoted = elements.map((e) => '\'${e.element}\'').toList();
        quoted.sort();
        sink.write(key);
        sink.write(': ');
        sink.write(quoted.join(', '));
        result.add(sink.toString());
      }
    }

    final set = failures.toSet();
    set.removeAll(parseErrors);
    for (final error in set) {
      result.add(error.toString());
    }

    return result;
  }

  @inline
  void fail(error, int pos) {
    if (failPos > pos) {
      return;
    }

    if (failPos < pos) {
      failPos = pos;
      failures.clear();
    }

    failures.add(error);
  }

  @inline
  void failAll(List errors, int pos) {
    if (failPos > pos) {
      return;
    }

    if (failPos < pos) {
      failPos = pos;
      failures.clear();
    }

    failures.addAll(errors);
  }
}

class StringParseState extends ParseState {
  final String source;

  @override
  String toString() {
    final sink = StringBuffer();
    sink.write(pos);
    sink.write(' (');
    sink.write('):');
    if (pos < length) {
      var rest = (length - pos) >> 1;
      rest = rest > 24 ? 24 : rest;
      sink.write(source.substring(pos, pos + rest));
    }

    return sink.toString();
  }

  StringParseState(this.source)
      : super(Uint16List.fromList(source.codeUnits).buffer.asByteData());
}
