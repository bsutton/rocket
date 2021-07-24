import 'package:charcode/ascii.dart';
import 'package:rocket/char.dart';
import 'package:rocket/combinator.dart';
import 'package:rocket/mapper.dart';
import 'package:rocket/matcher.dart';
import 'package:rocket/parse_string.dart';
import 'package:rocket/parser.dart';
import 'package:rocket/token.dart';
import 'package:rocket/tuple.dart';

export 'package:rocket/parse_string.dart';

void main() {
  final text = '''
{"rocket": "🚀 flies to the stars"}
''';
  final p = parser;
  final r = p.parseString(text);
  print(r);
}

final parser = _createParser();

final _chars = _Chars().as('chars');

final _white = _White();

StringParser _createParser() {
  final _eof = token('end of file', eof(), _white);

  final _false = symbol('false', _white).val(false).as('false');

  final _null = symbol('null', _white).val(null).as('null');

  final _true = symbol('true', _white).val(true).as('true');

  final _string = _String().as('string');

  final _number = _Number().as('number');

  final _value = ref<String, dynamic>()..label = 'value';

  final _values = commaSep(_value, _white).as('values');

  final _array = brackets(_values, _white).as('array');

  final _member = keyValue(_string, _value, $colon, _white).as('member');

  final _members = commaSep(_member, _white).as('members');

  final _object = braces(_members, _white).map(_ObjectMapper()).as('object');

  _value.p = choice7(_object, _array, _string, _number, _true, _false, _null)
      .as('value');

  final _json = between(_white, _value, _eof).as('json');

  return _json;
}

class Digit19 extends StringParser<int> {
  @override
  @inline
  Tuple1<int>? parse(ParseInput<String> input, ParseState state) {
    final source = input.source;
    final pos = input.pos;
    if (pos < source.length) {
      final c = source.codeUnitAt(pos);
      if (c >= 0x31 && c <= 0x39) {
        input.pos++;
        return Tuple1(c);
      }
    }
  }
}

class _Chars extends StringParser<List<int>> {
  @override
  Tuple1<List<int>> parse(ParseInput<String> input, ParseState state) {
    // TODO
    final list = <int>[];
    final source = input.source;
    var pos = input.pos;
    final length = source.length;
    loop:
    while (true) {
      if (pos >= length) {
        break;
      }

      var c = source.codeUnitAt(pos);
      if ((c >= 0x5d && c <= 0xd7ff) ||
          (c >= 0x23 && c <= 0x5b) ||
          (c >= 0x20 && c <= 0x21) ||
          (c >= 0xe000 && c <= 0xffff)) {
        pos++;
        list.add(c);
        continue;
      }

      if (c >= 0xd800 && c <= 0xDBFF) {
        if (pos + 2 < length) {
          final c2 = source.codeUnitAt(pos + 1);
          if (c2 >= 0xDC00 && c2 <= 0xDFFF) {
            c = ((c - 0xD800) << 10) + (c2 - 0xDC00) + 0x10000;
            pos += 2;
            list.add(c);
            continue;
          } else {
            break;
          }
        } else {
          break;
        }
      } else {
        if (c >= 0xDC00 && c <= 0xDFFF) {
          break;
        }
      }

      if (c != $backslash) {
        break;
      }

      pos++;
      c = source.codeUnitAt(pos);
      switch (c) {
        case $double_quote:
        case $slash:
        case $backslash:
          pos++;
          list.add(c);
          continue;
        case $b:
          pos++;
          list.add(0x08);
          continue;
        case $f:
          pos++;
          list.add(0x0c);
          continue;
        case $n:
          pos++;
          list.add(0x0d);
          continue;
        case $r:
          pos++;
          list.add(0x0d);
          continue;
        case $t:
          pos++;
          list.add(0x09);
          continue;
        case $u:
          pos++;
          var c2 = 0;
          for (var i = 0; i < 4; i++) {
            final c = source.codeUnitAt(pos + i);
            if (c >= $0 && c <= $9) {
              c2 = (c2 << 4) | (c - 0x30);
            } else if (c >= $a && c <= $f) {
              c2 = (c2 << 4) | (c - $a + 10);
            } else if (c >= $A && c <= $F) {
              c2 = (c2 << 4) | (c - $A + 10);
            } else {
              pos -= 2;
              break loop;
            }
          }

          list.add(c2);
          pos += 4;
          break;
        default:
          break loop;
      }
    }

    input.pos = pos;
    return Tuple1(list);
  }
}

class _Digit19 implements Matcher<int> {
  @override
  bool match(int value) => value >= 0x31 && value <= 0x39;
}

class _Number extends StringParser<num> {
  static final _digit = digit();

  static final _digit19 = satisfy(_Digit19()).as('1..9');

  static final _dot = char($dot);

  static final _eE = oneOf([$e, $E]);

  static final _exp = skip3(_eE, _signs.optional, _digit.skipMany1).as('exp');

  static final _frac = skip2(_dot, _digit.skipMany1).as('frac');

  static final _integer =
      choice2(skip2(_digit19, _digit.skipMany), _zero).as('integer');

  static final _minus = char($minus);

  static final _number = Tuple4$(_minus.optional.capture, _integer.capture,
          _frac.optional.capture, _exp.optional.capture)
      .as('_number');

  static final _signs = oneOf([$plus, $minus]).as('signs');

  static final _zero = char($0).as('zero');

  _Number() {
    error = ParseError.expected('number');
  }

  @override
  @inline
  Tuple1<num>? parse(ParseInput<String> input, ParseState state) {
    final start = input.pos;
    final r1 = _number.parse(input, state);
    if (r1 != null) {
      final end = input.pos;
      _white.parse(input, state);
      final v0 = _parse(r1.$0);
      if (v0 != null) {
        return Tuple1(v0);
      }

      final v1 = input.source.substring(start, end);
      final v2 = double.parse(v1);
      return Tuple1(v2);
    }

    state.fail(error, input.pos);
  }

  num? _parse(Tuple4<String, String, String, String> x) {
    final p1 = x.$1;
    if (p1.length == 1 && p1.codeUnitAt(0) == 0x30) {
      return 0;
    }

    final p3 = x.$3;
    if (p3.isNotEmpty) {
      return null;
    }

    final p0 = x.$0;
    final p2 = x.$2;
    const positiveOverflow = '9223372036854775808';
    const negativeOverflow = '9223372036854775809';
    final negative = p0.isNotEmpty && p0.codeUnitAt(0) == $minus;
    final overflow = negative ? negativeOverflow : positiveOverflow;
    if (p1.length > overflow.length) {
      return null;
    }

    if (p1.length == overflow.length) {
      var ok = false;
      for (var i = 0; i < positiveOverflow.length; i++) {
        final c = p1.codeUnitAt(i);
        if (c < overflow.codeUnitAt(i)) {
          ok = true;
          break;
        }
      }

      if (!ok) {
        return null;
      }
    }

    var intValue = 0;
    for (var i = 0; i < p1.length; i++) {
      final digit = p1.codeUnitAt(i);
      intValue = intValue * 10 + (digit - 0x30);
    }

    if (negative) {
      intValue = -intValue;
    }

    if (p2.isEmpty) {
      return intValue;
    }

    if (negative && intValue == -9223372036854775808) {
      return null;
    } else if (intValue == 9223372036854775807) {
      return null;
    }

    var doubleValue = 0.0;
    for (var i = 1, k = 10; i < p2.length; i++, k *= 10) {
      if (i == 17) {
        break;
      }

      final digit = p2.codeUnitAt(i);
      doubleValue = doubleValue + (digit - 0x30) / k;
    }

    doubleValue = doubleValue + intValue;
    if (negative) {
      doubleValue = -doubleValue;
    }

    return doubleValue;
  }
}

class _ObjectMapper
    implements Mapper<List<Tuple2<String, dynamic>>, Map<String, dynamic>> {
  @override
  @inline
  Map<String, dynamic> map(List<Tuple2<String, dynamic>> value) {
    final r = <String, dynamic>{};
    for (var i = 0; i < value.length; i++) {
      final v = value[i];
      r[v.$0] = v.$1;
    }

    return r;
  }
}

class _String extends StringParser<String> {
  final StringParser<List<int>> chars;

  _String()
      : chars = between(char($quote), _chars, symbolic($quote, _white))
            .as('chars') {
    error = ParseError.expected('string');
  }

  @override
  Tuple1<String>? parse(ParseInput<String> input, ParseState state) {
    final r1 = chars.parse(input, state);
    if (r1 != null) {
      final v1 = r1.$0;
      final v2 = String.fromCharCodes(v1);
      return Tuple1(v2);
    }

    state.fail(error, input.pos);
  }
}

class _White extends AnyStringParser {
  @override
  Tuple1? parse(ParseInput<String> input, ParseState state) {
    final source = input.source;
    var pos = input.pos;
    while (true) {
      if (pos < source.length) {
        final c = source.codeUnitAt(pos);
        if (c == 9 || c == 10 || c == 13 || c == 32) {
          pos++;
          continue;
        }
      }

      input.pos = pos;
      return const Tuple1(null);
    }
  }
}

extension<O> on StringParser<O> {
  StringParser<O> as(String label) {
    this.label = label;
    return this;
  }
}
