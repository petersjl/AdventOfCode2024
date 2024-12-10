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

typedef InputType = List<int?>;

InputType parseInput(String input) {
  List<int?> blocks = [];
  for (int i = 0; i < input.length; i++) {
    int count = int.parse(input[i]);
    bool isBlock = i & 1 == 0;
    var id = i ~/ 2;
    for (var j = 0; j < count; j++) {
      blocks.add(isBlock ? id : null);
    }
  }
  return blocks;
}

String solvePart1(InputType input) {
  var blocks = List<int?>.from(input);
  for (int i = 0; i < blocks.length; i++) {
    var block = blocks[i];
    if (block == null) {
      int? endBlock = null;
      while (endBlock == null) {
        endBlock = blocks.removeLast();
      }
      blocks[i] = endBlock;
    }
  }
  int count = 0;
  for (int i = 0; i < blocks.length; i++) {
    count += i * (blocks[i] ?? 0);
  }
  return count.toString();
}

int getHoleSize(List<int?> blocks, int index) {
  int count = 0;
  while (blocks[index] == null) {
    count++;
    index++;
  }
  return count;
}

int getBlockSize(List<int?> blocks, int index) {
  int count = 0;
  int id = blocks[index]!;
  while (index >= 0 && blocks[index] != null && blocks[index] == id) {
    count++;
    index--;
  }
  return count;
}

int findABigHole(List<int?> blocks, int end, int blockSize) {
  int leftIndex = 0;
  int holeSize = 0;
  while (leftIndex < end && holeSize < blockSize) {
    // Move right the size of the last hole we found
    leftIndex += holeSize;
    // Move right to the first null space
    while (leftIndex < end && blocks[leftIndex] != null) leftIndex++;
    holeSize = getHoleSize(blocks, leftIndex);
  }
  return leftIndex;
}

void swapNullAndId(List<int?> blocks, int left, int right, int blockSize) {
  int id = blocks[right]!;
  for (int offset = 0; offset < blockSize; offset++) {
    blocks[left + offset] = id;
    blocks[right - offset] = null;
  }
}

String solvePart2(InputType input) {
  var blocks = List<int?>.from(input);
  int rightIndex = blocks.length - 1;
  while (rightIndex >= 0) {
    // Move left to first non-empty space
    while (rightIndex >= 0 && blocks[rightIndex] == null) rightIndex--;
    // Find the size of the given block
    var blockSize = getBlockSize(blocks, rightIndex);
    int leftIndex = findABigHole(blocks, rightIndex, blockSize);
    // If the first big enough hole is after the block
    // Move to the left of the block
    if (leftIndex >= rightIndex) {
      rightIndex -= blockSize;
      continue;
    }
    swapNullAndId(blocks, leftIndex, rightIndex, blockSize);
    rightIndex -= blockSize;
  }
  int count = 0;
  for (int i = 0; i < blocks.length; i++) {
    count += i * (blocks[i] ?? 0);
  }
  return count.toString();
}
