import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:game_making/flame_get_started/core/startup.dart';

class ScreenBottomComponent extends PositionComponent
    with HasGameRef<StartUpGame> {
  @override
  void onLoad() {
    super.onLoad();

    position = Vector2(0, gameRef.size.y);
    size = Vector2(gameRef.size.x, 1);

    add(RectangleHitbox(
      size: Vector2(gameRef.size.x, 1),
      collisionType: CollisionType.passive,
    ));
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    position =
        Vector2(0, gameRef.camera.viewfinder.position.y + gameRef.size.y);
    final paint = Paint()
      ..color =
          const Color.fromARGB(197, 111, 52, 52) // Change color as desired
      ..style = PaintingStyle.fill;
    canvas.drawLine(
        Offset(-gameRef.size.x, 0), Offset(gameRef.size.x, 0), paint);
  }
}
