part of '../../parser.dart';

class DummyParseState extends ParseState {
  DummyParseState(ParseState state) : super(state.source, init: false) {
    ch = state.ch;
    pos = state.pos;
  }

  @override
  void fail(String name, int pos) {
    return;
  }
}

class ParseState {
  static const int eof = 1114112;

  int ch = 0;

  int failPos = 0;

  Buffer<String> failures = Buffer(100);

  final int length;

  int pos = 0;

  final String source;

  ParseState(this.source, {bool init = true}) : length = source.length {
    if (init) {
      getChar(0);
    }
  }

  FormatException buildError({String? quote = '\''}) {
    quote ??= '';
    final sink = StringBuffer();
    final expected = _getExpected();
    if (expected.isNotEmpty) {
      sink.write('Expected ');
      sink.write(expected.map((e) => e).join(', '));
    } else {
      sink.write('Unexpected ');
      if (failPos < pos) {
        sink.write('character');
      } else {
        sink.write('end of file');
      }
    }

    return FormatException(sink.toString(), source, failPos);
  }

  @inline
  void fail(String name, int pos) {
    if (failPos > pos) {
      return;
    }

    if (failPos < pos) {
      failPos = pos;
      failures.clear();
    }

    failures.add(name);
  }

  @inline
  void failAll(List<String> names, int pos) {
    if (failPos > pos) {
      return;
    }

    if (failPos < pos) {
      failPos = pos;
      failures.clear();
    }

    failures.addAll(names);
  }

  int getChar(int pos) {
    if (pos < length) {
      final c = source.codeUnitAt(pos);
      ch = c;
      if (c < 0xD800) {
        return c;
      }

      return _getChar32(pos);
    }

    return ch = eof;
  }

  @inline
  int nextChar() {
    var c = ch;
    pos += c <= 0xffff ? 1 : 2;
    if (pos < length) {
      c = source.codeUnitAt(pos);
      ch = c;
      if (c < 0xD800 || c > 0xDFFF) {
        return c;
      }

      return _getChar32(pos);
    }

    return ch = eof;
  }

  @override
  String toString() {
    final sink = StringBuffer();
    sink.write(pos);
    sink.write(' (');
    sink.write(ch);
    sink.write('):');
    if (pos < length) {
      var rest = length - pos;
      rest = rest > 24 ? 24 : rest;
      sink.write(source.substring(pos, pos + rest));
    }

    return sink.toString();
  }

  int _getChar32(int pos) {
    var c = ch;
    if (c >= 0xD800 && c <= 0xDBFF) {
      if (pos + 1 < source.length) {
        final c2 = source.codeUnitAt(pos + 1);
        if (c2 >= 0xDC00 && c2 <= 0xDFFF) {
          c = ((c - 0xD800) << 10) + (c2 - 0xDC00) + 0x10000;
        } else {
          throw FormatException('Unpaired high surrogate', source, pos);
        }
      } else {
        throw FormatException('The source has been exhausted', source, pos);
      }
    } else {
      if (c >= 0xDC00 && c <= 0xDFFF) {
        throw FormatException(
            'UTF-16 surrogate values are illegal in UTF-32', source, pos);
      }
    }

    return ch = c;
  }

  List<String> _getExpected() {
    final result = Set<String>.from(failures).toList();
    result.sort();
    return result;
  }
}
