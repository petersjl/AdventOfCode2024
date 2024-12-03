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

List<Pair<int, int>> parseInput(String input) {
  return input.splitNewLine().listMap<Pair<int, int>>((line) {
    var parts = line.splitWhitespace();
    return new Pair(int.parse(parts[0]), int.parse(parts[1]));
  });
}

String solvePart1(List<Pair<int, int>> input) {
  var left_nums = input.listMap<int>((element) => element.first);
  var right_nums = input.listMap<int>((element) => element.second);
  left_nums.sort();
  right_nums.sort();
  int dist = 0;
  for (int i = 0; i < left_nums.length; i++) {
    dist += (right_nums[i] - left_nums[i]).abs();
  }
  return dist.toString();
}

String solvePart2(List<Pair<int, int>> input) {
  var left_nums = input.listMap<int>((element) => element.first);
  var right_nums = input.listMap<int>((element) => element.second);
  var counts = new Map<int, int>();
  right_nums.forEach((number) => counts.increment(number));
  var score = left_nums.collect<int>(0, (soFar, number) {
    return soFar + (number * (counts[number] ?? 0));
  });
  return score.toString();
}
