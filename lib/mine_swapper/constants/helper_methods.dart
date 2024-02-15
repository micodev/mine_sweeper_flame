// neighbour8 is a list of all the 8 neighbours of a cell

import 'dart:math';

import 'package:game_making/mine_swapper/components/world/block.dart';

import '../mine_swapper.dart';

List<BlockComponent> getNeighbors8(int index) {
  var blocks = MineSwapperGame.blocks;
  var maxLength = pow(blocks.length, 0.5).toInt();
  final neighbors = <BlockComponent>[];
  final row = blocks[index].row;
  final column = blocks[index].column;
  for (var i = -1; i < 2; i++) {
    for (var j = -1; j < 2; j++) {
      if (i == 0 && j == 0) {
        continue;
      }
      final r = row + i;
      final c = column + j;
      if (r >= 0 && r < maxLength && c >= 0 && c < maxLength) {
        neighbors.add(blocks[r * maxLength + c]);
      }
    }
  }
  //add the same index to the list
  //neighbors.add(blocks[index]);
  return neighbors;
}

// reveal block is recursive function to reveal the blocks
void openBlock(int index) {
  var blocks = MineSwapperGame.blocks;
  final block = blocks[index];

  if (block.isBomb) {
    //game over
    print('Game Over');
    //reveal all bombs
    for (final block in blocks) {
      if (block.isBomb) {
        block.isRevealed = true;
      }
    }
    return;
  }
  if (block.bombsAround > 0) {
    block.isRevealed = true;
    return;
  }
  final neighbors = getNeighbors8(index);
  var bombs = 0;
  for (final neighbor in neighbors) {
    if (neighbor.isBomb) {
      bombs++;
    }
  }
  if (!block.isBomb && !block.isRevealed) {
    block.bombsAround = bombs;
    block.isRevealed = true;
    block.text = bombs.toString();
    if (bombs == 0) {
      for (final neighbor in neighbors) {
        if (!neighbor.isRevealed) {
          openBlock(neighbor.index);
        }
      }
    }
  }
}
