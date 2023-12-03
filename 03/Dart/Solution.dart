// ignore_for_file: dead_code

import '../../Utils/DartUtils.dart';

void main(){
  bool runP1 = true;
  bool runP2 = true;
  String solutionP1 = "", solutionP2 = "";

  Stopwatch stopwatch = new Stopwatch()..start();
  var input = parseInput(Utils.readToString("../input.txt"));
  var timeParse = stopwatch.elapsedMilliseconds;

  if(runP1) solutionP1 = solvePart1(input);
  var timeP1 = stopwatch.elapsedMilliseconds;
  if(runP2) solutionP2 = solvePart2(input);
  var timeP2 = stopwatch.elapsedMilliseconds;

  print('Parse time: ${timeParse * 1/1000}s');
  if(runP1) print('Part 1 (${(timeP1 - timeParse) * 1/1000}s): ${solutionP1}');
  if(runP2) print('Part 2 (${(timeP2 - timeP1) * 1/1000}s): ${solutionP2}');
  print('Ran in ${stopwatch.elapsedMilliseconds * 1/1000} seconds');
}

final String Symbols = "!@#\$%^&*+=-_/";

List<String> parseInput(String input){
  return input.splitNewLine();
}

String solvePart1(List<String> input){
  int total = 0;
  for(int i = 0; i < input.length; i++){
    var line = input[i];
    for(int j = 0; j < line.length; j++){
      if(int.tryParse(line[j]) == null) continue;
      if(checkAround(input, i, j, (s) => Symbols.contains(s)) > 0){
        var bounds = findNumberBounds(line, j);
        total += int.parse(line.substring(bounds[0], bounds[1]));
        j = bounds[1];
      }
    }
  }
  return total.toString();
}

String solvePart2(List<String> input) {
  int total = 0;
  for(int i = 0; i < input.length; i++){
    var line = input[i];
    for(int j = 0; j < line.length; j++){
      if(!Symbols.contains(line[j])) continue;
      if(checkAround(input, i, j, (s) => int.tryParse(s) != null) > 1){
        var ratio = tryFindRatio(input, i, j);
        total += ratio;
      }
    }
  }
  return total.toString();
}

int checkAround(List<String> grid, int row, int col, bool conditional(String s)){
  int count = 0;
  int starty = row > 0 ? row - 1 : row;
  int endy = row < grid.length - 1 ? row + 1 : row;
  int startx = col > 0 ? col - 1 : col;
  int endx = col < grid[0].length - 1 ? col + 1 : col;
  for(int i = starty; i <= endy; i++){
    for(int j = startx; j <= endx; j++){
      if(conditional(grid[i][j])) count++;
    }
  }
  return count;
}

List<int> findNumberBounds(String line, int col){
  int start = col - 1;
  while(start >= 0 && int.tryParse(line[start]) != null) start--;
  int end = col + 1;
  while(end < line.length && int.tryParse(line[end]) != null) end++;
  return[start + 1, end];
}

int tryFindRatio(List<String> grid, int row, int col){
  List<List<int>> numBounds = [];
  int starty = row > 0 ? row - 1 : row;
  int endy = row < grid.length - 1 ? row + 1 : row;
  int startx = col > 0 ? col - 1 : col;
  int endx = col < grid[0].length - 1 ? col + 1 : col;
  for(int i = starty; i <= endy; i++){
    for(int j = startx; j <= endx; j++){
      if(int.tryParse(grid[i][j]) != null){
        numBounds.add([i, ...findNumberBounds(grid[i], j)]);
      }
    }
  }
  numBounds = reduce(numBounds);
  if(numBounds.length == 2) {
    List<int> firstBounds = numBounds[0];
    int first = int.parse(grid[firstBounds[0]].substring(firstBounds[1],firstBounds[2]));
    List<int> secondBounds = numBounds[1];
    int second = int.parse(grid[secondBounds[0]].substring(secondBounds[1], secondBounds[2]));
    return first * second;
  }
  return 0;
}

List<List<int>> reduce(List<List<int>> bounds){
  for(int i = 0; i < bounds.length; i++){
    var check = bounds[i];
    for(int j = i + 1; j < bounds.length; j++){
      var other = bounds[j];
      var same = true;
      for(int k = 0; k < check.length; k++){
        if(check[k] != other[k]) same = false;
      }
      if(same){
        bounds.removeAt(j);
        j--;
      }
    }
  }
  return bounds;
}