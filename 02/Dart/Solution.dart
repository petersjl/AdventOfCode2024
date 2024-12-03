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

List<List<int>> parseInput(String input) {
  return input.splitNewLine().listMap(
      (line) => line.splitWhitespace().listMap((number) => int.parse(number)));
}

bool checkLineSafety(List<int> line) {
  int comparator = line[0].compareTo(line[1]);
  for (int i = 0; i < line.length - 1; i++) {
    if (line[i].compareTo(line[i + 1]) != comparator) return false;
    int diff = (line[i] - line[i + 1]).abs();
    if (diff < 1 || 3 < diff) return false;
  }
  return true;
}

bool checkLineSafetyWithFail(List<int> line) {
  if (checkLineSafety(line)) return true;
  for (int i = 0; i < line.length; i++) {
    if (checkLineSafety(List.of(line)..removeAt(i))) return true;
  }
  return false;
}

String solvePart1(List<List<int>> input) {
  int safeLines = 0;
  input.forEach((line) {
    if (checkLineSafety(line)) safeLines += 1;
  });
  return safeLines.toString();
}

String solvePart2(List<List<int>> input) {
  int safeLines = 0;
  input.forEach((line) {
    if (checkLineSafetyWithFail(line)) safeLines += 1;
  });
  return safeLines.toString();
}
