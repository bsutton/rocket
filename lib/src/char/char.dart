part of '../../char.dart';

Capture capture(AnyStringParser p) => Capture(p);

Char char(int c) => Char(c);

Digit digit() => Digit();

OneOf oneOf(List<int> cs) => OneOf(cs);

Satisfy satisfy(Matcher<int> m) => Satisfy(m);

String$ string(String s) => String$(s);

class Capture extends StringParser<String> {
  final AnyStringParser p;

  Capture(this.p) {
    label = 'capture(${Parser.quote(p)})';
  }

  @override
  Tuple1<String>? parse(ParseInput<String> input, ParseState state) {
    final start = input.pos;
    if (p.parse(input, state) != null) {
      final source = input.source;
      final pos = input.pos;
      return Tuple1(source.substring(start, pos));
    }
  }
}

class Char extends StringParser<int> {
  final int c;

  final Tuple1<int> _res;

  Char(this.c) : _res = Tuple1(c) {
    label = printableChar(c);
    error = ParseError.expected(label);
  }

  @override
  Tuple1<int>? parse(ParseInput<String> input, ParseState state) {
    if (input.match(c)) {
      return _res;
    }

    state.fail(error, input.pos);
  }
}

class Digit extends StringParser<int> {
  Digit() {
    label = 'digit';
    error = ParseError.expected(label);
  }

  @override
  Tuple1<int>? parse(ParseInput<String> input, ParseState state) {
    final c = input.ch;
    if (c >= 0x30 && c <= 0x39) {
      input.pos++;
      return Tuple1(c);
    }

    state.fail(error, input.pos);
  }
}

class OneOf extends StringParser<int> {
  final List<int> cs;

  OneOf(this.cs) {
    label = 'one of (${cs.map(printableChar).join(' ')})';
    error = ParseError.expected(label);
  }

  @override
  Tuple1<int>? parse(ParseInput<String> input, ParseState state) {
    final c = input.ch;
    for (var i = 0; i < cs.length; i++) {
      if (cs[i] == c) {
        input.pos++;
        return Tuple1(c);
      }
    }

    state.fail(error, input.pos);
  }
}

class Satisfy extends StringParser<int> {
  final Matcher<int> m;

  Satisfy(this.m) {
    label = 'satisfy($m)';
  }

  @override
  Tuple1<int>? parse(ParseInput<String> input, ParseState state) {
    final c = input.ch;
    if (m.match(c)) {
      return Tuple1(c);
    }

    state.fail(error, input.pos);
  }
}

class String$ extends StringParser<String> {
  final String s;

  final Tuple1<String> _res;

  String$(this.s) : _res = Tuple1(s) {
    label = printableString(s);
    error = ParseError.expected(label);
  }

  @override
  Tuple1<String>? parse(ParseInput<String> input, ParseState state) {
    if (input.matchString(s)) {
      return _res;
    }

    state.fail(error, input.pos);
  }
}

extension CaptureExt on AnyStringParser {
  Capture get capture => Capture(this);
}
