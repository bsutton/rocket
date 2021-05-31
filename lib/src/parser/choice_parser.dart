part of '../../parser.dart';

/// Creates the [ChoiceParser] parser.
ChoiceParser<E> choice<E>(List<Parser<E>> ps) => ChoiceParser(ps);

/// Creates the [Choice2Parser] parser.
Choice2Parser<E> choice2<E>(Parser<E> p1, Parser<E> p2) =>
    Choice2Parser(p1, p2);

/// Creates the [Choice3Parser] parser.
Choice3Parser<E> choice3<E>(Parser<E> p1, Parser<E> p2, Parser<E> p3) =>
    Choice3Parser(p1, p2, p3);

/// Creates the [Choice4Parser] parser.
Choice4Parser<E> choice4<E>(
        Parser<E> p1, Parser<E> p2, Parser<E> p3, Parser<E> p4) =>
    Choice4Parser(p1, p2, p3, p4);

/// Creates the [Choice5Parser] parser.
Choice5Parser<E> choice5<E>(
        Parser<E> p1, Parser<E> p2, Parser<E> p3, Parser<E> p4, Parser<E> p5) =>
    Choice5Parser(p1, p2, p3, p4, p5);

/// Creates the [Choice6Parser] parser.
Choice6Parser<E> choice6<E>(Parser<E> p1, Parser<E> p2, Parser<E> p3,
        Parser<E> p4, Parser<E> p5, Parser<E> p6) =>
    Choice6Parser(p1, p2, p3, p4, p5, p6);

/// Creates the [Choice7Parser] parser.
Choice7Parser<E> choice7<E>(Parser<E> p1, Parser<E> p2, Parser<E> p3,
        Parser<E> p4, Parser<E> p5, Parser<E> p6, Parser<E> p7) =>
    Choice7Parser(p1, p2, p3, p4, p5, p6, p7);

/// The [Choice2Parser] parser invokes [p1]or [p2] until one of them parses
/// successfully.
///
/// Returns the result of parsing one of the parsers.
/// ```dart
/// final p = choice2(p1, p2);
/// ```
class Choice2Parser<E> extends Parser<E> {
  final Parser<E> p1;

  final Parser<E> p2;

  Choice2Parser(this.p1, this.p2);

  @override
  bool fastParse(ParseState state) {
    if (p1.fastParse(state)) {
      return true;
    }

    if (p2.fastParse(state)) {
      return true;
    }

    return false;
  }

  @override
  Tuple1<E>? parse(ParseState state) {
    final r1 = p1.parse(state);
    if (r1 != null) {
      return r1;
    }

    final r2 = p2.parse(state);
    if (r2 != null) {
      return r2;
    }
  }
}

/// The [Choice3Parser] parser invokes [p1], [p2] or [p3]
/// until one of them parses successfully.
///
/// Returns the result of parsing one of the parsers.
/// ```dart
/// final p = choice3(p1, p2, p3);
/// ```
class Choice3Parser<E> extends Parser<E> {
  final Parser<E> p1;

  final Parser<E> p2;

  final Parser<E> p3;

  Choice3Parser(this.p1, this.p2, this.p3);

  @override
  bool fastParse(ParseState state) {
    if (p1.fastParse(state)) {
      return true;
    }

    if (p2.fastParse(state)) {
      return true;
    }

    if (p3.fastParse(state)) {
      return true;
    }

    return false;
  }

  @override
  Tuple1<E>? parse(ParseState state) {
    final r1 = p1.parse(state);
    if (r1 != null) {
      return r1;
    }

    final r2 = p2.parse(state);
    if (r2 != null) {
      return r2;
    }

    final r3 = p3.parse(state);
    if (r3 != null) {
      return r3;
    }
  }
}

/// The [Choice4Parser] parser invokes [p1], [p2], [p3] or [p4]
/// until one of them parses successfully.
///
/// Returns the result of parsing one of the parsers.
/// ```dart
/// final p = choice4(p1, p2, p3, p4);
/// ```
class Choice4Parser<E> extends Parser<E> {
  final Parser<E> p1;

  final Parser<E> p2;

  final Parser<E> p3;

  final Parser<E> p4;

  Choice4Parser(this.p1, this.p2, this.p3, this.p4);

  @override
  bool fastParse(ParseState state) {
    if (p1.fastParse(state)) {
      return true;
    }

    if (p2.fastParse(state)) {
      return true;
    }

    if (p3.fastParse(state)) {
      return true;
    }

    if (p4.fastParse(state)) {
      return true;
    }

    return false;
  }

  @override
  Tuple1<E>? parse(ParseState state) {
    final r1 = p1.parse(state);
    if (r1 != null) {
      return r1;
    }

    final r2 = p2.parse(state);
    if (r2 != null) {
      return r2;
    }

    final r3 = p3.parse(state);
    if (r3 != null) {
      return r3;
    }

    final r4 = p4.parse(state);
    if (r4 != null) {
      return r4;
    }
  }
}

/// The [Choice5Parser] parser invokes [p1], [p2], [p3], [p4] or [p5]
/// until one of them parses successfully.
///
/// Returns the result of parsing one of the parsers.
/// ```dart
/// final p = choice5(p1, p2, p3, p4, p5);
/// ```
class Choice5Parser<E> extends Parser<E> {
  final Parser<E> p1;

  final Parser<E> p2;

  final Parser<E> p3;

  final Parser<E> p4;

  final Parser<E> p5;

  Choice5Parser(this.p1, this.p2, this.p3, this.p4, this.p5);

  @override
  bool fastParse(ParseState state) {
    if (p1.fastParse(state)) {
      return true;
    }

    if (p2.fastParse(state)) {
      return true;
    }

    if (p3.fastParse(state)) {
      return true;
    }

    if (p4.fastParse(state)) {
      return true;
    }

    if (p5.fastParse(state)) {
      return true;
    }

    return false;
  }

  @override
  Tuple1<E>? parse(ParseState state) {
    final r1 = p1.parse(state);
    if (r1 != null) {
      return r1;
    }

    final r2 = p2.parse(state);
    if (r2 != null) {
      return r2;
    }

    final r3 = p3.parse(state);
    if (r3 != null) {
      return r3;
    }

    final r4 = p4.parse(state);
    if (r4 != null) {
      return r4;
    }

    final r5 = p5.parse(state);
    if (r5 != null) {
      return r5;
    }
  }
}

/// The [Choice6Parser] parser invokes [p1], [p2], [p3], [p4], [p5] or [p6]
/// until one of them parses successfully.
///
/// Returns the result of parsing one of the parsers.
/// ```dart
/// final p = choice6(p1, p2, p3, p4, p5, p6);
/// ```
class Choice6Parser<E> extends Parser<E> {
  final Parser<E> p1;

  final Parser<E> p2;

  final Parser<E> p3;

  final Parser<E> p4;

  final Parser<E> p5;

  final Parser<E> p6;

  Choice6Parser(this.p1, this.p2, this.p3, this.p4, this.p5, this.p6);

  @override
  bool fastParse(ParseState state) {
    if (p1.fastParse(state)) {
      return true;
    }

    if (p2.fastParse(state)) {
      return true;
    }

    if (p3.fastParse(state)) {
      return true;
    }

    if (p4.fastParse(state)) {
      return true;
    }

    if (p5.fastParse(state)) {
      return true;
    }

    if (p6.fastParse(state)) {
      return true;
    }

    return false;
  }

  @override
  Tuple1<E>? parse(ParseState state) {
    final r1 = p1.parse(state);
    if (r1 != null) {
      return r1;
    }

    final r2 = p2.parse(state);
    if (r2 != null) {
      return r2;
    }

    final r3 = p3.parse(state);
    if (r3 != null) {
      return r3;
    }

    final r4 = p4.parse(state);
    if (r4 != null) {
      return r4;
    }

    final r5 = p5.parse(state);
    if (r5 != null) {
      return r5;
    }

    final r6 = p6.parse(state);
    if (r6 != null) {
      return r6;
    }
  }
}

/// The [Choice7Parser] parser invokes [p1], [p2], [p3], [p4], [p5], [p6] or
/// [p7] until one of them parses successfully.
///
/// Returns the result of parsing one of the parsers.
/// ```dart
/// final p = choice7(p1, p2, p3, p4, p5, p6, p7);
/// ```
class Choice7Parser<E> extends Parser<E> {
  final Parser<E> p1;

  final Parser<E> p2;

  final Parser<E> p3;

  final Parser<E> p4;

  final Parser<E> p5;

  final Parser<E> p6;

  final Parser<E> p7;

  Choice7Parser(this.p1, this.p2, this.p3, this.p4, this.p5, this.p6, this.p7);

  @override
  bool fastParse(ParseState state) {
    if (p1.fastParse(state)) {
      return true;
    }

    if (p2.fastParse(state)) {
      return true;
    }

    if (p3.fastParse(state)) {
      return true;
    }

    if (p4.fastParse(state)) {
      return true;
    }

    if (p5.fastParse(state)) {
      return true;
    }

    if (p6.fastParse(state)) {
      return true;
    }

    if (p7.fastParse(state)) {
      return true;
    }

    return false;
  }

  @override
  Tuple1<E>? parse(ParseState state) {
    final r1 = p1.parse(state);
    if (r1 != null) {
      return r1;
    }

    final r2 = p2.parse(state);
    if (r2 != null) {
      return r2;
    }

    final r3 = p3.parse(state);
    if (r3 != null) {
      return r3;
    }

    final r4 = p4.parse(state);
    if (r4 != null) {
      return r4;
    }

    final r5 = p5.parse(state);
    if (r5 != null) {
      return r5;
    }

    final r6 = p6.parse(state);
    if (r6 != null) {
      return r6;
    }

    final r7 = p7.parse(state);
    if (r7 != null) {
      return r7;
    }
  }
}

/// The [ChoiceParser] parser iterates over and invokes the parsers from [ps]
/// until one of them parses successfully.
///
/// Returns the result of parsing one of the parsers.
/// ```dart
/// final p = choice([p1, p2]);
/// ```
class ChoiceParser<E> extends Parser<E> {
  final List<Parser<E>> ps;

  ChoiceParser(this.ps) {
    if (ps.isEmpty) {
      throw ArgumentError.value(ps, 'ps', 'Must not be empty');
    }
  }

  @override
  bool fastParse(ParseState state) {
    for (var i = 0; i < ps.length; i++) {
      final p = ps[i];
      if (p.fastParse(state)) {
        return true;
      }
    }

    return false;
  }

  @override
  Tuple1<E>? parse(ParseState state) {
    for (var i = 0; i < ps.length; i++) {
      final p = ps[i];
      final r1 = p.parse(state);
      if (r1 != null) {
        return r1;
      }
    }
  }
}
