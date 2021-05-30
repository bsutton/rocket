part of '../../parser.dart';

FailParser<E> fail<E>(err) => FailParser(err);

class FailParser<E> extends Parser<E> {
  final dynamic err;

  FailParser(this.err);

  @override
  bool fastParse(ParseState state) {
    state.fail(err, state.pos);
    return false;
  }

  @override
  Tuple1<E>? parse(ParseState state) {
    state.fail(err, state.pos);
  }
}

class OrFailParser<E> extends Parser<E> {
  final dynamic err;

  Parser<E> p;

  OrFailParser(this.p, this.err);

  @override
  bool fastParse(ParseState state) {
    if (p.fastParse(state)) {
      return true;
    }

    state.fail(err, state.pos);
    return false;
  }

  @override
  Tuple1<E>? parse(ParseState state) {
    final r1 = p.parse(state);
    if (r1 != null) {
      return r1;
    }

    state.fail(err, state.pos);
  }
}

extension OrFailParserExt<E> on Parser<E> {
  Parser<E> orFail(err) => OrFailParser(this, err);
}
