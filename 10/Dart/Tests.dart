import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../Utils/DartUtils.dart';
import 'Solution.dart';

void main() {
  var input = parseInput(Utils.readToString('../testinput.txt'));
  group("Check sample input passes for part", () {
    test("1", () {
      expect(solvePart1(input), "36");
    });
    test("2", () {
      expect(solvePart2(input), "81");
    });
  });
  test("Get trail head score", () {
    expect(getTrailheadScore(input.$1, Point(2, 0)), 5);
  });
}
