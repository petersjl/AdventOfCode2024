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
      expect(solvePart1(input), "3749");
    });
    test("2", () {
      expect(solvePart2(input), "11387");
    });
  });

  group("Check getLineValue", () {
    var good = {
      (190, [10, 19]): 190,
      (3267, [81, 40, 27]): 3267,
    };
    good.forEach((input, expected) =>
        test("returns value of good lines: ${expected}", () {
          expect(getLineValue(input.$1, input.$2), expected);
        }));

    var bad = {
      (21037, [9, 7, 18, 13]): 0,
      (192, [17, 8, 14]): 0,
    };
    bad.forEach((input, expected) =>
        test("returns value of good lines: ${expected}", () {
          expect(getLineValue(input.$1, input.$2), expected);
        }));
  });
}
