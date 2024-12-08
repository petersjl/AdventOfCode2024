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

typedef InputType = (Point, Map<String, List<Point>>);

InputType parseInput(String input) {
  var mapStrs = input.splitNewLine();
  Map<String, List<Point>> towers = {};
  for (int row = 0; row < mapStrs.length; row++) {
    for (int col = 0; col < mapStrs[0].length; col++) {
      if (mapStrs[row][col] == ".") continue;
      towers.appendToKey(mapStrs[row][col], Point(col, row));
    }
  }
  return (Point(mapStrs[0].length, mapStrs.length), towers);
}

void getNodesForTowerGroup(List<Point> towers, Set<Point> nodes) {
  for (int i = 0; i < towers.length - 1; i++) {
    for (int j = i + 1; j < towers.length; j++) {
      getNodesForPair(towers[i], towers[j], nodes);
    }
  }
}

void getNodesForPair(Point a, Point b, Set<Point> nodes) {
  var bigger = a < b ? b : a;
  var smaller = bigger == a ? b : a;
  var dist = bigger - smaller;
  nodes.add(bigger + dist);
  nodes.add(smaller - dist);
}

String solvePart1(InputType input) {
  var (mapSize, towersMap) = input;

  Set<Point> allNodes = {};
  for (var list in towersMap.values) {
    getNodesForTowerGroup(list, allNodes);
  }
  int count = allNodes.count((node) =>
      0 <= node.x && node.x < mapSize.x && 0 <= node.y && node.y < mapSize.y);
  return count.toString();
}

void getLineNodesForTowerGroup(
    Point mapSize, List<Point> towers, Set<Point> nodes) {
  nodes.addAll(towers);
  for (int i = 0; i < towers.length - 1; i++) {
    for (int j = i + 1; j < towers.length; j++) {
      getLineNodesForPair(towers[i], towers[j], mapSize, nodes);
    }
  }
}

void getLineNodesForPair(Point a, Point b, Point mapSize, Set<Point> nodes) {
  var bigger = a < b ? b : a;
  var smaller = bigger == a ? b : a;
  var dist = bigger - smaller;

  var current = bigger + dist;
  while (0 <= current.x &&
      current.x < mapSize.x &&
      0 <= current.y &&
      current.y < mapSize.y) {
    nodes.add(current);
    current += dist;
  }
  current = smaller - dist;
  while (0 <= current.x &&
      current.x < mapSize.x &&
      0 <= current.y &&
      current.y < mapSize.y) {
    nodes.add(current);
    current -= dist;
  }
}

String solvePart2(InputType input) {
  var (mapSize, towersMap) = input;

  Set<Point> allNodes = {};
  for (var list in towersMap.values) {
    getLineNodesForTowerGroup(mapSize, list, allNodes);
  }
  return allNodes.length.toString();
}
