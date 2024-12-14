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
      expect(solvePart1(input, Point(11, 7)), "12");
    });
    // There is no example for Part 2
  });

  group("Check sample input passes for part", () {
    late var input;
    setUp(() {
      input = parseInput(Utils.readToString('../input.txt'));
    });
    test("1", () {
      expect(solvePart1(input), "211773366");
    });
    test("2", () {
      expect(solvePart2(input), "7344");
    });
  });
}
