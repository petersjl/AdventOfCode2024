// ignore_for_file: dead_code

import '../../Utils/DartUtils.dart';

void main() {
  bool runP1 = true;
  bool runP2 = true;
  String solutionP1 = "", solutionP2 = "";

  var rawInput = Utils.readToString("../input.txt");

  Stopwatch stopwatch = new Stopwatch()..start();
  var input = parseInput(rawInput);
  var timeParse = stopwatch.elapsed;

  if (runP1) solutionP1 = solvePart1(input);
  var timeP1 = stopwatch.elapsed;
  if (runP2) solutionP2 = solvePart2(input);
  var timeP2 = stopwatch.elapsed;
  stopwatch.stop();

  print('Parse time: ${Utils.timingString(timeParse)}');
  if (runP1)
    print('Part 1 (${Utils.timingString(timeP1 - timeParse)}): ${solutionP1}');
  if (runP2)
    print('Part 2 (${Utils.timingString(timeP2 - timeP1)}): ${solutionP2}');
  print('Ran in ${Utils.timingString(timeP2)}');
}

typedef InputType = List<ClawMachine>;

class ClawMachine {
  Point A, B, P;
  ClawMachine(Point A, Point B, Point P)
      : A = A,
        B = B,
        P = P {}
}

InputType parseInput(String input) {
  return input.splitDoubleNewLine().listMap((group) {
    var points = group.splitNewLine().listMap((line) {
      var halves = line.split(', ');
      var x = halves[0].substring(halves[0].indexOf('X') + 2);
      var y = halves[1].substring(2);
      return Point(int.parse(x), int.parse(y));
    });
    return ClawMachine(points[0], points[1], points[2]);
  });
}

(int, int) findButtonsForClaw(ClawMachine m, [int offset = 0]) {
  Point P = m.P + Point(offset, offset);
  int A = (m.B.y * P.x - m.B.x * P.y) ~/ (m.B.y * m.A.x - m.B.x * m.A.y);
  int B = (P.y - A * m.A.y) ~/ m.B.y;
  if (A * m.A.x + B * m.B.x == P.x && A * m.A.y + B * m.B.y == P.y)
    return (A, B);
  else
    return (-1, -1);
}

String solvePart1(InputType input) {
  int price = 0;
  for (var machine in input) {
    var (A, B) = findButtonsForClaw(machine);
    if (A == -1) continue;
    price += 3 * A + B;
  }
  return price.toString();
}

String solvePart2(InputType input) {
  int price = 0;
  int offset = 10000000000000;
  for (var machine in input) {
    var (A, B) = findButtonsForClaw(machine, offset);
    if (A == -1) continue;
    price += 3 * A + B;
  }
  return price.toString();
}
