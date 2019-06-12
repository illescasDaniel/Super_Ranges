import 'package:super_ranges/super_ranges.dart';

void main() {
  for (final value in Range(0,10)) {
    print(value);
  }
  Range(3,7).forEach(print); // 3 4 5 6

  print( Range.closed(1,5).toList() ); // [1,2,3,4,5]
  print( Range.bySteps(1,5, stride: 2) ); // 1, 3, 5
  print( Range.named(start: 1, end: 6, closed: true)); // 1,2,3,4,5,6

  print( Range.closed(4,10).contains(9.6) ); // true
  print( Range(1,6) == Range.closed(1,5) ); // true
  print( Range(1,6).toString() ); // (1..<6)

  print(Range(5,0).toList());

  print(Range.closed(5,0).sum);

  print(Range.bySteps(3,3, stride: 3).sum);
}