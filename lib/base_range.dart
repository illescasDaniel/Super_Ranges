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
    for (int i = lowerBound; i < upperBound; i += stride.abs()) {
      yield i;
    }
  }

  Iterable<int> _reverseRange(int stride) sync* {
    for (int i = upperBound; i > lowerBound; i -= stride.abs()) {
      yield i;
    }
  }

  // Computed properties
  bool get ascending => start <= end;

  int get lowerBound {
    if (ascending) {
      return _lowerBoundWithoutClose;
    }
    return closed ? (_lowerBoundWithoutClose - 1) : _lowerBoundWithoutClose;
  }

  int get upperBound {
    if (ascending) {
      return closed ? (_upperBoundWithoutClose + 1) : _upperBoundWithoutClose;
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

  //
  int get expensiveLength => super.length;
  // Private
  int get _lowerBoundWithoutClose => ascending ? start : end;
  int get _upperBoundWithoutClose => ascending ? end : start;
}