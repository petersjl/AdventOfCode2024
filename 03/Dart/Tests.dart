import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../Utils/DartUtils.dart';
import 'Solution.dart';

void main() {
  group("Check sample input passes for part", () {
    test("1", () {
      var input = parseInput(Utils.readToString('../testinput.txt'));
      expect(solvePart1(input), "161");
    });
    test("2", () {
      var input = parseInput(Utils.readToString('../testinput2.txt'));
      expect(solvePart2(input), "48");
    });
  });
}
