//import 'package:test/test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:super_ranges/super_ranges.dart';

void main() {
  group('Methods & properties', () {

    group('lower/upper bounds', () {
      test('lowerBound', () {
        expect(Range(2,4).lowerBound, 2);
        expect(Range(1,4).lowerBound, 1);
        expect(Range(0,4).lowerBound, 0);
        expect(Range(-1,4).lowerBound, -1);
        expect(Range(4,4).lowerBound, 4);
        expect(Range(5,4).lowerBound, 5);
        expect(Range(7,4).lowerBound, 5);
        expect(Range(-5,4).lowerBound, -5);

        expect(Range.closed(2,4).lowerBound, 2);
        expect(Range.closed(1,4).lowerBound, 1);
        expect(Range.closed(0,4).lowerBound, 0);
        expect(Range.closed(-1,4).lowerBound, -1);
        expect(Range.closed(4,4).lowerBound, 4);
        expect(Range.closed(5,4).lowerBound, 4);
        expect(Range.closed(7,4).lowerBound, 4);
        expect(Range.closed(-5,4).lowerBound, -5);
      });
      test('upperBound', () {
        expect(Range(2,4).upperBound, 3);
        expect(Range(1,4).upperBound, 3);
        expect(Range(0,4).upperBound, 3);
        expect(Range(-1,4).upperBound, 3);
        expect(Range(4,4).upperBound, 3);
        expect(Range(5,4).upperBound, 5);
        expect(Range(7,4).upperBound, 7);
        expect(Range(-5,4).upperBound, 3);

        expect(Range.closed(2,4).upperBound, 4);
        expect(Range.closed(1,4).upperBound, 4);
        expect(Range.closed(0,4).upperBound, 4);
        expect(Range.closed(-1,4).upperBound, 4);
        expect(Range.closed(4,4).upperBound, 4);
        expect(Range.closed(5,4).upperBound, 5);
        expect(Range.closed(7,4).upperBound, 7);
        expect(Range.closed(-5,4).upperBound, 4);
      });
    });

    group('randomElement', () {
      group('not reversed', () {
        group('positive', () {
          test('normal', () {
            for (int i = 0; i < 5; i++) {
              for (int j = 0; j < 50; j++) {
                if (i > j) { continue; }
                final element = Range(i,j).randomElement;
                expect(element == i || (element > i && element < j), isTrue);
                final element2 = Range.closed(i,j).randomElement;
                expect(element2 == i || (element2 > i && element2 <= j), isTrue);
              }
            }
          });
          test('By steps', () {
            for (int i = 0; i < 5; i++) {
              for (int j = 1; j < 50; j++) {
                for (int s = 2; s < 4; s++) {
                  if (i > j) { continue; }
                  final element = Range.bySteps(i, j, stride: 2).randomElement;
                  expect(element == i || (element > i && element <= j), isTrue);
                  expect(element != i+1, isTrue);

                  final element2 = Range.bySteps(i, j, stride: 2, closed: false).randomElement;
                  expect(element2 == i || (element2 > i && element2 < j), isTrue);
                  expect(element2 != i+1, isTrue);
                }
              }
            }
          });
        });
        group('negative', () {
          test('normal', () {
            for (int i = 0; i < 50; i++) {
              for (int j = 0; j < 5; j++) {
                if (-i > -j) { continue; }
                final element = Range(-i,-j).randomElement;
                expect(element == -i || (element > -i && element < -j), isTrue);
                final element2 = Range.closed(-i,-j).randomElement;
                expect(element2 == -i || (element2 > -i && element2 <= -j), isTrue);
              }
            }
          });
          test('By steps', () {
            for (int i = 0; i < 50; i++) {
              for (int j = 1; j < 5; j++) {
                for (int s = 2; s < 4; s++) {
                  if (-i > -j) { continue; }
                  final element = Range.bySteps(-i, -j, stride: 2).randomElement;
                  expect(element == -i || (element > -i && element <= -j), isTrue);
                  expect(element != -i+1, isTrue);

                  final element2 = Range.bySteps(-i, -j, stride: 2, closed: false).randomElement;
                  expect(element2 == -i || (element2 > -i && element2 < -j), isTrue);
                  expect(element2 != -i+1, isTrue);
                }
              }
            }
          });
        });
      });
      group('reversed', () {
        group('positive', () {
          test('normal', () {
            for (int i = 50; i > 0; i--) {
              for (int j = 5; j > 0; j--) {
                if (i < j) { continue; }
                final element = Range(i,j).randomElement;
                expect(element == i || (element < i && element > j), isTrue);
                final element2 = Range.closed(i,j).randomElement;
                expect(element2 == i || (element2 < i && element2 >= j), isTrue);
              }
            }
          });
          test('By steps', () {
            for (int i = 50; i > 0; i--) {
              for (int j = 5; j > 0; j--) {
                for (int s = 2; s < 4; s++) {
                  if (i < j) { continue; }

                  final element = Range.bySteps(i, j, stride: 2).randomElement;
                  expect(element == i || (element <= i && element >= j), isTrue);

                  final element2 = Range.bySteps(i, j, stride: 2, closed: false).randomElement;
                  expect(element2 == i || (element2 <= i && element2 > j), isTrue);
                }
              }
            }
          });
        });
        group('negative', () {
          test('normal', () {
            for (int i = 0; i < 5; i++) {
              for (int j = 0; j < 50; j++) {
                if (-i < -j) { continue; }
                final element = Range(-i,-j).randomElement;
                expect(element == -i || (element < -i && element > -j), isTrue);
                final element2 = Range.closed(-i,-j).randomElement;
                expect(element2 == -i || (element2 < -i && element2 >= -j), isTrue);
              }
            }
          });
          test('By steps', () {
            for (int i = 0; i < 5; i++) {
              for (int j = 1; j < 50; j++) {
                for (int s = 2; s < 4; s++) {
                  if (-i < -j) { continue; }

                  final element = Range.bySteps(-i, -j, stride: 2).randomElement;
                  expect(element == -i || (element <= -i && element >= -j), isTrue);

                  final element2 = Range.bySteps(-i, -j, stride: 2, closed: false).randomElement;
                  expect(element2 == -i || (element2 <= -i && element2 > -j), isTrue);
                }
              }
            }
          });
        });
      });
    });

    group('sum', () {
      group('not reversed', () {
        group('positive', () {
          test('normal', () {
            for (int i = 0; i < 5; i++) {
              for (int j = 0; j < 50; j++) {
                if (i > j) { continue; }
                if (i == j) {
                  expect(Range(i,j).sum, 0);
                  expect(Range.closed(i,j).sum, i);
                  continue;
                }
                expect(Range(i,j).sum,
                      Range(i,j).reduce((acc, newValue) => acc + newValue));
                expect(Range.closed(i,j).sum,
                    Range.closed(i,j).reduce((acc, newValue) => acc + newValue));
              }
            }
          });
          test('By steps', () {
            for (int i = 0; i < 5; i++) {
              for (int j = 1; j < 50; j++) {
                for (int s = 2; s < 4; s++) {
                  if (i == j) {
                    continue;
                  }
                  expect(Range.bySteps(i, j, stride: 2).sum,
                      Range.bySteps(i, j, stride: 2)
                          .reduce((acc, newValue) => acc + newValue));
                }
              }
            }
          });
        });
        group('negative', () {
          test('normal', () {
            for (int i = 0; i < 50; i++) {
              for (int j = 0; j < 5; j++) {
                if (-i > -j) { continue; }
                if (i == j) {
                  expect(Range(-i,-j).sum, 0);
                  continue;
                }
                expect(Range(-i,-j).sum,
                    Range(-i,-j).reduce((acc, newValue) => acc + newValue));
                expect(Range.closed(-i,-j).sum,
                      Range.closed(-i,-j).reduce((acc, newValue) => acc + newValue));
              }
            }
          });
          test('By steps', () {
            for (int i = 0; i < 50; i++) {
              for (int j = 1; j < 5; j++) {
                for (int s = 2; s < 4; s++) {
                  if (-i > -j) { continue; }
                  if (i == j) {
                    expect(Range.bySteps(-i, -j, stride: 2).sum, -i);
                    continue;
                  }
                  expect(Range.bySteps(-i, -j, stride: 2).sum,
                      Range.bySteps(-i, -j, stride: 2)
                          .reduce((acc, newValue) => acc + newValue));
                }
              }
            }
          });
        });
      });
      group('reversed', () {
        group('positive', () {
          test('normal', () {
            for (int i = 50; i > 0; i--) {
              for (int j = 5; j > 0; j--) {
                if (i == j) {
                  expect(Range(i,j).sum, 0);
                  continue;
                }
                expect(Range(i,j).sum,
                    Range(i,j).reduce((acc, newValue) => acc + newValue));
                expect(Range.closed(i,j).sum,
                    Range.closed(i,j).reduce((acc, newValue) => acc + newValue));
              }
            }
          });
          test('By steps', () {
            for (int i = 50; i > 0; i--) {
              for (int j = 5; j > 0; j--) {
                for (int s = 2; s < 4; s++) {
                  if (i == j) {
                    expect(Range(i,j).sum, 0);
                    continue;
                  }
                  expect(Range.bySteps(i, j, stride: 2).sum,
                      Range.bySteps(i, j, stride: 2)
                          .reduce((acc, newValue) => acc + newValue));
                }
              }
            }
          });
        });
        group('negative', () {
          test('normal', () {
            for (int i = 0; i < 5; i++) {
              for (int j = 0; j < 50; j++) {
                if (i == j) {
                  expect(Range(-i,-j).sum, 0);
                  continue;
                }
                expect(Range(-i,-j).sum,
                    Range(-i,-j).reduce((acc, newValue) => acc + newValue));
                expect(Range.closed(-i,-j).sum,
                    Range.closed(-i,-j).reduce((acc, newValue) => acc + newValue));
              }
            }
          });
          test('By steps', () {
            for (int i = 0; i < 5; i++) {
              for (int j = 1; j < 50; j++) {
                for (int s = 2; s < 4; s++) {
                  if (-i > -j) { continue; }
                  if (i == j) {
                    expect(Range(-i,-j).sum, 0);
                    continue;
                  }
                  expect(Range.bySteps(-i, -j, stride: 2).sum,
                      Range.bySteps(-i, -j, stride: 2)
                          .reduce((acc, newValue) => acc + newValue));
                }
              }
            }
          });
        });
      });
    });

    group('length', () {

      test('basic', () {
        expect(Range(0,0).length, 0);
        expect(Range(0,0).length, Range(0,0).expensiveLength);

        expect(Range.closed(0,0).length, 1);
        expect(Range.closed(0,0).length, Range.closed(0,0).expensiveLength);

        expect(Range(0,1).length, 1);
        expect(Range(0,1).length, Range(0,1).expensiveLength);

        expect(Range.closed(0,1).length, 2);
        expect(Range.closed(0,1).length, Range.closed(0,1).expensiveLength);
      });

      group('positive', () {

        group('normal', () {
          test('open', () {
            for (int i = 0; i < 10; i++) {
              for (int j = 0; j < 100; j++) {
                expect(Range(i,j).length, Range(i,j).expensiveLength);
              }
            }
          });
          test('closed', () {
            for (int i = 0; i < 10; i++) {
              for (int j = 0; j < 100; j++) {
                expect(Range.closed(i,j).length, Range.closed(i,j).expensiveLength);
              }
            }
          });
        });

        group('reversed', () {
          test('open', () {
            for (int i = 0; i < 100; i++) {
              for (int j = 0; j < 10; j++) {
                expect(Range(i,j).length, Range(i,j).expensiveLength);
              }
            }
          });
          test('closed', () {
            for (int i = 0; i < 100; i++) {
              for (int j = 0; j < 10; j++) {
                expect(Range.closed(i,j).length, Range.closed(i,j).expensiveLength);
              }
            }
          });
        });

        group('By steps', () {
          test('open', () {
            for (int i = 0; i < 50; i++) {
              for (int j = 0; j < 5; j++) {
                expect(Range.bySteps(-j,i, stride: 2, closed: false).length,
                    Range.bySteps(-j,i, stride: 2, closed: false).expensiveLength);
              }
            }
          });
          test('closed', () {
            for (int i = 0; i < 50; i++) {
              for (int j = 0; j < 5; j++) {
                for (int s = 2; s < 5; s++) {
                  expect(Range.bySteps(-j, i, stride: 2, closed: true).length,
                      Range.bySteps(-j, i, stride: 2, closed: true).expensiveLength);
                }
              }
            }
          });
        });

      });
      group('negative', () {

        group('normal', () {
          test('open', () {
            for (int i = 10; i > 0; i--) {
              for (int j = 100; j > 0; j--) {
                expect(Range(i,j).length, Range(i,j).expensiveLength);
              }
            }
          });
          test('closed', () {
            for (int i = 10; i > 0; i--) {
              for (int j = 100; j > 0; j--) {
                expect(Range.closed(i,j).length, Range.closed(i,j).expensiveLength);
              }
            }
          });
        });

        group('reversed', () {
          test('open', () {
            for (int i = 100; i > 0; i--) {
              for (int j = 10; j > 0; j--) {
                expect(Range(i,j).length, Range(i,j).expensiveLength);
              }
            }
          });
          test('closed', () {
            for (int i = 100; i > 0; i--) {
              for (int j = 10; j > 0; j--) {
                expect(Range.closed(i,j).length, Range.closed(i,j).expensiveLength);
              }
            }
          });
        });

        group('By steps', () {
          test('open', () {
            for (int i = 0; i < 5; i++) {
              for (int j = 0; j < 10; j++) {
                for (int s = 2; s < 4; s++) {
                  expect(Range.bySteps(i,j, stride: s, closed: false).length,
                      Range.bySteps(i,j, stride: s, closed: false).expensiveLength);
                }
              }
            }
          });
          test('closed', () {
            for (int i = 0; i < 5; i++) {
              for (int j = 0; j < 10; j++) {
                for (int s = 2; s < 4; s++) {
                  expect(Range.bySteps(i,j, stride: s, closed: true).length,
                      Range.bySteps(i,j, stride: s, closed: true).expensiveLength);
                }
              }
            }
          });
        });

      });

    });

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
          expect(Range(7,3).contains(4.6), isTrue);
          expect(Range(7,3).contains(7), isTrue);
          expect(Range(7,3).contains(7.1), isFalse);
          expect(Range(7,3).contains(3.1), isTrue);
          expect(Range(7,3).contains(3), isFalse);
          expect(Range(7,3).contains(2.9), isFalse);
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
      test('By steps', () {
        expect(Range.bySteps(1,7, stride: 2).contains(1), isTrue);
        expect(Range.bySteps(3,7, stride: 2).contains(5), isTrue);
        expect(Range.bySteps(3,8, stride: 2).contains(8), isFalse);
        expect(Range.bySteps(3,8, stride: 2).contains(4), isFalse);
        expect(Range.bySteps(3,9, stride: 3).contains(6), isTrue);
        expect(Range.bySteps(3,9, stride: 3).contains(7), isFalse);
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