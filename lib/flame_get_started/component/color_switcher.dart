import 'dart:math' as math;
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

import '../core/startup.dart';

class ColorSwitcherComponent extends PositionComponent
    with HasGameRef<StartUpGame> {
  List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
  ];
  int radius = 25;

  ColorSwitcherComponent({colors, radius, super.position})
      : super(anchor: Anchor.center);
  CircleHitbox? circleHitbox;
  @override
  void onLoad() {
    super.onLoad();
    size = Vector2.all(radius * 2);

    circleHitbox = CircleHitbox(
      radius: radius.toDouble(),
      collisionType: CollisionType.passive,
    );
    add(circleHitbox!);
    add(RotateEffect.by(
        2 * math.pi, EffectController(speed: 5, infinite: true)));
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final angleStep = 2 * math.pi / colors.length;
    for (var i = 0; i < colors.length; i++) {
      final startAngle = i * angleStep;
      final paint = Paint()
        ..color = colors[i]
        ..style = PaintingStyle.fill;
      final rectCenter = (size / 2);
      final rect = Rect.fromCircle(
        center: rectCenter.toOffset(),
        radius: radius.toDouble(),
      );
      canvas.drawArc(rect, startAngle, angleStep, true, paint);
    }
  }
}
