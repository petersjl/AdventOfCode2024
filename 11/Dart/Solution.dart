// ignore_for_file: dead_code

import '../../Utils/DartUtils.dart';

void main() {
  bool runP1 = true;
  bool runP2 = true;
  String solutionP1 = "", solutionP2 = "";

  Stopwatch stopwatch = new Stopwatch()..start();
  var input = parseInput(Utils.readToString("../input.txt"));
  var timeParse = stopwatch.elapsedMilliseconds;

  if (runP1) solutionP1 = solvePart1(input);
  var timeP1 = stopwatch.elapsedMilliseconds;
  if (runP2) solutionP2 = solvePart2(input);
  var timeP2 = stopwatch.elapsedMilliseconds;

  print('Parse time: ${timeParse * 1 / 1000}s');
  if (runP1)
    print('Part 1 (${(timeP1 - timeParse) * 1 / 1000}s): ${solutionP1}');
  if (runP2) print('Part 2 (${(timeP2 - timeP1) * 1 / 1000}s): ${solutionP2}');
  print('Ran in ${stopwatch.elapsedMilliseconds * 1 / 1000} seconds');
}

typedef InputType = List<String>;

InputType parseInput(String input) {
  return input.split(' ');
}

void runRulesOld(List<int> stones) {
  for (int i = 0; i < stones.length; i++) {
    var stone = stones[i];
    if (stone == 0) {
      stones[i] = 1;
      continue;
    }
    var stoneString = stone.toString();
    if (stoneString.length & 1 == 0) {
      int leftStone =
          int.parse(stoneString.substring(0, stoneString.length ~/ 2));
      int rightStone =
          int.parse(stoneString.substring(stoneString.length ~/ 2));
      stones[i] = leftStone;
      stones.insert(i + 1, rightStone);
      i++;
      continue;
    }
    stones[i] *= 2024;
  }
}

Map<String, int> runRules(Map<String, int> stones) {
  Map<String, int> newStones = {};
  if (stones["0"] != null) {
    newStones["1"] = stones["0"]!;
    stones.remove("0");
  }
  for (var entry in stones.entries) {
    if (entry.key.length & 1 == 0) {
      String leftStone = entry.key.substring(0, entry.key.length ~/ 2);
      newStones.update(leftStone, (value) => value + entry.value,
          ifAbsent: () => entry.value);
      // Find the right stone and parse to remove leading zeroes
      String rightStone =
          int.parse(entry.key.substring(entry.key.length ~/ 2)).toString();
      newStones.update(rightStone, (value) => value + entry.value,
          ifAbsent: () => entry.value);
    } else {
      String newStone = (int.parse(entry.key) * 2024).toString();
      newStones.update(newStone, (value) => value + entry.value,
          ifAbsent: () => entry.value);
    }
  }
  return newStones;
}

String solvePart1(InputType input, [int runCount = 25]) {
  Map<String, int> stones = {};
  input.forEach((str) => stones.increment(str));
  for (int i = 0; i < runCount; i++) {
    stones = runRules(stones);
  }
  int count = stones.values.fold(0, (run, value) => run + value);
  return count.toString();
}

String solvePart2(InputType input, [int runCount = 75]) {
  return solvePart1(input, 75);
}
