part of '../../tuple.dart';

class Tuple1<T0> {
  final T0 $0;

  const Tuple1(this.$0);

  @override
  int get hashCode => $0.hashCode;

  @override
  bool operator ==(other) {
    if (other is Tuple1<T0>) {
      return other.$0 == $0;
    }

    return false;
  }

  @override
  String toString() => '[${$0}]';
}

class Tuple2<T0, T1> {
  final T0 $0;

  final T1 $1;

  const Tuple2(this.$0, this.$1);

  @override
  int get hashCode => $0.hashCode ^ $1.hashCode;

  @override
  bool operator ==(other) {
    if (other is Tuple2<T0, T1>) {
      return other.$0 == $0 && other.$1 == $1;
    }

    return false;
  }

  @override
  String toString() => '[${$0}, ${$1}]';
}

class Tuple3<T0, T1, T2> {
  final T0 $0;

  final T1 $1;

  final T2 $2;

  const Tuple3(this.$0, this.$1, this.$2);

  @override
  int get hashCode => $0.hashCode ^ $1.hashCode ^ $2.hashCode;

  @override
  bool operator ==(other) {
    if (other is Tuple3<T0, T1, T2>) {
      return other.$0 == $0 && other.$1 == $1 && other.$2 == $2;
    }

    return false;
  }

  @override
  String toString() => '[${$0}, ${$1}, ${$2}]';
}

class Tuple4<T0, T1, T2, T3> {
  final T0 $0;

  final T1 $1;

  final T2 $2;

  final T3 $3;

  const Tuple4(this.$0, this.$1, this.$2, this.$3);

  @override
  int get hashCode => $0.hashCode ^ $1.hashCode ^ $2.hashCode ^ $3.hashCode;

  @override
  bool operator ==(other) {
    if (other is Tuple4<T0, T1, T2, T3>) {
      return other.$0 == $0 &&
          other.$1 == $1 &&
          other.$2 == $2 &&
          other.$3 == $3;
    }

    return false;
  }

  @override
  String toString() => '[${$0}, ${$1}, ${$2}, ${$3}]';
}

class Tuple5<T0, T1, T2, T3, T4> {
  final T0 $0;

  final T1 $1;

  final T2 $2;

  final T3 $3;

  final T4 $4;

  const Tuple5(this.$0, this.$1, this.$2, this.$3, this.$4);

  @override
  int get hashCode =>
      $0.hashCode ^ $1.hashCode ^ $2.hashCode ^ $3.hashCode ^ $4.hashCode;

  @override
  bool operator ==(other) {
    if (other is Tuple5<T0, T1, T2, T3, T4>) {
      return other.$0 == $0 &&
          other.$1 == $1 &&
          other.$2 == $2 &&
          other.$3 == $3 &&
          other.$4 == $4;
    }

    return false;
  }

  @override
  String toString() => '[${$0}, ${$1}, ${$2}, ${$3}, ${$4}]';
}

class Tuple6<T0, T1, T2, T3, T4, T5> {
  final T0 $0;

  final T1 $1;

  final T2 $2;

  final T3 $3;

  final T4 $4;

  final T5 $5;

  const Tuple6(this.$0, this.$1, this.$2, this.$3, this.$4, this.$5);

  @override
  int get hashCode =>
      $0.hashCode ^
      $1.hashCode ^
      $2.hashCode ^
      $3.hashCode ^
      $4.hashCode ^
      $5.hashCode;

  @override
  bool operator ==(other) {
    if (other is Tuple6<T0, T1, T2, T3, T4, T5>) {
      return other.$0 == $0 &&
          other.$1 == $1 &&
          other.$2 == $2 &&
          other.$3 == $3 &&
          other.$4 == $4 &&
          other.$5 == $5;
    }

    return false;
  }

  @override
  String toString() => '[${$0}, ${$1}, ${$2}, ${$3}, ${$4}, ${$5}]';
}

class Tuple7<T0, T1, T2, T3, T4, T5, T6> {
  final T0 $0;

  final T1 $1;

  final T2 $2;

  final T3 $3;

  final T4 $4;

  final T5 $5;

  final T6 $6;

  const Tuple7(this.$0, this.$1, this.$2, this.$3, this.$4, this.$5, this.$6);

  @override
  int get hashCode =>
      $0.hashCode ^
      $1.hashCode ^
      $2.hashCode ^
      $3.hashCode ^
      $4.hashCode ^
      $5.hashCode ^
      $6.hashCode;

  @override
  bool operator ==(other) {
    if (other is Tuple7<T0, T1, T2, T3, T4, T5, T6>) {
      return other.$0 == $0 &&
          other.$1 == $1 &&
          other.$2 == $2 &&
          other.$3 == $3 &&
          other.$4 == $4 &&
          other.$5 == $5 &&
          other.$6 == $6;
    }

    return false;
  }

  @override
  String toString() => '[${$0}, ${$1}, ${$2}, ${$3}, ${$4}, ${$5}, ${$6}]';
}
