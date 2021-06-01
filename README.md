# rocket

Version 0.1.9 (BETA)  

Rocket is a parsing framework for parsing using efficient parsing algorithms.

The Rocket is a professional developers framework.  
The Rocket is a framework for the rapid development of fast parsers.  
Simple, convenient and fully customizable process of tracking the parsing process (allows you to track  complete, successful, or unsuccessful parsing, parsing of individual parsers, with fully customizable information output) and setting the conditional breakpoints (by position, by symbol, by the name of the parser, and so on).  
Convenient automatic and manual assignment of labels (names) for parsers to increase the visibility of the process of tracking and debugging.  
Simple and convenient error system.  
Implement something properly once and reuse it everywhere.  
Parse data as efficiently as possible.  
Use the capabilities of the framework in combination with your own parsers.  
Combine handwritten algorithms with built-in parsers for maximum efficiency.  
Use parsers to quickly implement efficient data validators.  

### What planned

- More core parsers
- Examples
- Documentation
- Useful "how to"

***To make this project better you can make a donation for development.***  

### What is a parser

A parser is an abstract class called `Parser` that contains several methods. Some methods for active parsing, others for passive parsing.

```dart
@protected
bool handleFastParse(ParseState state);

@protected
Tuple1<E>? handleParse(ParseState state);
```

These methods should not be used directly as they are called by other general methods.  
General methods are used for direct parsing. There are also two of them.  

```dart
bool fastParse(ParseState state);

Tuple1<E>? parse(ParseState state);
```

It also contains other methods, but these are not methods of direct parsing (direct use), but to improve the efficiency of parsing.

### How to parse

The `parse.dart` file contains static extension methods for the class `Parser` to simplify parsing process.  
Therefore, you should import this file.  

```dart
import 'package:rocket/parse.dart';
```

The `charcode` package is also very useful. It is also recommended to use it if simple ASCII character parsing is expected.  

```dart
import 'package:charcode/ascii.dart';
```

These `Parser` static extension methods include the following methods:

```dart
bool fastParseString(ParseState state);

E parseString(ParseState state);

bool tryFastParseString(ParseState state);

Tuple<E>? tryParseString(ParseState state);
```

The `try` versions do not throw an exception on parse error and return the parse result directly.  
The result can be one of the following, as defined for methods `fastParse` and `parse`:  

```dart
true // Success
false // Failure
Tuple<E> // Success
null // Failure
```

The other two methods return the parse value directly and throw an exception if no value is present.  
The value can be anything as defined for the `fastParse` and `parse` methods (including `null`, because `null` is also a normal value).  

```dart
true // Success
E // Success
```

Example of simple parsing. Simple parsing, in this case, means using a simple combination of parsers.

```dart
final p1 = digit().skipMany1.right(char($Z));
final v = p1.parseString('100Z');
print(v); // Z (90)
```

In case of parsing error, an exception will be thrown.  
Since this is a simple parsing, the error message will not be descriptive.  
It's the same as if you are using regular expressions. No message, just result or error.  

But this can be solved very simply.

```dart
main(List<String> args) {
  final _digits = digit().skipMany1.expected('digits');
  final z = char($Z).expected('Z');
  final p1 = _digits.right(z);
  final v = p1.parseString('100');
}
```

So, when parsing the string `100`, an exception will be thrown.  

```
Unhandled exception:
FormatException: Expected: 'Z'
 (at character 4)
100
   ^
```

Also you can to use safe parsing.  

```dart
final p1 = digit().skipMany1.right(char($Z));
final r = p1.tryParseString('Z');
final v = r?.$0;
if (v != null) {
  print(v); // The data was parsed successfully
}
```

Or in the case of just validation.  

```dart
final p1 = digit().skipMany1.right(char($Z));
if (p1.tryFastParseString('1Z')) {
  print('Parsing passed, data validated');
}
```

### How to parse complex data

An example of a complex parser is the JSON parser.  
https://github.com/mezoni/rocket/blob/main/example/example.dart

*More information will be available later.*

### How to implement a parser from scratch

Relatively speaking, parsers can be divided into several categories.

- Parsers that work directly with data (eg. `char`, `str`)
- Parsers that iterate over other parsers (eg. `many`, `skipMay`)
- Parsers that parse sequences of other parsers (`seq2`, `left`)
- Parsers that parse structures composed of other parsers
- Parsers that parse alternatives from the list of parsers
- Some other parsers

In many cases, simple parsing does not require creating your own parsers. If you have a sufficient number of universal and specific parsers at your disposal, then you can achieve the required result by combining parsers. And also by combining combinations of parsers.  
This is how regular expression parsers work and are used.  
This framework is also suitable for working and using the same principle.  
Currently, there are not very many specific parsers in the framework, but their number will increase over time.  

And so what is the answer to this question?  
The best answer is an example of a real working parser.  
Take a look at the implementation of basic parsers, see them in action.  
Copy the source code of any simple parser and modify it. Check it out in action.  
Test it if possible.
This will be your own parser.  
And it doesn't matter that you copied it. This is your own parser, created by you.  

### How the error reporting system works

To begin with, what are the types of error messages.  
You can use any type of value as the error message. When building error message, it will be cast to the `String` value (`error.toString()`).  
But to improve error reporting, there is currently a special type `ParseError`.  
It is designed to grouping the most common messages of the same type.  
There are two predefined types, but you can create and use your own.  
These two types are:  

```dart
ExpectedError
UnexpectedError
```

Error messages created using these types will be combined into one message (by key of each type) with all messages of this type.

The type `ParseError` is declared as follows:

```dart
abstract class ParseError {
  String get element;
  String get key;
}
```

Examples of generating error messages:

```dart
str('Hello').orFail(expectedError('Hello'));
```

```dart
final r = p.parse(state);
if (r == null) {
  state.fail(expectedError('some value'), state.pos);
}
```

By default, no error messages are generated (unless otherwise noted) for performance reasons.

### How to trace

There is built-in support for this.  
When the generic parse method is called, this method checks to see if tracer is connected.  
If the tracer is connected, then the tracking handlers are called.  
These handlers are defined in the `ParseTraces` interface class.  

```dart
abstract class ParseTracer {
  void enter<E>(Parser<E> parser, ParseState state);

  void enterFast<E>(Parser<E> parser, ParseState state);

  void leave<E>(Parser<E> parser, ParseState state, Tuple1<E>? result);

  void leaveFast<E>(Parser<E> parser, ParseState state, bool result);
}
```

This allows the developer to fully track the parsing process.  
This means only one thing. This is a simple, convenient and fully customizable tracking of the parsing process.  
Tracking complete, successful or unsuccessful parsing, parsing of individual parsers.  
Fully customizable output.  
Setting conditional breakpoints (by position, by symbol, by parser name, etc.).  

Implement your own tracer and track whatever you need.  
An example of the simplest tracer can be found in the file:  
https://github.com/mezoni/rocket/blob/main/example/tracer_example.dart

### Performance

Below are the results of testing JSON parsers. Dart SDK JSON parser and JSON parser implemented using Rocket.  

JIT:

```
Dart SDK JSON: k: 1.00, 42.85 MB/s, 501.03 ms (50.71%),
Rocket JSON  : k: 1.97, 21.73 MB/s, 988.06 ms (100.00%),

Parse 10 times: E:\prj\test_dart_json_parsers\bin\data\citm_catalog.json
Dart SDK JSON: k: 1.00, 86.23 MB/s, 191.01 ms (58.23%),
Rocket JSON  : k: 1.72, 50.21 MB/s, 328.02 ms (100.00%),

Parse 10 times: E:\prj\test_dart_json_parsers\bin\data\twitter.json
Dart SDK JSON: k: 1.00, 53.62 MB/s, 101.01 ms (74.27%),
Rocket JSON  : k: 1.35, 39.82 MB/s, 136.01 ms (100.00%),
```

AOT:

```
Parse 10 times: E:\prj\test_dart_json_parsers\bin\data\canada.json
Dart SDK JSON: k: 1.00, 12.28 MB/s, 1748.10 ms (41.98%),
Rocket JSON  : k: 2.38, 5.16 MB/s, 4164.24 ms (100.00%),

Parse 10 times: E:\prj\test_dart_json_parsers\bin\data\citm_catalog.json
Dart SDK JSON: k: 1.16, 23.90 MB/s, 689.04 ms (100.00%),
Rocket JSON  : k: 1.00, 27.73 MB/s, 594.03 ms (86.21%),

Parse 10 times: E:\prj\test_dart_json_parsers\bin\data\twitter.json
Dart SDK JSON: k: 1.00, 45.90 MB/s, 118.01 ms (67.82%),
Rocket JSON  : k: 1.47, 31.13 MB/s, 174.01 ms (100.00%),
```

The Rocket JSON parser was written in a few hours.  
The parser can be complicated to improve performance by adding some kinds of tweaks (as it was done in the Dart SDK parser), but this will impair the clarity of the parsing algorithms and, in principle, reduce its reliability (theoretically).  


*To be continued...*