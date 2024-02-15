import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/text.dart';
import 'package:game_making/mine_swapper/constants/helper_methods.dart';
import 'package:game_making/mine_swapper/mine_swapper.dart';

class BlockComponent extends PositionComponent with TapCallbacks {
  bool isBomb = false;
  bool isRevealed = false;
  bool isFlagged = false;
  String text = '';
  int row = 0;
  int column = 0;
  int index = 0;
  int bombsAround = 0;

  @override
  bool get debugMode => false;
  @override
  void onTapUp(TapUpEvent event) {
    openBlock(index);

    super.onTapUp(event);
  }

  @override
  void render(Canvas canvas) {
    //random background color
    Color color = isRevealed
        ? const Color.fromARGB(255, 26, 238, 69)
        : const Color(0xFFAAAAAA);
    if (isBomb) {
      color = const Color.fromARGB(255, 255, 0, 0);
    }
    canvas.drawRect(size.toRect(), Paint()..color = color);
    //border with radius

    final border = RRect.fromRectAndRadius(
      size.toRect(),
      const Radius.circular(15),
    );
    canvas.drawRRect(
      border,
      Paint()
        ..color = const Color.fromARGB(255, 94, 94, 94)
        ..style = PaintingStyle.stroke,
    );
    //if text is not empty then show text
    if (text.isNotEmpty && isRevealed && text != '0') {
      add(TextComponent(
          text: text,
          position: size / 2,
          scale: Vector2.all(5),
          anchor: Anchor.center));
      //TextRendererFactory.createDefault().render(canvas, text, position);
    }
    super.render(canvas);
  }
}
