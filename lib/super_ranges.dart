library super_ranges;

import 'dart:collection' show IterableBase;

class Range extends IterableBase<int>  {

  // Properties
  final int start;
  final int end;
  final bool closed;
  final int stride;

  // Constructors
  const Range(this.start, this.end, {this.closed = false}) : this.stride = 1;
  const Range.named({this.start, this.end, this.closed}) : this.stride = 1;
  const Range._named({this.start, this.end, this.closed, this.stride});
  const Range.closed(this.start, this.end) : this.closed = true, this.stride = 1;

  factory Range.bySteps(int start, int end, {int stride = 1, bool closed = true}) {
    if (stride > 0) {
      return Range._named(start: start, end: end, closed: closed, stride: stride);
    }
    return Range._named(start: end, end: start, closed: closed, stride: stride);;
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
  @override
  bool contains(Object value) {
    if (value is num) {
      if (ascending) {
        return start <= value && (closed ? value <= end : value < end);
      } else {
        return start >= value && (closed ? value >= end : value > end);
      }
    }
    else if (value is List<num>) {
      for (final aValue in value) {
        if (!this.contains(aValue)) {
          return false;
        }
      }
      return true;
    }
    return false;
  }

  @override
  bool operator==(Object other) {
    return identical(this, other) || (other is Range && (
        this.lowerBound == other.lowerBound && this.upperBound == other.upperBound
    ));
  }

  @override
  int get hashCode => lowerBound ^ upperBound;

  @override
  String toString() {
    final stepsString = stride != 1 ? ", stride: $stride" : "";
    final openRangeSymbol = closed ? "." : (ascending ? "<" :">");
    return "($start..$openRangeSymbol$end$stepsString)";
  }

  // Iterables / iterator
  @override
  Iterator<int> get iterator =>
      ascending
          ? _range.iterator
          : _reverseRange.iterator;

  Iterable<int> get _range sync* {
    for (int i = lowerBound; i < upperBound; i += this.stride.abs()) {
      yield i;
    }
  }

  Iterable<int> get _reverseRange sync* {
    for (int i = upperBound; i > lowerBound; i -= this.stride.abs()) {
      yield i;
    }
  }

  // Private
  int get _lowerBoundWithoutClose => ascending ? start : end;
  int get _upperBoundWithoutClose => ascending ? end : start;
}
