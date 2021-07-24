part of '../../parser.dart';

const inline = pragma('vm:prefer-inline');

RefParser<I, O> ref<I, O>() => RefParser();

typedef AnyParser<I> = Parser<I, dynamic>;

typedef AnyStringParser<O> = Parser<String, dynamic>;

typedef StringParser<O> = Parser<String, O>;

class DummyParser<I, O> extends Parser<I, O> {
  DummyParser() {
    label = 'dummy';
  }

  @override
  Tuple1<O>? parse(ParseInput<I> input, ParseState state) {
    throw UnsupportedError('parse');
  }
}

class ParseError {
  final String element;

  final String group;

  ParseError(this.group, this.element);

  ParseError.expected(String expected, [String quote = ''])
      : element = '$quote$expected$quote',
        group = 'Expected';
}

abstract class Parser<I, O> {
  ParseError? error;

  String label = '';

  Tuple1<O>? parse(ParseInput<I> input, ParseState state);

  @override
  String toString() {
    if (label.isNotEmpty) {
      return label;
    }

    return super.toString();
  }

  static String quote(Parser p) {
    final label = p.label;
    if (label.contains(' ')) {
      return '(' + label + ')';
    }

    return label;
  }
}

class RefParser<I, O> extends Parser<I, O> {
  Parser<I, O> p = DummyParser();

  @override
  Tuple1<O>? parse(ParseInput<I> input, ParseState state) =>
      p.parse(input, state);
}
