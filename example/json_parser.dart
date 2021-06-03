import 'dart:typed_data';

import 'package:charcode/ascii.dart';
import 'package:rocket/parse.dart';
import 'package:rocket/parse_error.dart';

import '_parse_number.dart';

export 'package:rocket/parse.dart';

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

final _white =
    matchUint16(IntMatcher([9, 10, 13, 32]), null, Endian.little).many;

Parser _createParser() {
  final _closeBrace = tokChar16($close_brace, '}', null, _white);

  final _closeBracket = tokChar16($close_bracket, ']', null, _white);

  final _colon = tokChar16($colon, ':', null, _white);

  final _eof = tok(atEnd(), 'end of file', null, _white);

  final _comma = tokChar16($comma, ',', null, _white);

  final _false = tokStr('false', 'false', false, _white);

  final _null = tokStr('null', 'null', null, _white);

  final _openBrace = tokChar16($open_brace, '{', null, _white);

  final _openBracket = tokChar16($open_bracket, '[', null, _white);

  final _true = tokStr('true', 'true', true, _white);

  final _string = _String().as('string');

  final _number = _Number().as('number');

  final _value = ref().as('value') as RefParser;

  final _values = sepBy(_value, _comma).as('values');

  final _array = between(_openBracket, _values, _closeBracket).as('array');

  final _member = around(_string, _colon, _value).as('member');

  final _members = sepBy(_member, _comma).as('members');

  final _object = between(_openBrace, _members, _closeBrace)
      .mapper(_ObjectMapper())
      .as('object');

  _value.p = choice7(_object, _array, _string, _number, _true, _false, _null)
      .as('value');

  final _json = between(_white, _value, _eof).as('json');

  return _json;
}

class _Chars extends Parser<List<int>> {
  @override
  bool fastParse(ParseState state) {
    parse(state);
    return true;
  }

  @override
  Tuple1<List<int>>? parse(ParseState state) {
    final list = <int>[];
    var pos = state.pos;
    final data = state.data;
    final length = state.length;
    loop:
    while (true) {
      if (pos >= length) {
        break;
      }

      var c = data.getUint16(pos, Endian.little);
      if ((c >= 0x5d && c <= 0xd7ff) ||
          (c >= 0x23 && c <= 0x5b) ||
          (c >= 0x20 && c <= 0x21) ||
          (c >= 0xe000 && c <= 0xffff)) {
        pos += 2;
        list.add(c);
        continue;
      }

      if (c >= 0xd800 && c <= 0xDBFF) {
        if (pos + 2 < data.lengthInBytes) {
          final c2 = data.getUint16(pos + 2, Endian.little);
          if (c2 >= 0xDC00 && c2 <= 0xDFFF) {
            c = ((c - 0xD800) << 10) + (c2 - 0xDC00) + 0x10000;
            pos += 4;
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

      pos += 2;
      c = data.getUint16(pos, Endian.little);
      switch (c) {
        case $double_quote:
        case $slash:
        case $backslash:
          pos += 2;
          list.add(c);
          continue;
        case $b:
          pos += 2;
          list.add(0x08);
          continue;
        case $f:
          pos += 2;
          list.add(0x0c);
          continue;
        case $n:
          pos += 2;
          list.add(0x0d);
          continue;
        case $r:
          pos += 2;
          list.add(0x0d);
          continue;
        case $t:
          pos += 2;
          list.add(0x09);
          continue;
        case $u:
          pos += 2;
          var c2 = 0;
          for (var i = 0; i < 8; i += 2) {
            final c = data.getUint16(pos + i, Endian.little);
            if (c >= $0 && c <= $9) {
              c2 = (c2 << 4) | (c - 0x30);
            } else if (c >= $a && c <= $f) {
              c2 = (c2 << 4) | (c - $a + 10);
            } else if (c >= $A && c <= $F) {
              c2 = (c2 << 4) | (c - $A + 10);
            } else {
              pos -= 4;
              break loop;
            }
          }

          list.add(c2);
          break;
        default:
          break loop;
      }
    }

    state.pos = pos;
    return Tuple1(list);
  }
}

class _Number extends Parser<num> {
  static final _digit = digit().as('[0-9]');

  static final _digit19 =
      matchUint16(rangesMatcher([Range($1, $9)]), null, Endian.little)
          .as('[1-9]');

  static final _dot = char($dot).as('.');

  static final _eE = chars16([$e, $E]).as('e | E');

  static final _exp = seq3(_eE, _signs.opt, _digit.many1).as('exp');

  static final _frac = seq2(_dot, _digit.many1).as('frac');

  static final _integer =
      choice2(seq2(_digit19, _digit.many), _zero).as('integer');

  static final _minus = char($minus).as('minus');

  static final _number =
      seq4(_minus.opt, _integer, _frac.opt, _exp.opt).capture.as('_number');

  static final _signs = chars16([$plus, $minus]).as('signs');

  static final _zero = char($0).as('zero');

  @override
  bool fastParse(ParseState state) => parse(state) != null;

  @override
  Tuple1<num>? parse(ParseState state) {
    final r1 = _number.parse(state);
    if (r1 == null) {
      state.fail(expectedError('number'), state.pos);
      return null;
    }

    _white.fastParse(state);
    final v1 = r1.$0;
    final v2 = parseNumber(v1);
    return Tuple1(v2);
  }
}

class _ObjectMapper
    implements Mapper<List<Tuple2<String, dynamic>>, Map<String, dynamic>> {
  @override
  Map<String, dynamic> map(List<Tuple2<String, dynamic>> value) {
    final r = <String, dynamic>{};
    for (var i = 0; i < value.length; i++) {
      final v = value[i];
      r[v.$0] = v.$1;
    }

    return r;
  }
}

class _String extends Parser<String> {
  static final _quote = char($quote).as('"');

  final Parser<List<int>> chars;

  _String()
      : chars = between(_quote, _chars, tokChar16($quote, '"', null, _white))
            .as('chars');

  @override
  bool fastParse(ParseState state) {
    final r1 = chars.parse(state);
    if (r1 == null) {
      state.fail(expectedError('string'), state.pos);
      return false;
    }

    return true;
  }

  @override
  Tuple1<String>? parse(ParseState state) {
    final r1 = chars.parse(state);
    if (r1 == null) {
      state.fail(expectedError('string'), state.pos);
      return null;
    }

    final v1 = r1.$0;
    final v2 = String.fromCharCodes(v1);
    return Tuple1(v2);
  }
}

extension<E> on Parser<E> {
  Parser<E> as(String label) {
    this.label = label;
    quote = label.contains(' ');
    return this;
  }
}
