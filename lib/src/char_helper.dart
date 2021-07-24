void checkUtf16CodePoint(int c) {
  if (c >= 0 && c <= 0xd7ff || c >= 0xe000 && c <= 0xffff) {
    return;
  }

  throw ArgumentError.value(c, 'c', 'Not a valid UTF-16 code point');
}

String printableChar(int c) {
  var str = String.fromCharCode(c);
  str = printableString(str);
  return '\'$str\'';
}

String printableString(String str) {
  str = str.replaceAll('\n', '\\n');
  str = str.replaceAll('\r', '\\r');
  str = str.replaceAll('\t', '\\t');
  return '"$str"';
}
