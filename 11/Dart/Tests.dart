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
    test("1.1", () {
      expect(solvePart1(input, 6), "22");
    });
    test("1.2", () {
      expect(solvePart1(input), "55312");
    });
    test("2", () {
      expect(solvePart2(input), "65601038650482");
    });
  });
}
