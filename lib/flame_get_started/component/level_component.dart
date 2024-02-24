import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

import '../core/startup.dart';

// when player hit it set camera to it's position
class LevelComponent extends PositionComponent with HasGameRef<StartUpGame> {
  final String currentLevel;
  final Vector2 currentPosition;
  LevelComponent({required this.currentLevel, required this.currentPosition})
      : super(
            key: ComponentKey.named(currentLevel),
            anchor: Anchor.center,
            position: currentPosition);
  late double screenWidth;
  //final Vector2 currentPosition = Vector2(0, 0);
  @override
  void onLoad() {
    super.onLoad();
    screenWidth = gameRef.size.x;
    size = Vector2(screenWidth, 5);
    add(CircleHitbox(
      radius: 10,
      position: Vector2(520, 0),
    ));
    add(TextComponent(
      text: currentLevel,
      position: Vector2(0, -15),
    ));
  }

  @override
  void render(Canvas canvas) {
    // anchor = Anchor.topLeft;
    super.render(canvas);
    final paint = Paint()
      ..color =
          const Color.fromARGB(16, 222, 222, 222) // Change color as desired
      ..style = PaintingStyle.fill;
    canvas.drawLine(Offset(-screenWidth, 0), Offset(screenWidth, 0), paint);
  }
}
