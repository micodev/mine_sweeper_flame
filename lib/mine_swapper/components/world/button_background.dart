import 'dart:ui';

import 'package:flame/components.dart';

import '../level_button.dart';

class ButtonBackground extends PositionComponent with HasAncestor<LevelButton> {
  ButtonBackground(Color color) {
    _paint.color = color;
  }

  @override
  void onMount() {
    super.onMount();
    size = ancestor.size;
  }

  late final _background = RRect.fromRectAndRadius(
    size.toRect(),
    const Radius.circular(5),
  );
  final _paint = Paint()..style = PaintingStyle.stroke;

  @override
  void render(Canvas canvas) {
    canvas.drawRRect(_background, _paint);
  }
}
