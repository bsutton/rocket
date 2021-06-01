import 'package:charcode/ascii.dart';
import 'package:rocket/parse.dart';

main(List<String> args) {
  final _digits = digit().skipMany1.expected('digits');
  final z = char($Z).expected('Z');
  final p1 = _digits.right(z);
  final v = p1.parseString('100');
}
