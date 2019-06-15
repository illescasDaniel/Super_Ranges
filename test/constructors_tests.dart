//import 'package:test/test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:super_ranges/super_ranges.dart';

void main() {
  group('Constructors', () {

    group('to', () {
      test('to constructor vs named', () {
        const rangeA = Range.named(start: 0, end: 10, closed: false);
        const rangeB = Range.to(10);
        expect(rangeB, rangeA);
        expect(rangeB == Range(1,9), isFalse);
        expect(rangeB == Range(0,9), isFalse);
        expect(rangeB.lowerBound, 0);
        expect(rangeB.upperBound, 9);
        expect(rangeB.length, 10);
        expect(rangeB.contains([0,9]), isTrue);
        expect(rangeB.contains(10), isFalse);
      });
      test('to constructor vs normal', () {
        const rangeA = Range(0, 10, closed: false);
        const rangeB = Range.to(10);
        expect(rangeB, rangeA);
      });
    });

    group('to inclusive', () {
      test('to inclusive constructor vs named', () {
        const rangeA = Range.named(start: 0, end: 10, closed: true);
        const rangeB = Range.toInclusive(10);
        const rangeC = Range.to(11);
        expect(rangeB, rangeA);
        expect(rangeB, rangeC);
      });
      test('to inclusive constructor vs normal', () {
        const rangeA = Range(0, 10, closed: true);
        const rangeB = Range.toInclusive(10);
        const rangeC = Range.to(11);
        expect(rangeB, rangeA);
        expect(rangeB, rangeC);
      });
    });

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

    test('By range', () {
      expect(StrideRange.named(start: 2, end: 34, stride: 5, closed: true).toList(), StrideRange(2, 34, stride: 5).toList());
      expect(Range.bySteps(2, 34, stride: 5).toList(), StrideRange(2, 34, stride: 5).toList());
      expect(StrideRange.named(start: 2, end: 34, stride: 5, closed: true), StrideRange(2, 34, stride: 5));
      expect(Range.bySteps(2, 34, stride: 5), StrideRange(2, 34, stride: 5));
    });

  });
}