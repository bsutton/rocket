part of '../../matcher.dart';

final Uint32List _table = _generateTable();

AsciiMatcher asciiMatcher(int mask) => AsciiMatcher(mask);

IsAlnumMatcher isAlnumMatcher() => IsAlnumMatcher();

IsAlphaMatcher isAlphaMatcher() => isAlphaMatcher();

IsAsciiMatcher isAsciiMatcher() => isAsciiMatcher();

IsDigitMatcher isDigitMatcher() => isDigitMatcher();

IsLowerMatcher isLowerMatcher() => isLowerMatcher();

IsUpperMatcher isUpperMatcher() => isUpperMatcher();

Uint32List _generateTable() {
  final result = Uint32List(128);
  result[0x07] |= Ascii.bel;
  result[0x08] |= Ascii.bs;
  result[0x09] |= Ascii.ht;
  result[0x0a] |= Ascii.lf;
  result[0x0b] |= Ascii.vt;
  result[0x0c] |= Ascii.ff;
  result[0x0d] |= Ascii.cr;
  result[0x1b] |= Ascii.ec;
  result[0x20] |= Ascii.space;
  result[0x22] |= Ascii.dq;
  result[0x27] |= Ascii.sq;
  for (var i = 0x30; i < 0x39; i++) {
    result[i] |= Ascii.digit;
    result[i] |= Ascii.hex;
  }

  for (var i = 0x41; i < 0x5a; i++) {
    if (i <= 0x46) {
      result[i] |= Ascii.hex;
    }

    result[i] |= Ascii.alpha;
    result[i] |= Ascii.upper;
  }

  for (var i = 0x61; i < 0x7a; i++) {
    if (i <= 0x66) {
      result[i] |= Ascii.hex;
    }

    result[i] |= Ascii.alpha;
    result[i] |= Ascii.lower;
  }

  return result;
}

class Ascii {
  /// 0x07
  static const int bel = 1;

  /// 0x08
  static const int bs = bel << 1;

  /// 0x09
  static const int ht = bs << 1;

  /// 0x0a
  static const int lf = ht << 1;

  /// 0x0b
  static const int vt = lf << 1;

  /// 0x0c
  static const int ff = vt << 1;

  /// 0x0d
  static const int cr = ff << 1;

  /// 0x1b
  static const int ec = cr << 1;

  /// 0x20
  static const int space = ec << 1;

  /// 0x22
  static const int dq = space << 1;

  /// 0x27
  static const int sq = dq << 1;

  /// 0x5f
  static const int ll = sq << 1;

  /// 0-9
  static const int digit = ll << 1;

  /// a-z
  static const int lower = digit << 1;

  /// A-Z
  static const int upper = lower << 1;

  /// a-zA-Z0-9
  static const int hex = upper << 1;

  /// a-zA-Z
  static const int alpha = lower | upper;

  /// a-zA-Z0-9
  static const int alnum = alpha | digit;
}

class AsciiMatcher extends Matcher<int> {
  final int mask;

  AsciiMatcher(this.mask);

  @override
  @inline
  bool match(int value) => value <= 127 && _table[value] & mask != 0;
}

class IsAlnumMatcher extends Matcher<int> {
  @override
  @inline
  bool match(int value) => value <= 127 && _table[value] & Ascii.alnum != 0;
}

class IsAlphaMatcher extends Matcher<int> {
  @override
  @inline
  bool match(int value) => value <= 127 && _table[value] & Ascii.alpha != 0;
}

class IsAsciiMatcher extends Matcher<int> {
  @override
  @inline
  bool match(int value) => value <= 127;
}

class IsDigitMatcher extends Matcher<int> {
  @override
  @inline
  bool match(int value) => value <= 127 && _table[value] & Ascii.digit != 0;
}

class IsLowerMatcher extends Matcher<int> {
  @override
  @inline
  bool match(int value) => value <= 127 && _table[value] & Ascii.lower != 0;
}

class IsUpperMatcher extends Matcher<int> {
  @override
  @inline
  bool match(int value) => value <= 127 && _table[value] & Ascii.upper != 0;
}
