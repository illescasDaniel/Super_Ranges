part of super_ranges;

class Range extends BaseRange with RandomOnRange {

  // Properties
  final int start, end;
  final bool closed;

  // Constructors
  const Range(this.start, this.end, {this.closed = false}) : super(start: start, end: end, closed: closed);
  const Range.to(this.end) : this.start = 0, this.closed = false, super(start: 0, end: end, closed: true);
  const Range.toInclusive(this.end) : this.start = 0, this.closed = true, super(start: 0, end: end, closed: true);
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

  @override
  int randomElement({bool secure = false, int seed})
    => this._random(min: lowerBound, max: upperBound, secure: secure, seed: seed);

  /// O(1) sum of the members
  @override
  int get sum {

    if (!ascending) {
      return Range(this._lowerBound+1, this._upperBound+1).sum;
    }

    final uB = closed ? this._upperBoundWithoutClose : (this._upperBoundWithoutClose - 1);
    final lB = this._lowerBoundWithoutClose;
    return ((uB - (lB-1)) * (uB + lB)) ~/ 2;
  }

  /// O(1) count of the members. Use `expensiveLength` for default O(n) implementation.
  @override
  int get length => this._upperBound - this._lowerBound;

  /// O(n) default implementation to get the length.
  int get expensiveLength => super.length;

  /// O(1) method to know if a value is contained within the range.
  /// If a list object is passed, it will iterate that list, so it can be O(n).
  /// It accepts int`, `num` or `List<num>`
  @override
  bool contains(Object value) {
    if (value is int) {
      return lowerBound <= value && value <= upperBound;
    }
    else if (value is num) {
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

  // Private

  /// `min` inclusive, and `max` inclusive
  int _random({int min, int max, bool secure = true, int seed}) {
    if (length < 2) { return min; }
    final randomGen = secure ? Math.Random.secure() : Math.Random(seed);
    return min + randomGen.nextInt(max - min + 1);
  }
}