import '../parser.dart';

extension StringParseInputExt on ParseInput<String> {
  @inline
  int get ch => pos < source.length ? source.codeUnitAt(pos) : 0x10ffff + 1;

  @inline
  bool match(int c) {
    if (pos < source.length) {
      if (source.codeUnitAt(pos) == c) {
        pos++;
        return true;
      }
    }

    return false;
  }

  @inline
  bool matchString(String str) {
    if (pos < source.length) {
      if (source.startsWith(str, pos)) {
        pos += str.length;
        return true;
      }
    }

    return false;
  }
}
