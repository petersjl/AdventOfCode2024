// ignore_for_file: dead_code

import 'package:test/expect.dart';

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

typedef InputType = List<(Point, Point)>;
Point defaultMap = Point(101, 103);

InputType parseInput(String input) {
  return input.splitNewLine().listMap((line) {
    var parts = line.split(' ').listMap((part) => part.substring(2).split(','));
    var p = Point(int.parse(parts[0][0]), int.parse(parts[0][1]));
    var v = Point(int.parse(parts[1][0]), int.parse(parts[1][1]));
    return (p, v);
  });
}

void runSecond(List<(Point, Point)> bots, Point map) {
  for (int i = 0; i < bots.length; i++) {
    var bot = bots[i];
    var newBotPos = bot.$1 + bot.$2;
    if (newBotPos.x < 0)
      newBotPos.x += map.x;
    else if (newBotPos.x >= map.x) newBotPos.x -= map.x;
    if (newBotPos.y < 0)
      newBotPos.y += map.y;
    else if (newBotPos.y >= map.y) newBotPos.y -= map.y;
    bots[i] = (newBotPos, bot.$2);
    // print(newBotPos);
  }
}

int getSecurityScore(List<(Point, Point)> bots, Point map) {
  var midHeight = map.y ~/ 2;
  var midWidth = map.x ~/ 2;
  List<List<int>> counts = [
    [0, 0],
    [0, 0]
  ];
  for (var bot in bots) {
    int height = -1;
    int width = -1;
    var pos = bot.$1;
    if (pos.x < midWidth)
      width = 0;
    else if (pos.x > midWidth) width = 1;
    if (pos.y > midHeight)
      height = 1;
    else if (pos.y < midHeight) height = 0;
    if (width == -1 || height == -1) continue;
    counts[height][width]++;
  }
  return counts[0][0] * counts[0][1] * counts[1][0] * counts[1][1];
}

String solvePart1(InputType input, [Point? map]) {
  map = map ?? defaultMap;
  var bots = List<(Point, Point)>.from(input);
  int iterations = 100;
  for (int i = 0; i < iterations; i++) runSecond(bots, map);
  return getSecurityScore(bots, map).toString();
}

String solvePart2(InputType input) {
  var bots = List<(Point, Point)>.from(input);
  int seconds = 0;
  while (true) {
    seconds++;
    runSecond(bots, defaultMap);
    Set<Point> s = {};
    bots.forEach((bot) => s.add(bot.$1));
    if (s.length == bots.length) break;
  }
  return seconds.toString();
}
