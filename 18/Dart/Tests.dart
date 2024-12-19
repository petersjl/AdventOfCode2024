import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../Utils/DartUtils.dart';
import 'Solution.dart';

void main() {
  for (var (file, p1, p2) in [
    (1, 22, "6,1"),
  ])
    group("Check sample input $file passes for part", () {
      late var input;
      setUp(() {
        input = parseInput(Utils.readToString('../testinput.$file.txt'));
      });
      test("1", () {
        expect(solvePart1(input, 6, 12), p1.toString());
      });
      test("2", () {
        expect(solvePart2(input, 6, 12), p2.toString());
      });
    });

  group("Check actual input passes for part", () {
    late var input;
    setUp(() {
      input = parseInput(Utils.readToString('../input.txt'));
    });
    test("1", () {
      expect(solvePart1(input), "446");
    });
    test("2", () {
      expect(solvePart2(input), "39,40");
    });
  });
}
