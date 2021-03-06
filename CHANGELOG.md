## 0.1.10

- Breaking change: Everything has been completely reimplemented. Now you can parse any data types (text, binary etc). 
- Removed error `UnexpectedError`

## 0.1.9

- Breaking change: The typed data `ByteData` is now used as input data for parsing
- Minor cosmetic improvements in the `json_parser.dart` example file.
- Added parser `ExpectedParser`
- Added parser `WhiteParser`
- Partially added API documentation
- Added matcher `IntMatcher` with binary search
- Added matcher `RangesMatcher` with binary search

## 0.1.8

- Added parser `MapperParser`
- Added parser `RefParser`
- Added parser `TokCharParser`
- Added parser `TokParser`
- Added parser `TokStrParser`
- Added `Skipper` functionality to skip input data (e.g. whitespaces) as quickly as possible
- Added `ParseTracer` functionality for easy (configurable) tracking of the parsing process
- Breaking change (to implement traceability): parsers must declare  methods `fastParse` and `parse`

## 0.1.7

- Partially added API documentation

## 0.1.6

- API documentation process started
- Breaking change: classes `RangeNParser` (where N indicates the number) renamed to `RangesNParser`
- Added parser `MapParser`

## 0.1.5

- Impoved JSON Parser example
- Impoved error reporting system
- Added parser `FailParser`
- Added parser `OrFailParser`
- Added parser `ValParser`
- Added class `ParseError`

## 0.1.4

- Added optimized parser `DigitParser`
- Added some information to the `README.md` file

## 0.1.3

- Added an example of the basic prediction in `example_json_pro.dart`

## 0.1.2

- Added static extension methods `fastParseString`, `tryFastParseString` and `tryParseString` to ` Parser`

## 0.1.1

- Minor changes in `example.dart`
- Removed dependency on package `lists`

## 0.1.0

- Initial release
