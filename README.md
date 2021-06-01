# rocket

Version 0.1.8 (BETA)  

Rocket is a parsing framework for parsing using efficient parsing algorithms.

The Rocket is a professional developers framework.  
The Rocket is a framework for the rapid development of fast parsers.  
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

A parser is an abstract class called `Parser` that contains two methods. One method for active parsing and one for passive parsing.

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
final p1 = digit().skipMany.right(char($Z));
final v = p1.parseString('100Z');
print(v); // Z (90)
```

In case of parsing error, an exception will be thrown.  
Since this is a simple parsing, the error message will not be descriptive.  
It's the same as if you are using regular expressions. No message, just result or error.  

In this case, it's better to use safe parsing.  

```dart
final p1 = digit().skipMany1.right(char($Z));
final r = p1.tryParseString('Z');
final v = r?.$0; // <= r.$0 is a result value
if (v != null) {
  print(v);
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

### How to extend a parser

When developing a complex combination of parsers (for example, for a complex grammar), it is often easier to extend an existing universal parser. Instead of writing it from scratch.  

For example, you need to parse a certain sequence, separated by some kind of separator.  
For this purpose, you can extend the `SepByParser` parser.  

```dart
class _Values extends SepByParser {
  _Values() : super(_value, _comma);
}
```

How it will works?  
The `SepByParser` parser is defined as follows:  

```dart
class SepByParser<E> extends Parser<List<E>> {
  final Parser<E> p;

  final Parser sep;

  SepByParser(this.p, this.sep);
}
```

Thus, by extending this parser, your parser inherits all the functionality of the `SepByParser` parser.  
Thus, the definition of this constructor already implies that your parser will work similarly to the `SepByParser` parser.  


```dart
_Values() : super(_value, _comma);
```

Quite reasonably, the question arises: But why extend it if nothing changes in principle?  
Yes, nothing changes, but nothing worsens.  
Additional benefits are as follows:

- Increased visibility
- Debugging process is simplified (because this is a specific parser)
- Your parser follows `Single-responsibility principle`

Of course, it is possible to create a combination of parsers for complex grammar using only the principle of simple combinations. It's a matter of taste.
But debugging such a combination will not be easy.  
These parsers will not have their own face.  

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
class _Comma extends OrFailParser {
  _Comma() : super(seq2(char($comma), _white), expectedError(','));
}
```

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