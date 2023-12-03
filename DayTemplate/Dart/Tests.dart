import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

import '../../Utils/DartUtils.dart';
import 'Solution.dart';

void main(){
  late List<String> input;

  setUp(() {
    input = parseInput(Utils.readToString('../testinput.txt'));
  });

  // test("Check parse input works correclty", () {
  //   expect(input, "Solution1");
  // });

  group("Check sample input passes for part", () {
    test("1", () {
      expect(solvePart1(input), "Solution1");
    });
    test("2", () {
      expect(solvePart2(input), "Fail");
    });
  });
}