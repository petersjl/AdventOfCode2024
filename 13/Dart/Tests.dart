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
      expect(solvePart1(input), "480");
    });
    test("2", () {
      expect(solvePart2(input), "875318608908");
    });
  });

  group("Check actual input passes for part", () {
    late var input;
    setUp(() {
      input = parseInput(Utils.readToString('../input.txt'));
    });
    test("1", () {
      expect(solvePart1(input), "26005");
    });
    test("2", () {
      expect(solvePart2(input), "105620095782547");
    });
  });
}
