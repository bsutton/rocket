part of '../../parser.dart';

DigitParser digit() => DigitParser();

class DigitParser extends Parser<int> {
  final _tab = List<Tuple1<int>>.generate(10, (i) => Tuple1(i));

  @override
  bool fastParse(ParseState state) {
    final c = state.ch;
    if (c >= 0x30 && c <= 0x39) {
      state.nextChar();
      return true;
    }

    return false;
  }

  @override
  bool fastParseMany(ParseState state) {
    while (true) {
      final c = state.ch;
      if (c >= 0x30 && c <= 0x39) {
        state.nextChar();
        continue;
      }

      return true;
    }
  }

  @override
  bool fastParseMany1(ParseState state) {
    final c = state.ch;
    if (c < 0x30 || c > 0x39) {
      return false;
    }

    state.nextChar();
    while (true) {
      final c = state.ch;
      if (c >= 0x30 && c <= 0x39) {
        state.nextChar();
        continue;
      }

      return true;
    }
  }

  @override
  bool fastParseSkipMany(ParseState state) {
    while (true) {
      final c = state.ch;
      if (c >= 0x30 && c <= 0x39) {
        state.nextChar();
        continue;
      }

      return true;
    }
  }

  @override
  bool fastParseSkipMany1(ParseState state) {
    final c = state.ch;
    if (c < 0x30 || c > 0x39) {
      return false;
    }

    state.nextChar();
    while (true) {
      final c = state.ch;
      if (c >= 0x30 && c <= 0x39) {
        state.nextChar();
        continue;
      }

      return true;
    }
  }

  @override
  Tuple1<int>? parse(ParseState state) {
    final c = state.ch;
    if (c >= 0x30 && c <= 0x39) {
      state.nextChar();
      return _tab[c - 0x30];
    }
  }

  @override
  Tuple1<List<int>>? parseMany(ParseState state) {
    final list = <int>[];
    while (true) {
      final c = state.ch;
      if (c >= 0x30 && c <= 0x39) {
        state.nextChar();
        list.add(c - 0x30);
        continue;
      }

      return Tuple1(list);
    }
  }

  @override
  Tuple1<List<int>>? parseMany1(ParseState state) {
    final c = state.ch;
    if (c < 0x30 || c > 0x39) {
      return null;
    }

    state.nextChar();
    final list = [c - 0x30];
    while (true) {
      final c = state.ch;
      if (c >= 0x30 && c <= 0x39) {
        state.nextChar();
        list.add(c - 0x30);
        continue;
      }

      return Tuple1(list);
    }
  }

  @override
  Tuple1? parseSkipMany(ParseState state) {
    while (true) {
      final c = state.ch;
      if (c >= 0x30 && c <= 0x39) {
        state.nextChar();
        continue;
      }

      return const Tuple1(null);
    }
  }

  @override
  Tuple1? parseSkipMany1(ParseState state) {
    final c = state.ch;
    if (c < 0x30 || c > 0x39) {
      return null;
    }

    while (true) {
      final c = state.ch;
      if (c >= 0x30 && c <= 0x39) {
        state.nextChar();
        continue;
      }

      return const Tuple1(null);
    }
  }
}
