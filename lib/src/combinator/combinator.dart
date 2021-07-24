part of '../../combinator.dart';

Between<I, O> between<I, O>(
        AnyParser<I> open, Parser<I, O> p, AnyParser<I> close) =>
    Between(open, p, close);

Choice<I, O> choice<I, O>(List<Parser<I, O>> ps) => Choice(ps);

Choice2<I, O> choice2<I, O>(Parser<I, O> p1, Parser<I, O> p2) =>
    Choice2(p1, p2);

Choice3<I, O> choice3<I, O>(
        Parser<I, O> p1, Parser<I, O> p2, Parser<I, O> p3) =>
    Choice3(p1, p2, p3);

Choice4<I, O> choice4<I, O>(
        Parser<I, O> p1, Parser<I, O> p2, Parser<I, O> p3, Parser<I, O> p4) =>
    Choice4(p1, p2, p3, p4);

Choice5<I, O> choice5<I, O>(Parser<I, O> p1, Parser<I, O> p2, Parser<I, O> p3,
        Parser<I, O> p4, Parser<I, O> p5) =>
    Choice5(p1, p2, p3, p4, p5);

Choice6<I, O> choice6<I, O>(Parser<I, O> p1, Parser<I, O> p2, Parser<I, O> p3,
        Parser<I, O> p4, Parser<I, O> p5, Parser<I, O> p6) =>
    Choice6(p1, p2, p3, p4, p5, p6);

Choice7<I, O> choice7<I, O>(Parser<I, O> p1, Parser<I, O> p2, Parser<I, O> p3,
        Parser<I, O> p4, Parser<I, O> p5, Parser<I, O> p6, Parser<I, O> p7) =>
    Choice7(p1, p2, p3, p4, p5, p6, p7);

Many<I, O> many<I, O>(Parser<I, O> p) => Many(p);

Many1<I, O> many1<I, O>(Parser<I, O> p) => Many1(p);

Map$<I, O, O1> map<I, O, O1>(Parser<I, O> p, Mapper<O, O1> m) => Map$(p, m);

Option<I, O> option<I, O>(O x, Parser<I, O> p) => Option(x, p);

Optional<I, O> optional<I, O>(Parser<I, O> p) => Optional(p);

SepBy<I, O> sepBy<I, O>(Parser<I, O> p, AnyParser<I> sep) => SepBy(p, sep);

SepBy1<I, O> sepBy1<I, O>(Parser<I, O> p, AnyParser<I> sep) => SepBy1(p, sep);

Skip<I> skip<I>(List<AnyParser<I>> ps) => Skip(ps);

Skip2<I> skip2<I>(AnyParser<I> p1, AnyParser<I> p2) => Skip2(p1, p2);

Skip3<I> skip3<I>(AnyParser<I> p1, AnyParser<I> p2, AnyParser<I> p3) =>
    Skip3(p1, p2, p3);

Skip4<I> skip4<I>(
        AnyParser<I> p1, AnyParser<I> p2, AnyParser<I> p3, AnyParser<I> p4) =>
    Skip4(p1, p2, p3, p4);

SkipMany<I, O> skipMany<I, O>(Parser<I, O> p) => SkipMany(p);

SkipMany1<I, O> skipMany1<I, O>(Parser<I, O> p) => SkipMany1(p);

Val<I, O> val<I, O>(AnyParser<I> p, O x) => Val(p, x);

class Between<I, O> extends Parser<I, O> {
  final AnyParser<I> open;

  final Parser<I, O> p;

  final AnyParser<I> close;

  Between(this.open, this.p, this.close) {
    label = 'between(' + [open, p, close].map(Parser.quote).join(' ') + ')';
  }

  @override
  @inline
  Tuple1<O>? parse(ParseInput<I> input, ParseState state) {
    final pos = input.pos;
    if (open.parse(input, state) != null) {
      final r = p.parse(input, state);
      if (r != null) {
        if (close.parse(input, state) != null) {
          return Tuple1(r.$0);
        }
      }
    }

    input.pos = pos;
  }
}

class Choice<I, O> extends Parser<I, O> {
  final List<Parser<I, O>> ps;

  Choice(this.ps) {
    label = '(${ps.map(Parser.quote).join(' | ')})';
  }

  @override
  @inline
  Tuple1<O>? parse(ParseInput<I> input, ParseState state) {
    for (var i = 0; i < ps.length; i++) {
      final p = ps[i];
      final r = p.parse(input, state);
      if (r == null) {
        continue;
      }

      return Tuple1(r.$0);
    }
  }
}

class Choice2<I, O> extends Parser<I, O> {
  final Parser<I, O> p1;

  final Parser<I, O> p2;

  Choice2(this.p1, this.p2) {
    label = '(${[p1, p2].map(Parser.quote).join(' | ')})';
  }

  @override
  @inline
  Tuple1<O>? parse(ParseInput<I> input, ParseState state) {
    final r1 = p1.parse(input, state);
    if (r1 != null) {
      return r1;
    }

    final r2 = p2.parse(input, state);
    if (r2 != null) {
      return r2;
    }
  }
}

class Choice3<I, O> extends Parser<I, O> {
  final Parser<I, O> p1;

  final Parser<I, O> p2;

  final Parser<I, O> p3;

  Choice3(this.p1, this.p2, this.p3) {
    label = '(${[p1, p2, p3].map(Parser.quote).join(' | ')})';
  }

  @override
  @inline
  Tuple1<O>? parse(ParseInput<I> input, ParseState state) {
    final r1 = p1.parse(input, state);
    if (r1 != null) {
      return r1;
    }

    final r2 = p2.parse(input, state);
    if (r2 != null) {
      return r2;
    }

    final r3 = p3.parse(input, state);
    if (r3 != null) {
      return r3;
    }
  }
}

class Choice4<I, O> extends Parser<I, O> {
  final Parser<I, O> p1;

  final Parser<I, O> p2;

  final Parser<I, O> p3;

  final Parser<I, O> p4;

  Choice4(this.p1, this.p2, this.p3, this.p4) {
    label = '(${[p1, p2, p3, p4].map(Parser.quote).join(' | ')})';
  }

  @override
  @inline
  Tuple1<O>? parse(ParseInput<I> input, ParseState state) {
    final r1 = p1.parse(input, state);
    if (r1 != null) {
      return r1;
    }

    final r2 = p2.parse(input, state);
    if (r2 != null) {
      return r2;
    }

    final r3 = p3.parse(input, state);
    if (r3 != null) {
      return r3;
    }

    final r4 = p4.parse(input, state);
    if (r4 != null) {
      return r4;
    }
  }
}

class Choice5<I, O> extends Parser<I, O> {
  final Parser<I, O> p1;

  final Parser<I, O> p2;

  final Parser<I, O> p3;

  final Parser<I, O> p4;

  final Parser<I, O> p5;

  Choice5(this.p1, this.p2, this.p3, this.p4, this.p5) {
    label = '(${[p1, p2, p3, p4, p5].map(Parser.quote).join(' | ')})';
  }

  @override
  @inline
  Tuple1<O>? parse(ParseInput<I> input, ParseState state) {
    final r1 = p1.parse(input, state);
    if (r1 != null) {
      return r1;
    }

    final r2 = p2.parse(input, state);
    if (r2 != null) {
      return r2;
    }

    final r3 = p3.parse(input, state);
    if (r3 != null) {
      return r3;
    }

    final r4 = p4.parse(input, state);
    if (r4 != null) {
      return r4;
    }

    final r5 = p5.parse(input, state);
    if (r5 != null) {
      return r5;
    }
  }
}

class Choice6<I, O> extends Parser<I, O> {
  final Parser<I, O> p1;

  final Parser<I, O> p2;

  final Parser<I, O> p3;

  final Parser<I, O> p4;

  final Parser<I, O> p5;

  final Parser<I, O> p6;

  Choice6(this.p1, this.p2, this.p3, this.p4, this.p5, this.p6) {
    label = '(${[p1, p2, p3, p4, p5, p6].map(Parser.quote).join(' | ')})';
  }

  @override
  @inline
  Tuple1<O>? parse(ParseInput<I> input, ParseState state) {
    final r1 = p1.parse(input, state);
    if (r1 != null) {
      return r1;
    }

    final r2 = p2.parse(input, state);
    if (r2 != null) {
      return r2;
    }

    final r3 = p3.parse(input, state);
    if (r3 != null) {
      return r3;
    }

    final r4 = p4.parse(input, state);
    if (r4 != null) {
      return r4;
    }

    final r5 = p5.parse(input, state);
    if (r5 != null) {
      return r5;
    }

    final r6 = p6.parse(input, state);
    if (r6 != null) {
      return r6;
    }
  }
}

class Choice7<I, O> extends Parser<I, O> {
  final Parser<I, O> p1;

  final Parser<I, O> p2;

  final Parser<I, O> p3;

  final Parser<I, O> p4;

  final Parser<I, O> p5;

  final Parser<I, O> p6;

  final Parser<I, O> p7;

  Choice7(this.p1, this.p2, this.p3, this.p4, this.p5, this.p6, this.p7) {
    label = '(${[p1, p2, p3, p4, p5, p6, p7].map(Parser.quote).join(' | ')})';
  }

  @override
  @inline
  Tuple1<O>? parse(ParseInput<I> input, ParseState state) {
    final r1 = p1.parse(input, state);
    if (r1 != null) {
      return r1;
    }

    final r2 = p2.parse(input, state);
    if (r2 != null) {
      return r2;
    }

    final r3 = p3.parse(input, state);
    if (r3 != null) {
      return r3;
    }

    final r4 = p4.parse(input, state);
    if (r4 != null) {
      return r4;
    }

    final r5 = p5.parse(input, state);
    if (r5 != null) {
      return r5;
    }

    final r6 = p6.parse(input, state);
    if (r6 != null) {
      return r6;
    }

    final r7 = p7.parse(input, state);
    if (r7 != null) {
      return r7;
    }
  }
}

class Many<I, O> extends Parser<I, List<O>> {
  final Parser<I, O> p;

  final Many1<I, O> _p;

  Many(this.p) : _p = Many1(p) {
    label = '${Parser.quote(p)}*';
  }

  @override
  @inline
  Tuple1<List<O>>? parse(ParseInput<I> input, ParseState state) {
    return _p.parse(input, state) ?? const Tuple1([]);
  }
}

class Many1<I, O> extends Parser<I, List<O>> {
  final Parser<I, O> p;

  Many1(this.p) {
    label = '${Parser.quote(p)}+';
  }

  @override
  @inline
  Tuple1<List<O>>? parse(ParseInput<I> input, ParseState state) {
    final r1 = p.parse(input, state);
    if (r1 != null) {
      final list = [r1.$0];
      while (true) {
        final r2 = p.parse(input, state);
        if (r2 == null) {
          return Tuple1(list);
        }

        list.add(r2.$0);
      }
    }
  }
}

class Map$<I, O, O1> extends Parser<I, O1> {
  final Parser<I, O> p;

  final Mapper<O, O1> m;

  Map$(this.p, this.m) {
    label = 'map($p $m)';
  }

  @override
  @inline
  Tuple1<O1>? parse(ParseInput<I> input, ParseState state) {
    final r = p.parse(input, state);
    if (r != null) {
      return Tuple1(m.map(r.$0));
    }
  }
}

class Option<I, O> extends Parser<I, O> {
  final Parser<I, O> p;

  final O x;

  final Tuple1<O> _res;

  Option(this.x, this.p) : _res = Tuple1(x) {
    label = 'option(${Parser.quote(p)} $x)';
  }

  @override
  @inline
  Tuple1<O>? parse(ParseInput<I> input, ParseState state) {
    final r = p.parse(input, state);
    if (r != null) {
      return r;
    } else {
      return _res;
    }
  }
}

class Optional<I, O> extends Parser<I, O?> {
  final Parser<I, O> p;

  Optional(this.p) {
    label = '${Parser.quote(p)}?';
  }

  @override
  @inline
  Tuple1<O?>? parse(ParseInput<I> input, ParseState state) {
    final r = p.parse(input, state);
    if (r == null) {
      return const Tuple1(null);
    }

    return Tuple1(r.$0);
  }
}

class SepBy<I, O> extends Parser<I, List<O>> {
  final Parser<I, O> p;

  final Parser sep;

  final SepBy1<I, O> _p;

  SepBy(this.p, this.sep) : _p = SepBy1(p, sep) {
    label = 'sepBy${[p, sep].map(Parser.quote).join(' ')})';
  }

  @override
  @inline
  Tuple1<List<O>>? parse(ParseInput<I> input, ParseState state) {
    return _p.parse(input, state) ?? const Tuple1([]);
  }
}

class SepBy1<I, O> extends Parser<I, List<O>> {
  final Parser<I, O> p;

  final Parser sep;

  SepBy1(this.p, this.sep) {
    label = 'sepBy1${[p, sep].map(Parser.quote).join(' ')})';
  }

  @override
  @inline
  Tuple1<List<O>>? parse(ParseInput<I> input, ParseState state) {
    final r1 = p.parse(input, state);
    if (r1 != null) {
      final list = [r1.$0];
      while (true) {
        final pos = input.pos;
        if (sep.parse(input, state) != null) {
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

class SepEndBy<I, O> extends Parser<I, List<O>> {
  final Parser<I, O> p;

  final Parser sep;

  final SepEndBy1<I, O> _p;

  SepEndBy(this.p, this.sep) : _p = SepEndBy1(p, sep) {
    label = 'sepEndBy${[p, sep].map(Parser.quote).join(' ')})';
  }

  @override
  @inline
  Tuple1<List<O>>? parse(ParseInput<I> input, ParseState state) {
    return _p.parse(input, state) ?? const Tuple1([]);
  }
}

class SepEndBy1<I, O> extends Parser<I, List<O>> {
  final Parser<I, O> p;

  final Parser sep;

  SepEndBy1(this.p, this.sep) {
    label = 'sepEndBy1${[p, sep].map(Parser.quote).join(' ')})';
  }

  @override
  @inline
  Tuple1<List<O>>? parse(ParseInput<I> input, ParseState state) {
    final r1 = p.parse(input, state);
    if (r1 != null) {
      final list = [r1.$0];
      while (true) {
        if (sep.parse(input, state) != null) {
          final r2 = p.parse(input, state);
          if (r2 != null) {
            list.add(r2.$0);
            continue;
          }
        }

        return Tuple1(list);
      }
    }
  }
}

class Skip<I> extends AnyParser<I> {
  final List<AnyParser<I>> ps;

  Skip(this.ps) {
    label = ps.map(Parser.quote).join(' ');
  }

  @override
  Tuple1? parse(ParseInput<I> input, ParseState state) {
    final pos = input.pos;
    for (var i = 0; i < ps.length; i++) {
      final p = ps[i];
      if (p.parse(input, state) == null) {
        return null;
      }

      return const Tuple1(null);
    }

    input.pos = pos;
  }
}

class Skip2<I> extends AnyParser<I> {
  final AnyParser<I> p1;

  final AnyParser<I> p2;

  Skip2(this.p1, this.p2) {
    label = [p1, p2].map(Parser.quote).join(' ');
  }

  @override
  Tuple1? parse(ParseInput<I> input, ParseState state) {
    final pos = input.pos;
    if (p1.parse(input, state) != null) {
      if (p2.parse(input, state) != null) {
        return const Tuple1(null);
      }
    }

    input.pos = pos;
  }
}

class Skip3<I> extends AnyParser<I> {
  final AnyParser<I> p1;

  final AnyParser<I> p2;

  final AnyParser<I> p3;

  Skip3(this.p1, this.p2, this.p3) {
    label = [p1, p2, p3].map(Parser.quote).join(' ');
  }

  @override
  Tuple1? parse(ParseInput<I> input, ParseState state) {
    final pos = input.pos;
    if (p1.parse(input, state) != null) {
      if (p2.parse(input, state) != null) {
        if (p3.parse(input, state) != null) {
          return const Tuple1(null);
        }
      }
    }

    input.pos = pos;
  }
}

class Skip4<I> extends AnyParser<I> {
  final AnyParser<I> p1;

  final AnyParser<I> p2;

  final AnyParser<I> p3;

  final AnyParser<I> p4;

  Skip4(this.p1, this.p2, this.p3, this.p4) {
    label = [p1, p2, p3, p4].map(Parser.quote).join(' ');
  }

  @override
  Tuple1? parse(ParseInput<I> input, ParseState state) {
    final pos = input.pos;
    if (p1.parse(input, state) != null) {
      if (p2.parse(input, state) != null) {
        if (p3.parse(input, state) != null) {
          if (p4.parse(input, state) != null) {
            return const Tuple1(null);
          }
        }
      }
    }

    input.pos = pos;
  }
}

class SkipMany<I, O> extends AnyParser<I> {
  final Parser<I, O> p;

  SkipMany(this.p) {
    label = 'skipMany(${Parser.quote(p)})';
  }

  @override
  @inline
  Tuple1? parse(ParseInput<I> input, ParseState state) {
    while (p.parse(input, state) != null) {
      // Nothing
    }

    return const Tuple1(null);
  }
}

class SkipMany1<I, O> extends AnyParser<I> {
  final Parser<I, O> p;

  SkipMany1(this.p) {
    label = 'skipMany1(${Parser.quote(p)})';
  }

  @override
  @inline
  Tuple1? parse(ParseInput<I> input, ParseState state) {
    if (p.parse(input, state) != null) {
      while (p.parse(input, state) != null) {
        // Nothing
      }

      return const Tuple1(null);
    }
  }
}

class Tuple2$<I, O1, O2> extends Parser<I, Tuple2<O1, O2>> {
  final Parser<I, O1> p1;

  final Parser<I, O2> p2;

  Tuple2$(this.p1, this.p2) {
    label = 'tuple2(' + [p1, p2].map(Parser.quote).join(' ') + ')';
  }

  @override
  Tuple1<Tuple2<O1, O2>>? parse(ParseInput<I> input, ParseState state) {
    final pos = input.pos;
    final r1 = p1.parse(input, state);
    if (r1 != null) {
      final r2 = p2.parse(input, state);
      if (r2 != null) {
        final v1 = Tuple2(r1.$0, r2.$0);
        return Tuple1(v1);
      }
    }

    input.pos = pos;
  }
}

class Tuple3$<I, O1, O2, O3> extends Parser<I, Tuple3<O1, O2, O3>> {
  final Parser<I, O1> p1;

  final Parser<I, O2> p2;

  final Parser<I, O3> p3;

  Tuple3$(this.p1, this.p2, this.p3) {
    label = 'tuple3(' + [p1, p2, p3].map(Parser.quote).join(' ') + ')';
  }

  @override
  Tuple1<Tuple3<O1, O2, O3>>? parse(ParseInput<I> input, ParseState state) {
    final pos = input.pos;
    final r1 = p1.parse(input, state);
    if (r1 != null) {
      final r2 = p2.parse(input, state);
      if (r2 != null) {
        final r3 = p3.parse(input, state);
        if (r3 != null) {
          final v1 = Tuple3(r1.$0, r2.$0, r3.$0);
          return Tuple1(v1);
        }
      }
    }

    input.pos = pos;
  }
}

class Tuple4$<I, O1, O2, O3, O4> extends Parser<I, Tuple4<O1, O2, O3, O4>> {
  final Parser<I, O1> p1;

  final Parser<I, O2> p2;

  final Parser<I, O3> p3;

  final Parser<I, O4> p4;

  Tuple4$(this.p1, this.p2, this.p3, this.p4) {
    label = 'tuple4(' + [p1, p2, p3, p4].map(Parser.quote).join(' ') + ')';
  }

  @override
  Tuple1<Tuple4<O1, O2, O3, O4>>? parse(ParseInput<I> input, ParseState state) {
    final pos = input.pos;
    final r1 = p1.parse(input, state);
    if (r1 != null) {
      final r2 = p2.parse(input, state);
      if (r2 != null) {
        final r3 = p3.parse(input, state);
        if (r3 != null) {
          final r4 = p4.parse(input, state);
          if (r4 != null) {
            final v1 = Tuple4(r1.$0, r2.$0, r3.$0, r4.$0);
            return Tuple1(v1);
          }
        }
      }
    }

    input.pos = pos;
  }
}

class Tuple5$<I, O1, O2, O3, O4, O5>
    extends Parser<I, Tuple5<O1, O2, O3, O4, O5>> {
  final Parser<I, O1> p1;

  final Parser<I, O2> p2;

  final Parser<I, O3> p3;

  final Parser<I, O4> p4;

  final Parser<I, O5> p5;

  Tuple5$(this.p1, this.p2, this.p3, this.p4, this.p5) {
    label = 'tuple5(' + [p1, p2, p3, p4, p5].map(Parser.quote).join(' ') + ')';
  }

  @override
  Tuple1<Tuple5<O1, O2, O3, O4, O5>>? parse(
      ParseInput<I> input, ParseState state) {
    final pos = input.pos;
    final r1 = p1.parse(input, state);
    if (r1 != null) {
      final r2 = p2.parse(input, state);
      if (r2 != null) {
        final r3 = p3.parse(input, state);
        if (r3 != null) {
          final r4 = p4.parse(input, state);
          if (r4 != null) {
            final r5 = p5.parse(input, state);
            if (r5 != null) {
              final v1 = Tuple5(r1.$0, r2.$0, r3.$0, r4.$0, r5.$0);
              return Tuple1(v1);
            }
          }
        }
      }
    }

    input.pos = pos;
  }
}

class Tuple6$<I, O1, O2, O3, O4, O5, O6>
    extends Parser<I, Tuple6<O1, O2, O3, O4, O5, O6>> {
  final Parser<I, O1> p1;

  final Parser<I, O2> p2;

  final Parser<I, O3> p3;

  final Parser<I, O4> p4;

  final Parser<I, O5> p5;

  final Parser<I, O6> p6;

  Tuple6$(this.p1, this.p2, this.p3, this.p4, this.p5, this.p6) {
    label =
        'tuple6(' + [p1, p2, p3, p4, p5, p6].map(Parser.quote).join(' ') + ')';
  }

  @override
  Tuple1<Tuple6<O1, O2, O3, O4, O5, O6>>? parse(
      ParseInput<I> input, ParseState state) {
    final pos = input.pos;
    final r1 = p1.parse(input, state);
    if (r1 != null) {
      final r2 = p2.parse(input, state);
      if (r2 != null) {
        final r3 = p3.parse(input, state);
        if (r3 != null) {
          final r4 = p4.parse(input, state);
          if (r4 != null) {
            final r5 = p5.parse(input, state);
            if (r5 != null) {
              final r6 = p6.parse(input, state);
              if (r6 != null) {
                final v1 = Tuple6(r1.$0, r2.$0, r3.$0, r4.$0, r5.$0, r6.$0);
                return Tuple1(v1);
              }
            }
          }
        }
      }
    }

    input.pos = pos;
  }
}

class Tuple7$<I, O1, O2, O3, O4, O5, O6, O7>
    extends Parser<I, Tuple7<O1, O2, O3, O4, O5, O6, O7>> {
  final Parser<I, O1> p1;

  final Parser<I, O2> p2;

  final Parser<I, O3> p3;

  final Parser<I, O4> p4;

  final Parser<I, O5> p5;

  final Parser<I, O6> p6;

  final Parser<I, O7> p7;

  Tuple7$(this.p1, this.p2, this.p3, this.p4, this.p5, this.p6, this.p7) {
    label = 'tuple7(' +
        [p1, p2, p3, p4, p5, p6, p7].map(Parser.quote).join(' ') +
        ')';
  }

  @override
  Tuple1<Tuple7<O1, O2, O3, O4, O5, O6, O7>>? parse(
      ParseInput<I> input, ParseState state) {
    final pos = input.pos;
    final r1 = p1.parse(input, state);
    if (r1 != null) {
      final r2 = p2.parse(input, state);
      if (r2 != null) {
        final r3 = p3.parse(input, state);
        if (r3 != null) {
          final r4 = p4.parse(input, state);
          if (r4 != null) {
            final r5 = p5.parse(input, state);
            if (r5 != null) {
              final r6 = p6.parse(input, state);
              if (r6 != null) {
                final r7 = p7.parse(input, state);
                if (r7 != null) {
                  final v1 =
                      Tuple7(r1.$0, r2.$0, r3.$0, r4.$0, r5.$0, r6.$0, r7.$0);
                  return Tuple1(v1);
                }
              }
            }
          }
        }
      }
    }

    input.pos = pos;
  }
}

class Val<I, O> extends Parser<I, O> {
  final AnyParser<I> p;

  final Tuple1<O> _res;

  Val(this.p, O x) : _res = Tuple1(x) {
    label = 'val($p $x)';
  }

  @override
  @inline
  Tuple1<O>? parse(ParseInput<I> input, ParseState state) {
    final r = p.parse(input, state);
    if (r != null) {
      return _res;
    }
  }
}

extension CombinatorExt<I, O> on Parser<I, O> {
  Between<I, O> between(AnyParser<I> open, AnyParser<I> close) =>
      Between(open, this, close);

  Map$<I, O, O1> map<O1>(Mapper<O, O1> m) => Map$(this, m);

  Many<I, O> get many => Many(this);

  Many1<I, O> get many1 => Many1(this);

  Option<I, O> option(O x) => Option(x, this);

  Optional<I, O> get optional => Optional(this);

  SepBy<I, O> sepBy(AnyParser<I> sep) => SepBy(this, sep);

  SepBy1<I, O> sepBy1(AnyParser<I> sep) => SepBy1(this, sep);

  SkipMany<I, O> get skipMany => SkipMany(this);

  SkipMany1<I, O> get skipMany1 => SkipMany1(this);

  Val<I, O2> val<O2>(O2 x) => Val(this, x);
}
