part of '../../token.dart';

Angles<O> angles<O>(StringParser<O> p, AnyStringParser ws) => Angles(p, ws);

Braces<O> braces<O>(StringParser<O> p, AnyStringParser ws) => Braces(p, ws);

Brackets<O> brackets<O>(StringParser<O> p, AnyStringParser ws) =>
    Brackets(p, ws);

Colon colon<O>(AnyStringParser ws) => Colon(ws);

Comma comma<O>(AnyStringParser ws) => Comma(ws);

CommaSep<O> commaSep<O>(StringParser<O> p, AnyStringParser ws) =>
    CommaSep(p, ws);

Dot dot<O>(AnyStringParser ws) => Dot(ws);

EnclosedInSymbolics<O> enclosedInSymbolics<O>(
        int open, int close, StringParser<O> p, AnyStringParser ws) =>
    EnclosedInSymbolics(open, close, p, ws);

Eof eof() => Eof();

KeyValue<O1, O2> keyValue<O1, O2>(StringParser<O1> key, StringParser<O2> value,
        int sep, AnyStringParser ws) =>
    KeyValue(key, value, sep, ws);

Parens<O> parens<O>(StringParser<O> p, AnyStringParser ws) => Parens(p, ws);

SepBySymbolic<O> sepBySymbolic<O>(
        StringParser<O> p, int c, AnyStringParser ws) =>
    SepBySymbolic(p, c, ws);

SepBySymbolic1<O> sepBySymbolic1<O>(
        StringParser<O> p, int c, AnyStringParser ws) =>
    SepBySymbolic1(p, c, ws);

Symbol symbol(String s, AnyStringParser ws) => Symbol(s, ws);

Symbolic symbolic(int c, AnyStringParser ws) => Symbolic(c, ws);

Token<O> token<O>(String label, StringParser<O> p, AnyStringParser ws) =>
    Token(label, p, ws);

class Angles<O> extends EnclosedInSymbolics<O> {
  Angles(StringParser<O> p, AnyStringParser ws)
      : super($open_angle, $close_angle, p, ws);
}

class Braces<O> extends EnclosedInSymbolics<O> {
  Braces(StringParser<O> p, AnyStringParser ws)
      : super($open_brace, $close_brace, p, ws);
}

class Brackets<O> extends EnclosedInSymbolics<O> {
  Brackets(StringParser<O> p, AnyStringParser ws)
      : super($open_bracket, $close_bracket, p, ws);
}

class Colon extends Symbolic {
  Colon(AnyStringParser ws) : super($colon, ws);
}

class Comma extends Symbolic {
  Comma(AnyStringParser ws) : super($comma, ws);
}

class CommaSep<O> extends SepBySymbolic<O> {
  CommaSep(StringParser<O> p, AnyStringParser ws) : super(p, $comma, ws);
}

class Dot extends Symbolic {
  Dot(AnyStringParser ws) : super($dot, ws);
}

class EnclosedInSymbolics<O> extends StringParser<O> {
  final int close;

  final int open;

  final StringParser<O> p;

  final AnyStringParser ws;

  ParseError? _closeError;

  ParseError? _openError;

  EnclosedInSymbolics(this.open, this.close, this.p, this.ws) {
    checkUtf16CodePoint(open);
    checkUtf16CodePoint(close);
    final printableOpen = printableChar(open);
    final printableClose = printableChar(close);
    label = '$printableOpen ' + Parser.quote(p) + ' $printableClose';
    _closeError = ParseError.expected(printableOpen);
    _openError = ParseError.expected(printableClose);
  }

  @override
  @inline
  Tuple1<O>? parse(ParseInput<String> input, ParseState state) {
    final pos = input.pos;
    if (input.match(open)) {
      ws.parse(input, state);
      final r = p.parse(input, state);
      if (r != null) {
        if (input.match(close)) {
          ws.parse(input, state);
          return Tuple1(r.$0);
        } else {
          state.fail(_closeError, input.pos);
        }
      }
    } else {
      state.fail(_openError, input.pos);
    }

    input.pos = pos;
  }
}

class Eof extends AnyStringParser {
  @override
  Tuple1? parse(ParseInput<String> input, ParseState state) {
    if (input.pos >= input.source.length) {
      return const Tuple1(null);
    }
  }
}

class KeyValue<O1, O2> extends StringParser<Tuple2<O1, O2>> {
  final StringParser<O1> key;

  final int sep;

  final StringParser<O2> value;

  final AnyStringParser ws;

  KeyValue(this.key, this.value, this.sep, this.ws) {
    checkUtf16CodePoint(sep);
    final printableSep = printableChar(sep);
    label =
        'keyValue(${Parser.quote(key)} $printableSep ${Parser.quote(value)} ${Parser.quote(ws)})';
    error = ParseError.expected(printableSep);
  }

  @override
  @inline
  Tuple1<Tuple2<O1, O2>>? parse(ParseInput<String> input, ParseState state) {
    final pos = input.pos;
    final r1 = key.parse(input, state);
    if (r1 != null) {
      if (input.match(sep)) {
        ws.parse(input, state);
        final r2 = value.parse(input, state);
        if (r2 != null) {
          return Tuple1(Tuple2(r1.$0, r2.$0));
        }
      } else {
        state.fail(error, input.pos);
      }
    }

    input.pos = pos;
  }
}

class Parens<O> extends EnclosedInSymbolics<O> {
  Parens(StringParser<O> p, AnyStringParser ws)
      : super($open_paren, $close_paren, p, ws);
}

class SepBySymbolic<O> extends StringParser<List<O>> {
  final int c;

  final StringParser<O> p;

  final AnyStringParser ws;

  final SepBySymbolic1<O> _p;

  SepBySymbolic(this.p, this.c, this.ws) : _p = SepBySymbolic1(p, c, ws) {
    checkUtf16CodePoint(c);
    final printableC = printableChar(c);
    label = 'sepBy(${Parser.quote(p)} $printableC)';
  }

  @override
  @inline
  Tuple1<List<O>>? parse(ParseInput<String> input, ParseState state) {
    return _p.parse(input, state) ?? const Tuple1([]);
  }
}

class SepBySymbolic1<O> extends StringParser<List<O>> {
  final int c;

  final StringParser<O> p;

  final AnyStringParser ws;

  SepBySymbolic1(this.p, this.c, this.ws) {
    checkUtf16CodePoint(c);
    final printableC = printableChar(c);
    label = 'sepBy1(${Parser.quote(p)} $printableC)';
  }

  @override
  @inline
  Tuple1<List<O>>? parse(ParseInput<String> input, ParseState state) {
    final r1 = p.parse(input, state);
    if (r1 != null) {
      final list = [r1.$0];
      while (true) {
        final pos = input.pos;
        if (input.match(c)) {
          ws.parse(input, state);
          final r2 = p.parse(input, state);
          if (r2 == null) {
            input.pos = pos;
            return Tuple1(list);
          }

          list.add(r2.$0);
          continue;
        }

        return Tuple1(list);
      }
    }
  }
}

class Symbol extends StringParser<String> {
  final String s;

  final AnyStringParser ws;

  final Tuple1<String> _res;

  Symbol(this.s, this.ws) : _res = Tuple1(s) {
    final label = printableString(s);
    error = ParseError.expected(label);
  }

  @override
  @inline
  Tuple1<String>? parse(ParseInput<String> input, ParseState state) {
    if (input.matchString(s)) {
      ws.parse(input, state);
      return _res;
    }

    state.fail(error, input.pos);
  }
}

class Symbolic extends StringParser<int> {
  final int c;

  final AnyStringParser ws;

  final Tuple1<int> _res;

  Symbolic(this.c, this.ws) : _res = Tuple1(c) {
    checkUtf16CodePoint(c);
    final label = printableChar(c);
    error = ParseError.expected(label);
  }

  @override
  @inline
  Tuple1<int>? parse(ParseInput<String> input, ParseState state) {
    if (input.ch == c) {
      input.pos++;
      ws.parse(input, state);
      return _res;
    }

    state.fail(error, input.pos);
  }
}

class Token<O> extends StringParser<O> {
  final StringParser<O> p;

  final AnyStringParser ws;

  Token(String label, this.p, this.ws) {
    this.label = label;
    error = ParseError.expected(label);
  }

  @override
  @inline
  Tuple1<O>? parse(ParseInput<String> input, ParseState state) {
    final r = p.parse(input, state);
    if (r != null) {
      ws.parse(input, state);
      return r;
    }

    state.fail(error, input.pos);
  }
}
