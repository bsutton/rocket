part of '../../printable.dart';

String printableChar(int c, [bool quote = false]) {
  var str = String.fromCharCode(c);
  str = printableString(str);
  if (quote) {
    str = '\'$str\'';
  }

  return str;
}

String printableString(String str, [bool quote = false]) {
  str = str.replaceAll('\n', '\\n');
  str = str.replaceAll('\r', '\\r');
  str = str.replaceAll('\t', '\\t');
  if (quote) {
    str = '"$str"';
  }

  return str;
}
