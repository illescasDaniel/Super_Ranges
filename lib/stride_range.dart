part of super_ranges;

class StrideRange extends BaseRange {

  // Properties
  final int start, end;
  final bool closed;
  final int stride;

  // Constructors
  const StrideRange(this.start, this.end, {this.stride, this.closed = true}) : super(start: start, end: end, closed: closed);
  const StrideRange.named({this.start, this.end, this.stride, this.closed}) : super(start: start, end: end, closed: closed);

  @override
  Iterator<int> get iterator => super.iteratorWith(stride: this.stride);

  // Methods

  // TODO: improve length to be O(1)
  /*@override
  int get length {
    if (this.stride == 1) {
      return this.upperBound - this.lowerBound;
    }
    //
    return this.expensiveLength;
  }*/

  @override
  String toString() {
    final stepsString = stride != 1 ? ", stride: $stride" : "";
    final openRangeSymbol = closed ? "." : (ascending ? "<" :">");
    return "($start..$openRangeSymbol$end$stepsString)";
  }

  // TODO: `contains` should be different (?)

  /// O(n) sum of the members
  @override
  int get sum {
    if (this.start == this.end) {
      return this.closed ? this.start : 0;
    }
    return this.reduce((acc, newValue) => acc + newValue);
  }
}