// ignore_for_file: dead_code

import '../../Utils/DartUtils.dart';

void main(){
  bool runP1 = true;
  bool runP2 = true;
  int solutionP1 = 0, solutionP2 = 0;

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

List<String> parseInput(String input){
  return input.splitNewLine();
}

int solvePart1(List<String> input){
  int total = 0;
  for(String s in input){
    var strnum = findLeftNumber(s, false) + findRightNumber(s, false);
    int num = int.parse(strnum);
    total += num;
  }
  return total;
}

int solvePart2(List<String> input) {
  int total = 0;
  for(String s in input){
    var strnum = findLeftNumber(s, true) + findRightNumber(s, true);
    int num = int.parse(strnum);
    total += num;
  }
  return total;
}

String findLeftNumber(String input, bool checkWords){
  for(int i = 0; i < input.length; i++){
    if(int.tryParse(input[i]) != null) return input[i];
    if(checkWords){
      var nameNum = checkNameNumber(input, i);
      if(nameNum != null) return nameNum;
    }
  }
  return "";
}

String findRightNumber(String input, bool checkWords){
  for(int i = input.length - 1; i >= 0; i--){
    if(int.tryParse(input[i]) != null) return input[i];
    if(checkWords){
      var nameNum = checkNameNumber(input, i);
      if(nameNum != null) return nameNum;
    }
  }
  return "";
}

String? checkNameNumber(String input, int start){
  for(var number in nameNumbers){
    if (start + number.length > input.length) continue;
    if(input.substring(start, start + number.length) == number) return numToDigit[number];
  }
  return null;
}

List<String> nameNumbers = ["one", "two","three","four","five","six","seven","eight","nine"];
Map<String,String> numToDigit = {"one" : "1", "two" : "2","three" : "3","four" : "4","five" : "5","six" : "6","seven" : "7","eight" : "8","nine" : "9"};