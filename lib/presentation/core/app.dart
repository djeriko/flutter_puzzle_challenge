import 'package:flutter/material.dart';
import 'package:flutter_puzzle_challenge/domain/puzzle_box.dart';
import 'package:flutter_puzzle_challenge/presentation/puzzle/puzzle_page.dart';

class App extends StatelessWidget {
  App({Key? key}) : super(key: key);

  final int fieldSize = 1000;
  List<PuzzleBox> puzzleBoxes = [
    PuzzleBox(
      posDefault: Offset(0, 0),
      posCurrent: Offset(0, 0),
      indexDefault: 0,
      indexCurrent: 0,
      size: Size(300, 300),
    ),
    PuzzleBox(
      posDefault: Offset(300, 0),
      posCurrent: Offset(300, 0),
      indexDefault: 1,
      indexCurrent: 1,
      size: Size(300, 300),
    ),
    PuzzleBox(
      posDefault: Offset(0, 300),
      posCurrent: Offset(0, 300),
      indexDefault: 2,
      indexCurrent: 2,
      size: Size(300, 300),
    ),
    PuzzleBox(
      posDefault: Offset(300, 300),
      posCurrent: Offset(300, 300),
      indexDefault: 3,
      indexCurrent: 3,
      size: Size(300, 300),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PuzzlePage(
        puzzleBoxes: puzzleBoxes,
      ),
    );
  }
}
