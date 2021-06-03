part of '../../parser.dart';

/// Creates the [CharParser] parser.
CharParser char(int c) => CharParser(c);

/// The [CharParser] parses successfully if it can consume the character [c].
///
/// Returns the character [c].
/// ```dart
/// final a = char(97);
/// ```
class CharParser extends Parser<int> {
  final int c;

  final Tuple1<int> _res;

  CharParser(this.c) : _res = Tuple1(c) {
    if (c >= 0xd800 && c <= 0xdfff) {
      throw RangeError.value(c, 'c', 'Not a valid UTF-16 character');
    }

    label = '[0x${c.toRadixString(16)}]';
    quote = false;
  }

  @override
  bool fastParse(ParseState state) {
    final pos = state.pos;
    if (pos + 2 <= state.length) {
      final ch = state.data.getUint16(pos, Endian.little);
      if (ch == c) {
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
      final ch = state.data.getUint16(pos, Endian.little);
      if (ch == c) {
        state.pos += 2;
        return _res;
      }
    }
  }
}
