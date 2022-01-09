import 'package:flutter/material.dart';
import 'package:flutter_puzzle_challenge/domain/puzzle_box.dart';

class PuzzlePage extends StatelessWidget {
  const PuzzlePage({Key? key, required this.puzzleBoxes}) : super(key: key);

  final List<PuzzleBox> puzzleBoxes;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter puzzle challenge'),
      ),
      body: Stack(
        children: [
          const Placeholder(),
          ...puzzleBoxes.map(
            (box) {
              return Positioned(
                left: box.posCurrent.dx,
                top: box.posCurrent.dy,
                child: SizedBox(
                  width: box.size.width,
                  height: box.size.height,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(2),
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
              );
            },
          ).toList()
        ],
      ),
    );
  }
}
