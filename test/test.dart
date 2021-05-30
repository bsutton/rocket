import 'package:charcode/ascii.dart';
import 'package:rocket/parse.dart';

void main() {
  final p1 = digit().skipMany1.right(char($Z));
  if (p1.tryFastParseString('1Z')) {
    print('Parsing passed, data validated');
  }
}
