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

  group('Constructors', () {

    group('Normal', () {
      test('Named vs closed', () {
        final closedFromConstructor = Range.named(start: 0, end: 3, closed: true);
        final closedFromFunction = Range.closed(0, 3);
        expect(closedFromConstructor, closedFromFunction);
        expect(closedFromConstructor.toList(), closedFromFunction.toList());
      });
      test('Unnamed open', () {
        const range = Range(0,7);
        for (int i = 0; i < 7; i++) {
          expect(range.contains(i), isTrue);
        }
      });
      test('Named vs unnamed closed', () {
        const range = Range(0,7, closed: true);
        const rangeNamed = Range.closed(0,7);
        expect(range, rangeNamed);
        expect(range.toList(), rangeNamed.toList());
        for (int i = 0; i <= 7; i++) {
          expect(range.contains(i), isTrue);
        }
      });
    });

    group('Reversed', () {
      test('Named vs closed', () {
        final closedFromConstructor = Range.named(start: 3, end: 0, closed: true);
        final closedFromFunction = Range.closed(3,0);
        expect(closedFromConstructor, closedFromFunction);
        expect(closedFromConstructor.toList(), closedFromFunction.toList());
      });
      test('Unnamed open', () {
        const range = Range(7, 0);
        for (int i = 7; i > 0; i--) {
          expect(range.contains(i), isTrue);
        }
      });
      test('Named vs unnamed closed', () {
        const range = Range(7,0, closed: true);
        const rangeNamed = Range.closed(7,0);
        expect(range, rangeNamed);
        expect(range.toList(), rangeNamed.toList());
        for (int i = 7; i >= 0; i--) {
          expect(range.contains(i), isTrue);
        }
      });
    });

  });

  group('Methods & properties', () {

    group('contains', () {
      test('other objects', () {
        expect(Range(0,10).contains("hello"), isFalse);
        expect(Range(0,10).contains(true), isFalse);
        expect(Range(0,10).contains({0: "hola"}), isFalse);
        expect(Range(0,10).contains([1,2,3]), isTrue);
        expect(Range(0,10).contains([0,6,9]), isTrue);
        expect(Range(0,10).contains([2,-6,7]), isFalse);
      });
      group('open', () {
        test('From zero', () {
          expect(Range(0,7).contains(0), isTrue);
          expect(Range(0,7).contains(-1), isFalse);
          expect(Range(0,7).contains(6), isTrue);
          expect(Range(0,7).contains(7), isFalse);
          expect(Range(0,7).contains(6.99), isTrue);
        });
        test('Not from zero', () {
          expect(Range(1,7).contains(0), isFalse);
          expect(Range(1,7).contains(-1), isFalse);
          expect(Range(1,7).contains(6), isTrue);
          expect(Range(1,7).contains(7), isFalse);
          expect(Range(1,7).contains(6.99), isTrue);
        });
      });
      group('closed', () {
        test('From zero', () {
          expect(Range.closed(0,7).contains(0), isTrue);
          expect(Range.closed(0,7).contains(-1), isFalse);
          expect(Range.closed(0,7).contains(6), isTrue);
          expect(Range.closed(0,7).contains(7), isTrue);
          expect(Range.closed(0,7).contains(7.1), isFalse);
        });
        test('Not from zero', () {
          expect(Range.closed(1,7).contains(0), isFalse);
          expect(Range.closed(1,7).contains(-1), isFalse);
          expect(Range.closed(1,7).contains(6), isTrue);
          expect(Range.closed(1,7).contains(7), isTrue);
          expect(Range.closed(1,7).contains(7.1), isFalse);
        });
      });
    });

    group('operator==', () {
      test('all', () {
        expect(Range(0,7), Range(0,7));
        expect(Range(0,7), Range.closed(0,6));
        expect(Range(1,7), Range(1,7));
        expect(Range(1,7), Range.closed(1,6));
        expect(Range(7,1), Range(7,1));
        expect(Range(7,0), Range.closed(7,1));
      });
    });

    group('hashcode', () {
      test('all', () {
        expect(Range(0,7).hashCode, Range(0,7).hashCode);
        expect(Range(0,7).hashCode, Range.closed(0,6).hashCode);
        expect(Range(1,7).hashCode, Range(1,7).hashCode);
        expect(Range(1,7).hashCode, Range.closed(1,6).hashCode);
        expect(Range(7,1).hashCode, Range(7,1).hashCode);
        expect(Range(7,0).hashCode, Range.closed(7,1).hashCode);
      });
    });

    group('toString()', () {
      test('normal', () {
        expect(Range(0,7).toString(), "(0..<7)");
        expect(Range.closed(0,6).toString(), "(0...6)");
        expect(Range(1,7).toString(), "(1..<7)");
        expect(Range.closed(1,6).toString(), "(1...6)");
        expect(Range(7,1).toString(), "(7..>1)");
        expect(Range(7,0).toString(), "(7..>0)");
        expect(Range.closed(7,1).toString(), "(7...1)");
      });
      test('By steps', () {
        expect(Range.bySteps(0,7, stride: 2, closed: false).toString(), "(0..<7, stride: 2)");
        expect(Range.bySteps(0,6, stride: 2, closed: true).toString(), "(0...6, stride: 2)");
        expect(Range.bySteps(1,7, stride: 4, closed: false).toString(), "(1..<7, stride: 4)");
        expect(Range.bySteps(1,6, stride: 2, closed: true).toString(), "(1...6, stride: 2)");
        expect(Range.bySteps(7,1, stride: 3, closed: false).toString(), "(7..>1, stride: 3)");
        expect(Range.bySteps(7,0, stride: 4, closed: false).toString(), "(7..>0, stride: 4)");
        expect(Range.bySteps(7,1, stride: 5, closed: true).toString(), "(7...1, stride: 5)");
      });
    });
  });

}
