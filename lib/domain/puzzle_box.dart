import 'package:flutter/cupertino.dart';

class PuzzleBox {
  Offset posDefault;
  Offset posCurrent;

  int indexDefault;
  int indexCurrent;

  bool empty;
  Size size;

  PuzzleBox({
    required this.posDefault,
    required this.posCurrent,
    required this.indexDefault,
    required this.indexCurrent,
    this.empty = false,
    required this.size,
  });
}
