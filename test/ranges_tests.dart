//import 'package:test/test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:super_ranges/super_ranges.dart';

void main() {

  group('Normal ranges', () {
    group('Positive', () {
      group('Open ranges', () {
        test('Not from zero', () {
          final rangeList = Range.named(start: 2, end: 10, closed: false).toList();
          final expectedRangeList = [2,3,4,5,6,7,8,9];
          expect(rangeList, expectedRangeList);
        });

        test('From zero', () {
          final rangeList = Range.named(start: 0, end: 10, closed: false).toList();
          final expectedRangeList = [0,1,2,3,4,5,6,7,8,9];
          expect(rangeList, expectedRangeList);
        });
      });

      group('Closed ranges', () {
        test('Not from zero', () {
          final rangeList = Range.named(start: 2, end: 10, closed: true).toList();
          final expectedRangeList = [2,3,4,5,6,7,8,9,10];
          expect(rangeList, expectedRangeList);
        });

        test('From zero', () {
          final rangeList = Range.named(start: 0, end: 10, closed: true).toList();
          final expectedRangeList = [0,1,2,3,4,5,6,7,8,9,10];
          expect(rangeList, expectedRangeList);
        });
      });
    });

    group('Negative', () {
      group('Open ranges', () {
        test('Not from zero', () {
          final rangeList = Range.named(start: -2, end: -10, closed: false).toList();
          final expectedRangeList= [-2,-3,-4,-5,-6,-7,-8,-9];
          expect(rangeList, expectedRangeList);
        });

        test('From zero', () {
          final rangeList = Range.named(start: 0, end: -10, closed: false).toList();
          final expectedRangeList = [0,-1,-2,-3,-4,-5,-6,-7,-8,-9];
          expect(rangeList, expectedRangeList);
        });
      });

      group('Closed ranges', () {
        test('Not from zero', () {
          final rangeList = Range.named(start: -2, end: -10, closed: true).toList();
          final expectedRangeList = [-2,-3,-4,-5,-6,-7,-8,-9,-10];
          expect(rangeList, expectedRangeList);
        });

        test('From zero', () {
          final rangeList = Range.named(start: 0, end: -10, closed: true).toList();
          final expectedRangeList = [0,-1,-2,-3,-4,-5,-6,-7,-8,-9,-10];
          expect(rangeList, expectedRangeList);
        });
      });
    });
  });

  group('Reversed ranges', () {
    group('Positive', () {
      group('Open ranges', () {
        test('Not to zero', () {
          final rangeList = Range.named(start: 10, end: 2, closed: false).toList();
          final expectedRangeList = [10,9,8,7,6,5,4,3];
          expect(rangeList, expectedRangeList);
        });

        test('To zero', () {
          final rangeList = Range.named(start: 10, end: 0, closed: false).toList();
          final expectedRangeList = [10,9,8,7,6,5,4,3,2,1];
          expect(rangeList, expectedRangeList);
        });
      });

      group('Closed ranges', () {
        test('Not to zero', () {
          final rangeList = Range.named(start: 10, end: 2, closed: true).toList();
          final expectedRangeList = [10,9,8,7,6,5,4,3,2];
          expect(rangeList, expectedRangeList);
        });

        test('To zero', () {
          final rangeList = Range.named(start: 10, end: 0, closed: true).toList();
          final expectedRangeList = [10,9,8,7,6,5,4,3,2,1,0];
          expect(rangeList, expectedRangeList);
        });
      });
    });

    group('Negative', () {
      group('Open ranges', () {
        test('Not to zero', () {
          final rangeList = Range.named(start: -10, end: -2, closed: false).toList();
          final expectedRangeList = [-10,-9,-8,-7,-6,-5,-4,-3];
          expect(rangeList, expectedRangeList);
        });

        test('To zero', () {
          final rangeList = Range.named(start: -10, end: 0, closed: false).toList();
          final expectedRangeList = [-10,-9,-8,-7,-6,-5,-4,-3,-2,-1];
          expect(rangeList, expectedRangeList);
        });
      });

      group('Closed ranges', () {
        test('Not to zero', () {
          final rangeList = Range.named(start: -10, end: -2, closed: true).toList();
          final expectedRangeList = [-10,-9,-8,-7,-6,-5,-4,-3,-2];
          expect(rangeList, expectedRangeList);
        });

        test('To zero', () {
          final rangeList = Range.named(start: -10, end: 0, closed: true).toList();
          final expectedRangeList = [-10,-9,-8,-7,-6,-5,-4,-3,-2,-1,0];
          expect(rangeList, expectedRangeList);
        });
      });
    });
  });

  group('Stepped ranges', () {
    group('Positive', () {
      group('Open ranges', () {
        test('Not to zero', () {
          final rangeList = Range.bySteps(10,2, stride: 2, closed: false).toList();
          final rangeListEquivalent = Range.bySteps(2,10, stride: -2, closed: false).toList();
          final expectedRangeList = [10,8,6,4];
          expect(rangeList, rangeListEquivalent);
          expect(rangeList, expectedRangeList);
        });

        test('To zero', () {
          final rangeList = Range.bySteps(10,0, stride: 2, closed: false).toList();
          final rangeListEquivalent = Range.bySteps(0,10, stride: -2, closed: false).toList();
          final expectedRangeList = [10,8,6,4,2];
          expect(rangeList, rangeListEquivalent);
          expect(rangeList, expectedRangeList);
        });
      });

      group('Closed ranges', () {
        test('Not to zero', () {
          final rangeList = Range.bySteps(10,2, stride: 2, closed: true).toList();
          final rangeListEquivalent = Range.bySteps(2,10, stride: -2, closed: true).toList();
          final expectedRangeList = [10,8,6,4,2];
          expect(rangeList, rangeListEquivalent);
          expect(rangeList, expectedRangeList);
        });

        test('To zero', () {
          final rangeList = Range.bySteps(10,0, stride: 2, closed: true).toList();
          final rangeListEquivalent = Range.bySteps(0,10, stride: -2, closed: true).toList();
          final expectedRangeList = [10,8,6,4,2,0];
          expect(rangeList, rangeListEquivalent);
          expect(rangeList, expectedRangeList);
        });
      });
    });

    group('Negative', () {
      group('Open ranges', () {
        test('Not to zero', () {
          final rangeList = Range.bySteps(-10,-2, stride: 2, closed: false).toList();
          final rangeListEquivalent = Range.bySteps(-2,-10, stride: -2, closed: false).toList();
          final expectedRangeList = [-10,-8,-6,-4];
          expect(rangeList, rangeListEquivalent);
          expect(rangeList, expectedRangeList);
        });

        test('To zero', () {
          final rangeList = Range.bySteps(-10,0, stride: 2, closed: false).toList();
          final rangeListEquivalent = Range.bySteps(0,-10, stride: -2, closed: false).toList();
          final expectedRangeList = [-10,-8,-6,-4,-2];
          expect(rangeList, rangeListEquivalent);
          expect(rangeList, expectedRangeList);
        });
      });

      group('Closed ranges', () {
        test('Not to zero', () {
          final rangeList = Range.bySteps(-10,-2, stride: 2, closed: true).toList();
          final rangeListEquivalent = Range.bySteps(-2,-10, stride: -2, closed: true).toList();
          final expectedRangeList = [-10,-8,-6,-4,-2];
          expect(rangeList, rangeListEquivalent);
          expect(rangeList, expectedRangeList);
        });

        test('To zero', () {
          final rangeList = Range.bySteps(-10,0, stride: 2, closed: true).toList();
          final rangeListEquivalent = Range.bySteps(0,-10, stride: -2, closed: true).toList();
          final expectedRangeList = [-10,-8,-6,-4,-2,0];
          expect(rangeList, rangeListEquivalent);
          expect(rangeList, expectedRangeList);
        });
      });
    });
  });
}
