part of '../../buffer.dart';

class Buffer<E> extends ListBase<E?> {
  int _length = 0;

  final List<E?> _list;

  Buffer(int capacity) : _list = List.filled(capacity, null, growable: true);

  @override
  int get length => _length;

  @override
  set length(int newLength) {
    throw UnsupportedError('length=');
  }

  @override
  E? operator [](int index) {
    if (index >= _length) {
      throw RangeError.index(index, this);
    }

    return _list[index];
  }

  @override
  void operator []=(int index, E? value) {
    if (index >= _length) {
      throw RangeError.index(index, this);
    }

    _list[index] = value;
  }

  @override
  void add(E? element) {
    if (_length == _list.length) {
      _list.length *= 2;
    }

    _list[_length++] = element;
  }

  @override
  void clear() {
    _length = 0;
  }
}
