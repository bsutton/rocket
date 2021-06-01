part of '../../mapper.dart';

abstract class Mapper<I, O> {
  O map(I value);
}
