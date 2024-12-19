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

typedef InputType = List<Point>;

InputType parseInput(String input) {
  return input.splitNewLine().listMap((line) {
    var parts = line.split(',');
    return Point(int.parse(parts[0]), int.parse(parts[1]));
  });
}

class PathNode {
  Point pos;
  late int score;
  int length;
  PathNode? prev;
  PathNode(this.pos, Point end, this.length, [this.prev = null]) {
    score = 5 * length + Utils.ManhattanDist(pos, end);
  }
}

Set<Point> aStar(List<List<bool>> grid, Point start, Point end) {
  PriorityQueue<PathNode> queue =
      PriorityQueue((item, toAdd) => item.score - toAdd.score);
  PathNode? finalPath = null;
  Point gridEnd = Point(grid[0].length, grid.length);
  Set<Point> seen = {start};
  queue.enqueue(PathNode(start, end, 1));
  queueLoop:
  while (!queue.isEmpty) {
    var current = queue.dequeue();
    for (var dir in Point.directions) {
      var check = current.pos + dir;
      if (check == end) {
        finalPath = PathNode(check, end, 1, current);
        break queueLoop;
      } else if (!check.isInBounds(gridEnd) ||
          !grid[check.y][check.x] ||
          seen.contains(check)) {
        continue;
      } else {
        seen.add(check);
        queue.enqueue(PathNode(check, end, current.length + 1, current));
      }
    }
  }
  Set<Point> path = {};
  while (finalPath != null) {
    path.add(finalPath.pos);
    finalPath = finalPath.prev;
  }
  path.remove(start);
  return path;
}

String solvePart1(InputType input, [int gridSize = 70, int simCount = 1024]) {
  var grid = Utils.getGrid(true, gridSize + 1);
  for (int i = 0; i < simCount; i++) {
    var point = input[i];
    grid[point.y][point.x] = false;
  }
  var path = aStar(grid, Point(0, 0), Point(gridSize, gridSize));
  return path.length.toString();
}

String solvePart2(InputType input, [int gridSize = 70, int startDrops = 1024]) {
  var grid = Utils.getGrid(true, gridSize + 1);
  int i = 0;
  for (; i < startDrops; i++) {
    var point = input[i];
    grid[point.y][point.x] = false;
  }
  Point start = Point(0, 0), end = Point(gridSize, gridSize);
  Set<Point> path = aStar(grid, start, end);
  for (; i < input.length; i++) {
    var point = input[i];
    grid[point.y][point.x] = false;
    if (path.contains(point)) path = aStar(grid, start, end);
    if (path.length == 0) break;
  }
  if (i == input.length) throw Exception("Path is never blocked");

  return "${input[i].x},${input[i].y}";
}
