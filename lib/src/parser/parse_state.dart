part of '../../parser.dart';

class DummyParserState extends ParseState {
  @override
  void fail(ParseError? error, int pos) {
    // Nothing
  }
}

class ParseState {
  int failPos = 0;

  final failures = Buffer<ParseError?>(100);

  List<String> buildErrors() {
    final res = <String>[];
    final grouped = failures
        .whereType<ParseError>()
        .where((e) => e.group.trim().isNotEmpty);
    for (final group in grouped.map((e) => e.group).toSet()) {
      final elements = grouped
          .where((e) => e.group == group)
          .map((e) => e.element)
          .toSet()
          .toList();
      elements.sort();
      res.add('$group: ${elements.join(', ')}');
    }

    final ungrouped =
        failures.whereType<ParseError>().where((e) => e.group.trim().isEmpty);
    for (final group in ungrouped.map((e) => e.group).toSet()) {
      final elements =
          grouped.where((e) => e.group == group).map((e) => e.element).toSet();
      res.addAll(elements);
    }

    if (res.isEmpty && failures.isNotEmpty) {
      res.add('Parse error');
    }

    return res;
  }

  @inline
  void fail(ParseError? error, int pos) {
    if (failPos > pos) {
      return;
    }

    if (failPos < pos) {
      failPos = pos;
      failures.clear();
    }

    failures.add(error);
  }
}
