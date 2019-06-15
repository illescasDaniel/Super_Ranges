//import 'dart:collection' show IterableBase;

part of super_ranges;

abstract class BaseRange extends IterableBase<int>  {

  // Properties
  final int start, end;
  final bool closed;

  // Constructors
  const BaseRange({this.start, this.end, this.closed});

  // Iterables / iterator
  @override
  Iterator<int> get iterator =>
      ascending
          ? _range(1).iterator
          : _reverseRange(1).iterator;

  Iterator<int> iteratorWith({int stride}) =>
      ascending
          ? _range(stride).iterator
          : _reverseRange(stride).iterator;

  Iterable<int> _range(int stride) sync* {
    for (int i = _lowerBound; i < _upperBound; i += stride.abs()) {
      yield i;
    }
  }

  Iterable<int> _reverseRange(int stride) sync* {
    for (int i = _upperBound; i > _lowerBound; i -= stride.abs()) {
      yield i;
    }
  }

  // Computed properties
  bool get ascending => start <= end;

  int get lowerBound {
    if (ascending) {
      return _lowerBoundWithoutClose;
    }
    return closed ? _lowerBoundWithoutClose : _lowerBoundWithoutClose + 1;
  }

  int get upperBound {
    if (ascending) {
      return closed ? _upperBoundWithoutClose : _upperBoundWithoutClose-1;
    }
    return _upperBoundWithoutClose;
  }

  // Methods

  int get sum;

  @override
  bool operator==(Object other) {
    return identical(this, other) || (other is BaseRange && (
        this.lowerBound == other.lowerBound && this.upperBound == other.upperBound
    ));
  }

  @override
  int get hashCode => lowerBound ^ upperBound;

  @override
  String toString() {
    final openRangeSymbol = closed ? "." : (ascending ? "<" :">");
    return "($start..$openRangeSymbol$end)";
  }

  // Private
  int get _lowerBoundWithoutClose => ascending ? start : end;
  int get _upperBoundWithoutClose => ascending ? end : start;

  int get _lowerBound {
    if (ascending) {
      return _lowerBoundWithoutClose;
    }
    return closed ? (_lowerBoundWithoutClose - 1) : _lowerBoundWithoutClose;
  }

  int get _upperBound {
    if (ascending) {
      return closed ? (_upperBoundWithoutClose + 1) : _upperBoundWithoutClose;
    }
    return _upperBoundWithoutClose;
  }
}

mixin RandomOnRange on BaseRange {

  List<int> randomList({bool secure = false, int seed}) =>
      this.toList()
        ..shuffle(secure ? Math.Random.secure() : Math.Random(seed));

  int randomElement({bool secure = false, int seed}) {
    final elements = this.toList();
    if (elements.length < 2) { return this.lowerBound; }
    final random = secure ? Math.Random.secure() : Math.Random(seed);
    final index = random.nextInt(elements.length);
    return elements[index];
  }
}