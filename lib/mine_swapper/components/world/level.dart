import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:game_making/mine_swapper/components/world/block.dart';
import '../../mine_swapper.dart';

class Level extends World with HasGameReference<MineSwapperGame>, TapCallbacks {
  @override
  void onTapDown(TapDownEvent event) {}
}
