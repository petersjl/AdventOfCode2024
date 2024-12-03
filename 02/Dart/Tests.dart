import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../Utils/DartUtils.dart';
import 'Solution.dart';

void main() {
  group("Check sample input passes for part", () {
    late var input;
    setUp(() {
      input = parseInput(Utils.readToString('../testinput.txt'));
    });
    test("1", () {
      expect(solvePart1(input), "2");
    });
    test("2", () {
      expect(solvePart2(input), "4");
    });
  });

  group("Check Line Safety", () {
    test("handles increasing numbers", () {
      expect(checkLineSafety([2, 4, 6]), true);
    });
    test("handles decreasing numbers", () {
      expect(checkLineSafety([6, 4, 2]), true);
    });
    test("checks distance between numbers", () {
      expect(checkLineSafety([1, 2, 3]), true);
      expect(checkLineSafety([3, 6, 9]), true);
      expect(checkLineSafety([1, 1, 1]), false);
      expect(checkLineSafety([1, 5, 9]), false);
    });
  });

  group("Check Line Safety With Fails", () {
    test("handles allowing fails", () {
      expect(checkLineSafetyWithFail([1, 2, 3]), true);
      expect(checkLineSafetyWithFail([1, 6, 2]), true);
      expect(checkLineSafetyWithFail([1, 6, 7, 2]), false);
    });
  });
}
