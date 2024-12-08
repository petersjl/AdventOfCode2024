// ignore_for_file: dead_code

import 'dart:math';

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

typedef InputType = List<Pair<int, List<int>>>;

InputType parseInput(String input) {
  return input.splitNewLine().listMap((line) {
    var parts = line.split(": ");
    return Pair(int.parse(parts[0]), Utils.ParseIntList(parts[1]));
  });
}

int add(int a, int b) => a + b;
int mul(int a, int b) => a * b;
int cat(int a, int b) => (a * pow(10, log(b).ceil()).ceil()) + b;

int getLineValue(int target, List<int> operands,
    {List<int Function(int a, int b)>? operators = null}) {
  operators = operators ?? [add, mul];
  Stack<(int, int)> possibilities = new Stack();
  possibilities.push((operands[0], 1));
  while (!possibilities.isEmpty) {
    var (total, depth) = possibilities.pop();
    if (depth == operands.length) {
      if (total == target) return target;
      continue;
    }
    for (var op in operators) {
      possibilities.push((op(total, operands[depth]), depth + 1));
    }
  }
  return 0;
}

String solvePart1(InputType input) {
  int total = 0;
  for (var line in input) total += getLineValue(line.first, line.second);
  return total.toString();
}

String solvePart2(InputType input) {
  int total = 0;
  for (var line in input)
    total += getLineValue(line.first, line.second, operators: [add, mul, cat]);
  return total.toString();
}
