part of '../../parser.dart';

/// Creates the [Tuple2Parser] parser.
Tuple2Parser<E1, E2> tuple2<E1, E2>(Parser<E1> p1, Parser<E2> p2) =>
    Tuple2Parser(p1, p2);

/// Creates the [Tuple3Parser] parser.
Tuple3Parser<E1, E2, E3> tuple3<E1, E2, E3>(
        Parser<E1> p1, Parser<E2> p2, Parser<E3> p3) =>
    Tuple3Parser(p1, p2, p3);

/// Creates the [Tuple4Parser] parser.
Tuple4Parser<E1, E2, E3, E4> tuple4<E1, E2, E3, E4>(
        Parser<E1> p1, Parser<E2> p2, Parser<E3> p3, Parser<E4> p4) =>
    Tuple4Parser(p1, p2, p3, p4);

/// Creates the [Tuple5Parser] parser.
Tuple5Parser<E1, E2, E3, E4, E5> tuple5<E1, E2, E3, E4, E5>(Parser<E1> p1,
        Parser<E2> p2, Parser<E3> p3, Parser<E4> p4, Parser<E5> p5) =>
    Tuple5Parser(p1, p2, p3, p4, p5);

/// Creates the [Tuple6Parser] parser.
Tuple6Parser<E1, E2, E3, E4, E5, E6> tuple6<E1, E2, E3, E4, E5, E6>(
        Parser<E1> p1,
        Parser<E2> p2,
        Parser<E3> p3,
        Parser<E4> p4,
        Parser<E5> p5,
        Parser<E6> p6) =>
    Tuple6Parser(p1, p2, p3, p4, p5, p6);

/// Creates the [Tuple7Parser] parser.
Tuple7Parser<E1, E2, E3, E4, E5, E6, E7> tuple7<E1, E2, E3, E4, E5, E6, E7>(
        Parser<E1> p1,
        Parser<E2> p2,
        Parser<E3> p3,
        Parser<E4> p4,
        Parser<E5> p5,
        Parser<E6> p6,
        Parser<E7> p7) =>
    Tuple7Parser(p1, p2, p3, p4, p5, p6, p7);

/// The [Tuple2Parser] parser invokes sequentially [p1] and [p2] and parses
/// successfully if all parsers succeed.
///
/// Returns [Tuple2] of parsing result of all parsers.
/// ```
/// final p = tuple2(p1, p2);
/// ```
class Tuple2Parser<E1, E2> extends Parser<Tuple2<E1, E2>> {
  final Parser<E1> p1;

  final Parser<E2> p2;

  Tuple2Parser(this.p1, this.p2) {
    label = [p1, p2].map(_quote).join(' ~ ');
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
  Tuple1<Tuple2<E1, E2>>? handleParse(ParseState state) {
    final ch = state.ch;
    final pos = state.pos;
    final r1 = p1.parse(state);
    if (r1 != null) {
      final r2 = p2.parse(state);
      if (r2 != null) {
        final v1 = Tuple2(r1.$0, r2.$0);
        return Tuple1(v1);
      }
    }

    state.pos = pos;
    state.ch = ch;
  }
}

/// The [Tuple3Parser] parser invokes sequentially [p1], [p2] and [p3] and
///  parses successfully if all parsers succeed.
///
/// Returns [Tuple3] of parsing result of all parsers.
/// ```
/// final p = tuple3(p1, p2, p3);
/// ```
class Tuple3Parser<E1, E2, E3> extends Parser<Tuple3<E1, E2, E3>> {
  final Parser<E1> p1;

  final Parser<E2> p2;

  final Parser<E3> p3;

  Tuple3Parser(this.p1, this.p2, this.p3) {
    label = [p1, p2, p3].map(_quote).join(' ~ ');
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
  Tuple1<Tuple3<E1, E2, E3>>? handleParse(ParseState state) {
    final ch = state.ch;
    final pos = state.pos;
    final r1 = p1.parse(state);
    if (r1 != null) {
      final r2 = p2.parse(state);
      if (r2 != null) {
        final r3 = p3.parse(state);
        if (r3 != null) {
          final v1 = Tuple3(r1.$0, r2.$0, r3.$0);
          return Tuple1(v1);
        }
      }
    }

    state.pos = pos;
    state.ch = ch;
  }
}

/// The [Tuple4Parser] parser invokes sequentially [p1], [p2], [p3] and [p4] and
///  parses successfully if all parsers succeed.
///
/// Returns [Tuple4] of parsing result of all parsers.
/// ```
/// final p = tuple4(p1, p2, p3, p4);
/// ```
class Tuple4Parser<E1, E2, E3, E4> extends Parser<Tuple4<E1, E2, E3, E4>> {
  final Parser<E1> p1;

  final Parser<E2> p2;

  final Parser<E3> p3;

  final Parser<E4> p4;

  Tuple4Parser(this.p1, this.p2, this.p3, this.p4) {
    label = [p1, p2, p3, p4].map(_quote).join(' ~ ');
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
  Tuple1<Tuple4<E1, E2, E3, E4>>? handleParse(ParseState state) {
    final ch = state.ch;
    final pos = state.pos;
    final r1 = p1.parse(state);
    if (r1 != null) {
      final r2 = p2.parse(state);
      if (r2 != null) {
        final r3 = p3.parse(state);
        if (r3 != null) {
          final r4 = p4.parse(state);
          if (r4 != null) {
            final v1 = Tuple4(r1.$0, r2.$0, r3.$0, r4.$0);
            return Tuple1(v1);
          }
        }
      }
    }

    state.pos = pos;
    state.ch = ch;
  }
}

/// The [Tuple5Parser] parser invokes sequentially [p1], [p2], [p3], [p4] and
/// [p5] and parses successfully if all parsers succeed.
///
/// Returns [Tuple5] of parsing result of all parsers.
/// ```
/// final p = tuple5(p1, p2, p3, p4, p5);
/// ```
class Tuple5Parser<E1, E2, E3, E4, E5>
    extends Parser<Tuple5<E1, E2, E3, E4, E5>> {
  final Parser<E1> p1;

  final Parser<E2> p2;

  final Parser<E3> p3;

  final Parser<E4> p4;

  final Parser<E5> p5;

  Tuple5Parser(this.p1, this.p2, this.p3, this.p4, this.p5) {
    label = [p1, p2, p3, p4, p5].map(_quote).join(' ~ ');
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
  Tuple1<Tuple5<E1, E2, E3, E4, E5>>? handleParse(ParseState state) {
    final ch = state.ch;
    final pos = state.pos;
    final r1 = p1.parse(state);
    if (r1 != null) {
      final r2 = p2.parse(state);
      if (r2 != null) {
        final r3 = p3.parse(state);
        if (r3 != null) {
          final r4 = p4.parse(state);
          if (r4 != null) {
            final r5 = p5.parse(state);
            if (r5 != null) {
              final v1 = Tuple5(r1.$0, r2.$0, r3.$0, r4.$0, r5.$0);
              return Tuple1(v1);
            }
          }
        }
      }
    }

    state.pos = pos;
    state.ch = ch;
  }
}

/// The [Tuple6Parser] parser invokes sequentially [p1], [p2], [p3], [p4], [p5]
/// and [p6] and parses successfully if all parsers succeed.
///
/// Returns [Tuple6] of parsing result of all parsers.
/// ```
/// final p = tuple6(p1, p2, p3, p4, p5, p6);
/// ```
class Tuple6Parser<E1, E2, E3, E4, E5, E6>
    extends Parser<Tuple6<E1, E2, E3, E4, E5, E6>> {
  final Parser<E1> p1;

  final Parser<E2> p2;

  final Parser<E3> p3;

  final Parser<E4> p4;

  final Parser<E5> p5;

  final Parser<E6> p6;

  Tuple6Parser(this.p1, this.p2, this.p3, this.p4, this.p5, this.p6) {
    label = [p1, p2, p3, p4, p5, p6].map(_quote).join(' ~ ');
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
  Tuple1<Tuple6<E1, E2, E3, E4, E5, E6>>? handleParse(ParseState state) {
    final ch = state.ch;
    final pos = state.pos;
    final r1 = p1.parse(state);
    if (r1 != null) {
      final r2 = p2.parse(state);
      if (r2 != null) {
        final r3 = p3.parse(state);
        if (r3 != null) {
          final r4 = p4.parse(state);
          if (r4 != null) {
            final r5 = p5.parse(state);
            if (r5 != null) {
              final r6 = p6.parse(state);
              if (r6 != null) {
                final v1 = Tuple6(r1.$0, r2.$0, r3.$0, r4.$0, r5.$0, r6.$0);
                return Tuple1(v1);
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

/// The [Tuple7Parser] parser invokes sequentially [p1], [p2], [p3], [p4], [p5],
///  [p6] and [p7] and parses successfully if all parsers succeed.
///
/// Returns [Tuple7] of parsing result of all parsers.
/// ```
/// final p = tuple7(p1, p2, p3, p4, p5, p6, p7);
/// ```
class Tuple7Parser<E1, E2, E3, E4, E5, E6, E7>
    extends Parser<Tuple7<E1, E2, E3, E4, E5, E6, E7>> {
  final Parser<E1> p1;

  final Parser<E2> p2;

  final Parser<E3> p3;

  final Parser<E4> p4;

  final Parser<E5> p5;

  final Parser<E6> p6;

  final Parser<E7> p7;

  Tuple7Parser(this.p1, this.p2, this.p3, this.p4, this.p5, this.p6, this.p7) {
    label = [p1, p2, p3, p4, p5, p6, p7].map(_quote).join(' ~ ');
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
  Tuple1<Tuple7<E1, E2, E3, E4, E5, E6, E7>>? handleParse(ParseState state) {
    final ch = state.ch;
    final pos = state.pos;
    final r1 = p1.parse(state);
    if (r1 != null) {
      final r2 = p2.parse(state);
      if (r2 != null) {
        final r3 = p3.parse(state);
        if (r3 != null) {
          final r4 = p4.parse(state);
          if (r4 != null) {
            final r5 = p5.parse(state);
            if (r5 != null) {
              final r6 = p6.parse(state);
              if (r6 != null) {
                final r7 = p7.parse(state);
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

    state.pos = pos;
    state.ch = ch;
  }
}

extension Tuple2ParserExt<E1, E2> on Tuple2Parser<E1, E2> {
  /// Creates the [Tuple3Parser] parser.
  /// ```dart
  /// final p = p1.andThen(p2).andThen(p3);
  /// ```
  Tuple3Parser<E1, E2, E3> andThen<E3>(Parser<E3> p) => Tuple3Parser(p1, p2, p);
}

extension Tuple3ParserExt<E1, E2, E3> on Tuple3Parser<E1, E2, E3> {
  /// Creates the [Tuple4Parser] parser.
  /// ```dart
  /// final p = p1.andThen(p2).andThen(p3).andThen(p4);
  /// ```
  Tuple4Parser<E1, E2, E3, E4> andThen<E4>(Parser<E4> p) =>
      Tuple4Parser(p1, p2, p3, p);
}

extension Tuple4ParserExt<E1, E2, E3, E4> on Tuple4Parser<E1, E2, E3, E4> {
  /// Creates the [Tuple5Parser] parser.
  /// ```dart
  /// final p = p1.andThen(p2).andThen(p3).andThen(p4).andThen(p5);
  /// ```
  Tuple5Parser<E1, E2, E3, E4, E5> andThen<E5>(Parser<E5> p) =>
      Tuple5Parser(p1, p2, p3, p4, p);
}

extension Tuple5ParserExt<E1, E2, E3, E4, E5>
    on Tuple5Parser<E1, E2, E3, E4, E5> {
  /// Creates the [Tuple6Parser] parser.
  /// ```dart
  /// final p = p1.andThen(p2).andThen(p3).andThen(p4).andThen(p5).andThen(p6);
  /// ```
  Tuple6Parser<E1, E2, E3, E4, E5, E6> andThen<E6>(Parser<E6> p) =>
      Tuple6Parser(p1, p2, p3, p4, p5, p);
}

extension Tuple6ParserExt<E1, E2, E3, E4, E5, E6>
    on Tuple6Parser<E1, E2, E3, E4, E5, E6> {
  /// Creates the [Tuple7Parser] parser.
  /// ```dart
  /// final p = p1.andThen(p2).andThen(p3).andThen(p4).andThen(p5).andThen(p6)
  ///   .andThen(p7);
  /// ```
  Tuple7Parser<E1, E2, E3, E4, E5, E6, E7> andThen<E7>(Parser<E7> p) =>
      Tuple7Parser(p1, p2, p3, p4, p5, p6, p);
}

extension TupleParserExt<T> on Parser<T> {
  Tuple2Parser<T, E2> andThen<E2>(Parser<E2> p) => Tuple2Parser(this, p);
}
