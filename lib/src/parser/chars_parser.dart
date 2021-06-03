part of '../../parser.dart';

/// Creates the [Chars16Parser] parser.
Chars16Parser chars16(List<int> cs) => Chars16Parser(cs);

/// The [Chars16Parser] parses successfully if it can consume one of spefied
/// characters.
///
/// Returns the consumed character.
/// ```dart
/// final cs = chars([48, 49]);
/// ```
class Chars16Parser extends Parser<int> {
  Uint32List _cs = Uint32List(0);

  int _maxChar = 0;

  Chars16Parser(List<int> cs) {
    if (cs.isEmpty) {
      throw ArgumentError.value(cs, 'cs', 'Must not be empty');
    }

    final temp = cs.toList();
    if (temp.toSet().length != cs.length) {
      throw ArgumentError.value(
          cs, 'chars', 'Must not not contain duplicate elements');
    }

    for (var i = 0; i < cs.length; i++) {
      final c = cs[i];
      if (c >= 0xd800 && c <= 0xdfff) {
        throw RangeError.value(c, 'c', 'Not a valid UTF-16 character');
      }
    }

    temp.sort();
    _cs = Uint32List.fromList(temp);
    _maxChar = _cs.last;
  }

  @override
  bool fastParse(ParseState state) {
    final pos = state.pos;
    if (pos + 2 <= state.length) {
      final c = state.data.getUint16(pos, Endian.little);
      if (c <= _maxChar) {
        for (var i = 0; i < _cs.length; i++) {
          if (c == _cs[i]) {
            state.pos += 2;
            return true;
          }
        }
      }
    }

    return false;
  }

  @override
  Tuple1<int>? parse(ParseState state) {
    final pos = state.pos;
    if (pos + 2 <= state.length) {
      final c = state.data.getUint16(pos, Endian.little);
      if (c <= _maxChar) {
        for (var i = 0; i < _cs.length; i++) {
          if (c == _cs[i]) {
            state.pos += 2;
            return Tuple1(c);
          }
        }
      }
    }
  }
}
