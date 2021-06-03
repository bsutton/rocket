part of '../../parser.dart';

/// Creates the [DigitParser] parser.
DigitParser digit() => DigitParser();

/// The [DigitParser] parses successfully if it can consume one of the
/// characters from the range [0..9].
///
/// Returns the consumed character.
/// ```dart
/// final d = digit().skipMany1.capture.map(int.parse);
/// ```
class DigitParser extends Parser<int> {
  final _tab = List<Tuple1<int>>.generate(10, (i) => Tuple1(i));

  @override
  bool fastParse(ParseState state) {
    final pos = state.pos;
    if (pos + 2 <= state.length) {
      final c = state.data.getUint16(pos, Endian.little);
      if (c >= 0x30 && c <= 0x39) {
        state.pos += 2;
        return true;
      }
    }

    return false;
  }

  @override
  Tuple1<int>? parse(ParseState state) {
    final pos = state.pos;
    if (pos + 2 <= state.length) {
      final c = state.data.getUint16(pos, Endian.little);
      if (c >= 0x30 && c <= 0x39) {
        state.pos += 2;
        return _tab[c - 0x30];
      }
    }
  }

  @override
  bool fastParseMany(ParseState state) {
    final source = state.data;
    final length = state.length;
    while (true) {
      final pos = state.pos;
      if (pos + 2 <= length) {
        final c = source.getUint16(pos, Endian.little);
        if (c >= 0x30 && c <= 0x39) {
          state.pos += 2;
          continue;
        }
      }

      return true;
    }
  }

  @override
  bool fastParseMany1(ParseState state) {
    final pos = state.pos;
    final length = state.length;
    if (pos + 2 <= length) {
      final source = state.data;
      final c = source.getUint16(pos, Endian.little);
      if (c >= 0x30 && c <= 0x39) {
        state.pos += 2;
        while (true) {
          final pos = state.pos;
          if (pos + 2 <= length) {
            final c = source.getUint16(pos, Endian.little);
            if (c >= 0x30 && c <= 0x39) {
              state.pos += 2;
              continue;
            }
          }

          return true;
        }
      }
    }

    return false;
  }

  @override
  Tuple1<List<int>>? parseMany(ParseState state) {
    final list = <int>[];
    final source = state.data;
    final length = state.length;
    while (true) {
      final pos = state.pos;
      if (pos + 2 <= length) {
        final c = source.getUint16(pos, Endian.little);
        if (c >= 0x30 && c <= 0x39) {
          state.pos += 2;
          list.add(c - 0x30);
          continue;
        }
      }

      return Tuple1(list);
    }
  }

  @override
  Tuple1<List<int>>? parseMany1(ParseState state) {
    final pos = state.pos;
    final length = state.length;
    if (pos + 2 <= length) {
      final source = state.data;
      final c = source.getUint16(pos, Endian.little);
      if (c >= 0x30 && c <= 0x39) {
        state.pos += 2;
        final list = [c];
        while (true) {
          final pos = state.pos;
          if (pos + 2 <= length) {
            final c = source.getUint16(pos, Endian.little);
            if (c >= 0x30 && c <= 0x39) {
              state.pos += 2;
              list.add(c);
              continue;
            }
          }

          return Tuple1(list);
        }
      }
    }
  }
}
