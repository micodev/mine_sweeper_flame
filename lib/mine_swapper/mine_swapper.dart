import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:game_making/mine_swapper/components/world/block.dart';
import 'package:game_making/mine_swapper/components/world/levels/level_1.dart';
import 'components/level_button.dart';
import 'components/world/level.dart';

class MineSwapperGame extends FlameGame {
  static const double blockWidth = 500.0;
  static const double blockHeight = 500.0;
  static const double blockGap = 15.0;
  static const double blockRadius = 250.0;
  static final Vector2 blockSize = Vector2(blockWidth / 3, blockHeight / 3);
  static final List<BlockComponent> blocks = [];
  late final TextComponent header;

  @override
  Future<void> onLoad() async {
    header = TextComponent(
      text: 'test',
      position: Vector2(size.x / 2, 50),
      anchor: Anchor.center,
    );

    final viewport = camera.viewport;
    viewport.add(header);
    final levels = [
      LevelOne(),
      Level(),
      Level(),
    ];
    viewport.addAll(
      [
        LevelButton(
          'Level 1',
          onPressed: () => world = levels[0],
          position: Vector2(size.x / 2 - 210, size.y - 50),
        ),
        LevelButton(
          'Level 2',
          onPressed: () => world = levels[1],
          position: Vector2(size.x / 2 - 70, size.y - 50),
        ),
        LevelButton(
          'Level 3',
          onPressed: () => world = levels[2],
          position: Vector2(size.x / 2 + 70, size.y - 50),
        ),
        LevelButton(
          'Resettable',
          onPressed: () => world = Level(),
          position: Vector2(size.x / 2 + 210, size.y - 50),
        ),
      ],
    );
  }
}
