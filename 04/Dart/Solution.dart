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

List<List<List<int>>> parseInput(String input){
  var cards = input.splitNewLine();
  List<List<List<int>>> parsedCards = [];
  for(var card in cards){
    var parts = card.split(": ")[1].split(" | ");
    var winners = parts[0].trim().splitWhitespace().listMap<String, int>((element) => int.parse(element));
    var numbers = parts[1].trim().splitWhitespace().listMap<String, int>((element) => int.parse(element));
    parsedCards.add([winners, numbers]);
  }
  return parsedCards;
}

String solvePart1(List<List<List<int>>> input){
  int total = 0;
  for(var card in input){
    int score = 0;
    for(var win in card[0]){
      if(card[1].contains(win)) score = score == 0 ? 1 : score * 2;
    }
    total += score;
  }
  return total.toString();
}

String solvePart2(List<List<List<int>>> input) {
  int totalCards = 0;
  List<int> multipliers = List.filled(input.length, 1, growable: true);
  for(var card in input){
    int score = 0;
    int multiplier = multipliers.removeAt(0);
    for(var win in card[0]){
      if(card[1].contains(win)) score += 1;
    }
    addOrCreate(multipliers, multiplier, score);
    totalCards += multiplier;
  }
  return totalCards.toString();
}

void addOrCreate(List<int> list, int amount, int length){
  for(int i = 0; i < length; i++){
    if(i >= list.length) list.add(amount);
    else list[i] += amount;
  }
}