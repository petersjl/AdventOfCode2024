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

typedef InputType = (Point, List<List<int>>);

class MapItem {
  static int NONE = 0, BARREL = 1, GUARD = 2, NEWOBS = 3;
  static int get(String item) {
    switch (item) {
      case ('#'):
        return BARREL;
      case ('^'):
        return GUARD;
      default:
        return NONE;
    }
  }
}

InputType parseInput(String input) {
  var strGrid = input.splitNewLine();
  Point? guard = null;
  var grid = List<List<int>>.generate(
      strGrid.length, (i) => List<int>.generate(strGrid[0].length, (j) => 0));
  for (int row = 0; row < strGrid.length; row++) {
    for (int col = 0; col < strGrid[0].length; col++) {
      if (strGrid[row][col] == '^') guard = new Point(col, row);
      grid[row][col] = MapItem.get(strGrid[row][col]);
    }
  }
  if (guard == null) throw Exception("No guard found while parsing");
  return (guard, grid); // should never get here
}

Point rotateClockwise(Point p) {
  return new Point(p.y * -1, p.x);
}

bool doesHeStay(Point guard, Point dir, List<List<int>> grid,
    {Set<Pair<Point, Point>>? path = null}) {
  path = path ?? {};
  while (true) {
    var newPos = guard + dir;
    if (newPos.y < 0 ||
        grid.length <= newPos.y ||
        newPos.x < 0 ||
        grid[0].length <= newPos.x) return false;
    if (grid[newPos.y][newPos.x] % 2 == 1) {
      dir = rotateClockwise(dir);
      continue;
    }
    if (!path.add(Pair(newPos, dir))) return true;
    guard = newPos;
  }
}

String solvePart1(InputType input) {
  var (guard, grid) = input;
  var dir = new Point(0, -1);
  Set<Pair<Point, Point>> path = {Pair(guard, dir)};
  doesHeStay(guard, dir, grid, path: path);
  int count = path
      .collect(Set<Point>(), (run, element) => run..add(element.first))
      .length;
  return count.toString();
}

String solvePart2(InputType input) {
  var (guard, grid) = input;
  var dir = new Point(0, -1);
  int count = 0;
  for (int row = 0; row < grid.length; row++) {
    for (int col = 0; col < grid[0].length; col++) {
      if (grid[row][col] != MapItem.NONE) continue;
      grid[row][col] = MapItem.NEWOBS;
      if (doesHeStay(guard, dir, grid)) count++;
      grid[row][col] = MapItem.NONE;
    }
  }
  return count.toString();
}
