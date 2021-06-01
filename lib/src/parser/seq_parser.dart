part of '../../parser.dart';

SeqParser seq(List<Parser> ps) => SeqParser(ps);

Seq2Parser seq2(Parser p1, Parser p2) => Seq2Parser(p1, p2);

Seq3Parser seq3(Parser p1, Parser p2, Parser p3) => Seq3Parser(p1, p2, p3);

Seq4Parser seq4(Parser p1, Parser p2, Parser p3, Parser p4) =>
    Seq4Parser(p1, p2, p3, p4);

Seq5Parser seq5(Parser p1, Parser p2, Parser p3, Parser p4, Parser p5) =>
    Seq5Parser(p1, p2, p3, p4, p5);

Seq6Parser seq6(
        Parser p1, Parser p2, Parser p3, Parser p4, Parser p5, Parser p6) =>
    Seq6Parser(p1, p2, p3, p4, p5, p6);

Seq7Parser seq7(Parser p1, Parser p2, Parser p3, Parser p4, Parser p5,
        Parser p6, Parser p7) =>
    Seq7Parser(p1, p2, p3, p4, p5, p6, p7);

class Seq2Parser extends Parser {
  final Parser p1;

  final Parser p2;

  Seq2Parser(this.p1, this.p2) {
    label = 'seq2($p1, $p2)';
  }

  @override
  bool handleFastParse(ParseState state) {
    final ch = state.ch;
    final pos = state.pos;
    if (p1.fastParse(state)) {
      if (p2.fastParse(state)) {
        return true;
      }
    }

    state.pos = pos;
    state.ch = ch;
    return false;
  }

  @override
  Tuple1? handleParse(ParseState state) {
    final ch = state.ch;
    final pos = state.pos;
    if (p1.fastParse(state)) {
      if (p2.fastParse(state)) {
        return const Tuple1(null);
      }
    }

    state.pos = pos;
    state.ch = ch;
  }
}

class Seq3Parser extends Parser {
  final Parser p1;

  final Parser p2;

  final Parser p3;

  Seq3Parser(this.p1, this.p2, this.p3) {
    label = 'seq3($p1, $p2, $p3)';
  }

  @override
  bool handleFastParse(ParseState state) {
    final ch = state.ch;
    final pos = state.pos;
    if (p1.fastParse(state)) {
      if (p2.fastParse(state)) {
        if (p3.fastParse(state)) {
          return true;
        }
      }
    }

    state.pos = pos;
    state.ch = ch;
    return false;
  }

  @override
  Tuple1? handleParse(ParseState state) {
    final ch = state.ch;
    final pos = state.pos;
    if (p1.fastParse(state)) {
      if (p2.fastParse(state)) {
        if (p3.fastParse(state)) {
          return const Tuple1(null);
        }
      }
    }

    state.pos = pos;
    state.ch = ch;
  }
}

class Seq4Parser extends Parser {
  final Parser p1;

  final Parser p2;

  final Parser p3;

  final Parser p4;

  Seq4Parser(this.p1, this.p2, this.p3, this.p4) {
    label = 'seq4($p1, $p2, $p3, $p4)';
  }

  @override
  bool handleFastParse(ParseState state) {
    final ch = state.ch;
    final pos = state.pos;
    if (p1.fastParse(state)) {
      if (p2.fastParse(state)) {
        if (p3.fastParse(state)) {
          if (p4.fastParse(state)) {
            return true;
          }
        }
      }
    }

    state.pos = pos;
    state.ch = ch;
    return false;
  }

  @override
  Tuple1? handleParse(ParseState state) {
    final ch = state.ch;
    final pos = state.pos;
    if (p1.fastParse(state)) {
      if (p2.fastParse(state)) {
        if (p3.fastParse(state)) {
          if (p4.fastParse(state)) {
            return const Tuple1(null);
          }
        }
      }
    }

    state.pos = pos;
    state.ch = ch;
  }
}

class Seq5Parser extends Parser {
  final Parser p1;

  final Parser p2;

  final Parser p3;

  final Parser p4;

  final Parser p5;

  Seq5Parser(this.p1, this.p2, this.p3, this.p4, this.p5) {
    label = 'seq5($p1, $p2, $p3, $p4, $p5)';
  }

  @override
  bool handleFastParse(ParseState state) {
    final ch = state.ch;
    final pos = state.pos;
    if (p1.fastParse(state)) {
      if (p2.fastParse(state)) {
        if (p3.fastParse(state)) {
          if (p4.fastParse(state)) {
            if (p5.fastParse(state)) {
              return true;
            }
          }
        }
      }
    }

    state.pos = pos;
    state.ch = ch;
    return false;
  }

  @override
  Tuple1? handleParse(ParseState state) {
    final ch = state.ch;
    final pos = state.pos;
    if (p1.fastParse(state)) {
      if (p2.fastParse(state)) {
        if (p3.fastParse(state)) {
          if (p4.fastParse(state)) {
            if (p5.fastParse(state)) {
              return const Tuple1(null);
            }
          }
        }
      }
    }

    state.pos = pos;
    state.ch = ch;
  }
}

class Seq6Parser extends Parser {
  final Parser p1;

  final Parser p2;

  final Parser p3;

  final Parser p4;

  final Parser p5;

  final Parser p6;

  Seq6Parser(this.p1, this.p2, this.p3, this.p4, this.p5, this.p6) {
    label = 'seq6($p1, $p2, $p3, $p4, $p5, $p6)';
  }

  @override
  bool handleFastParse(ParseState state) {
    final ch = state.ch;
    final pos = state.pos;
    if (p1.fastParse(state)) {
      if (p2.fastParse(state)) {
        if (p3.fastParse(state)) {
          if (p4.fastParse(state)) {
            if (p5.fastParse(state)) {
              if (p6.fastParse(state)) {
                return true;
              }
            }
          }
        }
      }
    }

    state.pos = pos;
    state.ch = ch;
    return false;
  }

  @override
  Tuple1? handleParse(ParseState state) {
    final ch = state.ch;
    final pos = state.pos;
    if (p1.fastParse(state)) {
      if (p2.fastParse(state)) {
        if (p3.fastParse(state)) {
          if (p4.fastParse(state)) {
            if (p5.fastParse(state)) {
              if (p6.fastParse(state)) {
                return const Tuple1(null);
              }
            }
          }
        }
      }
    }

    state.pos = pos;
    state.ch = ch;
  }
}

class Seq7Parser extends Parser {
  final Parser p1;

  final Parser p2;

  final Parser p3;

  final Parser p4;

  final Parser p5;

  final Parser p6;

  final Parser p7;

  Seq7Parser(this.p1, this.p2, this.p3, this.p4, this.p5, this.p6, this.p7) {
    label = 'seq7($p1, $p2, $p3, $p4, $p5, $p6, $p7)';
  }

  @override
  bool handleFastParse(ParseState state) {
    final ch = state.ch;
    final pos = state.pos;
    if (p1.fastParse(state)) {
      if (p2.fastParse(state)) {
        if (p3.fastParse(state)) {
          if (p4.fastParse(state)) {
            if (p5.fastParse(state)) {
              if (p6.fastParse(state)) {
                if (p7.fastParse(state)) {
                  return true;
                }
              }
            }
          }
        }
      }
    }

    state.pos = pos;
    state.ch = ch;
    return false;
  }

  @override
  Tuple1? handleParse(ParseState state) {
    final ch = state.ch;
    final pos = state.pos;
    if (p1.fastParse(state)) {
      if (p2.fastParse(state)) {
        if (p3.fastParse(state)) {
          if (p4.fastParse(state)) {
            if (p5.fastParse(state)) {
              if (p6.fastParse(state)) {
                if (p7.fastParse(state)) {
                  return const Tuple1(null);
                }
              }
            }
          }
        }
      }
    }

    state.pos = pos;
    state.ch = ch;
  }
}

class SeqParser extends Parser {
  final List<Parser> ps;

  SeqParser(this.ps) {
    label = 'seq(${ps.join(', ')})';
  }

  @override
  bool handleFastParse(ParseState state) {
    final ch = state.ch;
    final pos = state.pos;
    for (var i = 0; i < ps.length; i++) {
      final parser = ps[i];
      if (!parser.fastParse(state)) {
        state.pos = pos;
        state.ch = ch;
        return false;
      }
    }

    return true;
  }

  @override
  Tuple1? handleParse(ParseState state) {
    final ch = state.ch;
    final pos = state.pos;
    for (var i = 0; i < ps.length; i++) {
      final parser = ps[i];
      if (!parser.fastParse(state)) {
        state.pos = pos;
        state.ch = ch;
        return null;
      }
    }

    return const Tuple1(null);
  }
}
