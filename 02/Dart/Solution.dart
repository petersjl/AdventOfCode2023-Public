// ignore_for_file: dead_code

import 'dart:math';

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

List<Game> parseInput(String input){
  List<Game> output = [];
  List<String> games = input.splitNewLine();
  for(String game in games){
    output.add(Game(game));
  }

  return output;
}

class Game{
  late int id;
  List<Hand> hands;
  Game(String gameString):hands = []{
    List<String> gameParts = gameString.split(": ");
    id = int.parse(gameParts[0].split(" ")[1]);
    List<String> handStrings = gameParts[1].split("; ");
    for(String hand in handStrings) hands.add(Hand(hand));
  }
}

class Hand{
  List<Attribute> attributes;
  Hand(String handString):attributes = []{
    List<String> attributeStrings = handString.split(", ");
    for(String attr in attributeStrings) attributes.add(Attribute(attr));
  }
}

class Attribute{
  late int count;
  late String color;
  Attribute(String attributeString){
    List<String> parts = attributeString.split(" ");
    count = int.parse(parts[0]);
    color = parts[1];
  }
}

String solvePart1(List<Game> input){
  int total = 0;
  for(Game game in input){
    total += checkGame(game, part1Max);
  }
  return total.toString();
}

String solvePart2(List<Game> input) {
  int power = 0;
  for(Game game in input){
    power += calculatePower(game);
  }
  return power.toString();
}

int checkGame(Game game, Map<String, int> maxes){
  for(Hand hand in game.hands){
    for(Attribute attr in hand.attributes){
      if(attr.count > maxes[attr.color]!) return 0;
    }
  }
  return game.id;
}

int calculatePower(Game game){
  List<int> maxes = [0,0,0];
  for(Hand hand in game.hands){
    for(Attribute attr in hand.attributes){
      switch(attr.color){
        case "red" : maxes[0] = max(maxes[0], attr.count);
        case "blue" : maxes[1] = max(maxes[1], attr.count);
        case "green" : maxes[2] = max(maxes[2], attr.count);
      }
    }
  }
  return maxes[0] * maxes[1] * maxes[2];
}

Map<String, int> part1Max = {"red" : 12, "green" : 13, "blue" : 14};