import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:game_making/mine_swapper/components/world/level.dart';
import '../../../mine_swapper.dart';
import '../block.dart';

class LevelOne extends Level with Game {
  int bombs = 10;
  int grid = 20;
  @override
  FutureOr<void> onLoad() {
    int index = 0;
    for (var i = 0; i < grid; i++) {
      for (var j = 0; j < grid; j++) {
        //  MineSwapperGame.blockGap

        final block = BlockComponent()
          ..position = Vector2(
            (i * MineSwapperGame.blockSize.x) +
                (MineSwapperGame.blockGap * (i + 1)),
            (j * MineSwapperGame.blockSize.y) +
                (MineSwapperGame.blockGap * (j + 1)),
          )
          ..row = i
          ..column = j
          ..index = index++
          ..size = MineSwapperGame.blockSize
          ..anchor = Anchor.topLeft
          ..isBomb = Random().nextDouble() < 0.2;
        MineSwapperGame.blocks.add(block);
        add(block);
      }
    }
    var gridCamera = grid / 2;
    // change camera position

    game.camera.viewfinder.anchor = Anchor.center;
    game.camera.viewfinder.visibleGameSize = Vector2(
      (grid) * MineSwapperGame.blockSize.x +
          (grid + 2) * MineSwapperGame.blockGap,
      (grid) * MineSwapperGame.blockSize.y +
          (grid + 2) * MineSwapperGame.blockGap,
    );
    game.camera.viewfinder.position = Vector2(
        (gridCamera * MineSwapperGame.blockSize.x) +
            ((gridCamera) * MineSwapperGame.blockGap),
        (gridCamera * MineSwapperGame.blockSize.y) +
            ((gridCamera) * MineSwapperGame.blockGap));
    return super.onLoad();
  }
}
