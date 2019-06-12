part of super_ranges;

class Range extends BaseRange {

  // Properties
  final int start, end;
  final bool closed;

  // Constructors
  const Range(this.start, this.end, {this.closed = false}) : super(start: start, end: end, closed: closed);
  const Range.named({this.start, this.end, this.closed}) : super(start: start, end: end, closed: closed);
  const Range.closed(this.start, this.end) : this.closed = true,  super(start: start, end: end, closed: true);

  static StrideRange bySteps(int start, int end, {int stride, bool closed = true}) {
    final finalStride = stride ?? 1;
    if (finalStride > 0) {
      return  StrideRange.named(start: start, end: end, stride: finalStride, closed: closed);
    }
    return  StrideRange.named(start: end, end: start, stride: finalStride, closed: closed);
  }

  // Methods

  /// O(1) sum of the members
  @override
  int get sum {

    if (!ascending) {
      return Range(this.lowerBound+1, this.upperBound+1).sum;
    }

    final uB = closed ? this._upperBoundWithoutClose : (this._upperBoundWithoutClose - 1);
    final lB = this._lowerBoundWithoutClose;
    return ((uB - (lB-1)) * (uB + lB)) ~/ 2;
  }

  /// O(1) count of the members. Use `expensiveLength` for default O(n) implementation.
  @override
  int get length => this.upperBound - this.lowerBound;

  /// O(1) method to know if a values is contained within the range.
  /// If a list object is passed it will iterate that list, so it can be O(n)
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
}