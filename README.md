# rocket

Version 0.1.10 (BETA)  

Rocket is a parsing framework for parsing any kind (text, binary etc) of data structures using efficient parsing algorithms.

The Rocket is a professional developers framework.  
The Rocket is a framework for the rapid development of fast parsers.  
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

### What is a parser

A parser is an abstract class called `Parser` that contains method `parse`.

```dart
Tuple1<E>? parse(ParseState state);
```

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
E parseString(ParseState state);

Tuple<E>? tryParseString(ParseState state);
```

The `try` version do not throw an exception on parse error and return the parse result directly.  
The result can be one of the following:  

```dart
Tuple<E> // Success
null // Failure
```

The another method return the parse value directly and throw an exception if no value is present.  
The value can be anything as defined for the `parse` method (including `null`, because `null` is also a normal value).  

Example of simple parsing. Simple parsing, in this case, means using a simple combination of parsers.

```dart
final p1 = digit().many1.right(char($Z));
final v = p1.parseString('100Z');
print(v); // Z (90)
```

In case of parsing error, an exception will be thrown.  
Since this is a simple parsing, the error message will not be descriptive.  
It's the same as if you are using regular expressions. No message, just result or error.  

But this can be solved very simply.

```dart
main(List<String> args) {
  final _digits = digit().many1.expected('digits');
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
final p1 = digit().many1.right(char($Z));
final r = p1.tryParseString('Z');
final v = r?.$0;
if (v != null) {
  print(v); // The data was parsed successfully
}
```

### How to parse complex data

An example of a complex parser is the JSON parser.  
https://github.com/mezoni/rocket/blob/main/example/example.dart

*More information will be available later.*

### How to implement a parser from scratch

Relatively speaking, parsers can be divided into several categories.

- Parsers that work directly with data (eg. `char`, `str`)
- Parsers that iterate over other parsers (eg. `many`, `rep`)
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

### Performance

Below are the results of testing JSON parsers. Dart SDK JSON parser and JSON parser implemented using Rocket.  

JIT:

```
Parse 10 times: E:\prj\test_json\bin\data\canada.json
Dart SDK JSON   : k: 1.00, 32.67 MB/s, 657.04 ms (50.38%),
Rocket JSON     : k: 1.98, 16.46 MB/s, 1304.07 ms (100.00%),

Parse 10 times: E:\prj\test_json\bin\data\citm_catalog.json
Dart SDK JSON   : k: 1.00, 75.55 MB/s, 218.01 ms (62.11%),
Rocket JSON     : k: 1.61, 46.92 MB/s, 351.02 ms (100.00%),

Parse 10 times: E:\prj\test_json\bin\data\twitter.json
Dart SDK JSON   : k: 1.00, 57.62 MB/s, 94.00 ms (68.61%),
Rocket JSON     : k: 1.46, 39.53 MB/s, 137.01 ms (100.00%),
```

AOT:

```
Parse 10 times: E:\prj\test_json\bin\data\canada.json
Dart SDK JSON   : k: 1.00, 24.07 MB/s, 892.05 ms (49.34%),
Rocket JSON     : k: 2.03, 11.87 MB/s, 1808.10 ms (100.00%),

Parse 10 times: E:\prj\test_json\bin\data\citm_catalog.json
Dart SDK JSON   : k: 1.00, 63.10 MB/s, 261.01 ms (59.59%),
Rocket JSON     : k: 1.68, 37.60 MB/s, 438.02 ms (100.00%),

Parse 10 times: E:\prj\test_json\bin\data\twitter.json
Dart SDK JSON   : k: 1.00, 50.15 MB/s, 108.01 ms (69.68%),
Rocket JSON     : k: 1.44, 34.94 MB/s, 155.01 ms (100.00%),
```

The Rocket JSON parser was written in a few hours.  
The parser can be complicated to improve performance by adding some kinds of tweaks (as it was done in the Dart SDK parser), but this will impair the clarity of the parsing algorithms and, in principle, reduce its reliability (theoretically).  


*To be continued...*