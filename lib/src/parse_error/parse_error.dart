part of '../../parse_error.dart';

ExpectedError expectedError(String name) => ExpectedError(name);

UnexpectedError unexpectedError(String name) => UnexpectedError(name);

class ExpectedError extends ParseError {
  @override
  final String element;

  @override
  final String key = 'Expected';

  ExpectedError(this.element);
}

abstract class ParseError {
  String get element;

  String get key;

  @override
  String toString() => '$key: \'$element\'';
}

class UnexpectedError extends ParseError {
  @override
  final String element;

  @override
  final String key = 'Unexpected';

  UnexpectedError(this.element);
}
