import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_puzzle_challenge/domain/puzzle_box.dart';

class PuzzlePage extends StatefulWidget {
  const PuzzlePage({Key? key}) : super(key: key);

  @override
  State<PuzzlePage> createState() => _PuzzlePageState();
}

class _PuzzlePageState extends State<PuzzlePage> {
  static const int puzzleCount = 3;
  static const Size size = Size(900, 900);
  // List of slide objects
  late final List<PuzzleBox> puzzleBoxes;

  @override
  void initState() {
    generatePuzzle();
    super.initState();
  }

  void generatePuzzle() {
    // Calculate box size for each puzzle box
    Size sizeBox = Size(size.width / puzzleCount, size.height / puzzleCount);

    puzzleBoxes = List.generate(
      puzzleCount * puzzleCount,
      (index) {
        Offset offsetTemp = Offset(
          index % puzzleCount * sizeBox.width,
          index ~/ puzzleCount * sizeBox.height,
        );
        debugPrint(
            "Element: $index. Position - ${offsetTemp.dx} - ${offsetTemp.dy}");

        return PuzzleBox(
          posDefault: offsetTemp,
          posCurrent: offsetTemp,
          indexDefault: index + 1,
          indexCurrent: index,
          size: sizeBox,
        );
      },
    );

    puzzleBoxes.last.empty = true;
    setState(() {});
  }

  PuzzleBox getEmptyObject() {
    return puzzleBoxes.firstWhere((box) => box.empty);
  }

  void changePos(int indexCurrent) {
    PuzzleBox emptyBox = getEmptyObject();

    // Find empty index box
    final int emptyIndex = emptyBox.indexCurrent;

    // Find max and min index
    int minIndex = min(indexCurrent, emptyIndex);
    int maxIndex = max(indexCurrent, emptyIndex);

    // Temp moves list
    List<PuzzleBox> tempPuzzleBoxes = [];

    // Check if index current from vertical / horizontal line
    if (indexCurrent % puzzleCount == emptyIndex % puzzleCount) {
      // On vertical line
      tempPuzzleBoxes = puzzleBoxes
          .where((box) =>
              box.indexCurrent % puzzleCount == indexCurrent % puzzleCount)
          .toList();
    } else if (indexCurrent ~/ puzzleCount == emptyIndex ~/ puzzleCount) {
      tempPuzzleBoxes = puzzleBoxes;
    } else {
      tempPuzzleBoxes = [];
    }

    tempPuzzleBoxes = tempPuzzleBoxes
        .where((box) =>
            box.indexCurrent >= minIndex &&
            box.indexCurrent <= maxIndex &&
            box.indexCurrent != emptyIndex)
        .toList();

    // Check empty index under or above current touch
    if (emptyIndex < indexCurrent) {
      tempPuzzleBoxes.sort((a, b) => a.indexCurrent < b.indexCurrent ? 1 : 0);
    } else {
      tempPuzzleBoxes.sort((a, b) => a.indexCurrent < b.indexCurrent ? 0 : 1);
    }

    // check if tempPuzzleBoxes is exist, then switch position
    if (tempPuzzleBoxes.isNotEmpty) {
      int tempIndex = tempPuzzleBoxes[0].indexCurrent;
      Offset tempPos = tempPuzzleBoxes[0].posCurrent;

      for (var i = 0; i < tempPuzzleBoxes.length - 1; i++) {
        tempPuzzleBoxes[i].indexCurrent = tempPuzzleBoxes[i + 1].indexCurrent;
        tempPuzzleBoxes[i].posCurrent = tempPuzzleBoxes[i + 1].posCurrent;
      }

      tempPuzzleBoxes.last.indexCurrent = emptyBox.indexCurrent;
      tempPuzzleBoxes.last.posCurrent = emptyBox.posCurrent;

      emptyBox.indexCurrent = tempIndex;
      emptyBox.posCurrent = tempPos;
    }

    // Rebuild
    setState(() {});

    // Check is user win or not
    checkWinningPosition();
  }

  void checkWinningPosition() {
    final List<PuzzleBox> resultList =
        puzzleBoxes.where((box) => box.posCurrent == box.posDefault).toList();
    if (resultList.length == puzzleCount * puzzleCount) {
      debugPrint("SOLVED!");
    } else {
      debugPrint('Keep thinking');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter puzzle challenge'),
      ),
      body: Stack(
        children: [
          const Placeholder(),
          ...puzzleBoxes.where((box) => !box.empty).map(
            (box) {
              return AnimatedPositioned(
                duration: const Duration(milliseconds: 250),
                curve: Curves.ease,
                left: box.posCurrent.dx,
                top: box.posCurrent.dy,
                child: GestureDetector(
                  onTap: () => changePos(box.indexCurrent),
                  child: SizedBox(
                    width: box.size.width,
                    height: box.size.height,
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(10),
                      color: Colors.blue,
                      child: Stack(
                        children: [
                          Center(
                            child: Text(
                              "${box.indexDefault}",
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ).toList()
        ],
      ),
    );
  }
}
