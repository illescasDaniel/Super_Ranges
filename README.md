# Super Ranges

[![pub package](https://img.shields.io/pub/v/super_ranges.svg)](https://pub.dev/packages/super_ranges)

Powerful yet intuitive Ranges for dart.

100% tests coverage.

## Example

```dart
import 'package:super_ranges/range.dart';

for (final value in Range(0,10)) {
  print(value);
}
Range(3,7).forEach(print); // 3 4 5 6
Range.closed(1,5).toList(); // [1,2,3,4,5]
Range.bySteps(1,5, stride: 2) // 1, 3, 5
Range.named(start: 1, end: 6, closed: true) // 1,2,3,4,5,6

Range.closed(4,10).contains(9.6) // true
Range(1,6) == Range.closed(1,5) // true
Range(1,6).toString() // (1..<6)
```
