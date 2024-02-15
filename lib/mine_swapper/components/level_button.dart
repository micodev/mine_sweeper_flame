import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'world/button_background.dart';

class LevelButton extends ButtonComponent {
  LevelButton(String text, {super.onPressed, super.position})
      : super(
          button: ButtonBackground(Colors.white),
          buttonDown: ButtonBackground(Colors.orangeAccent),
          children: [
            TextComponent(
              text: text,
              position: Vector2(60, 20),
              anchor: Anchor.center,
            ),
          ],
          size: Vector2(120, 40),
          anchor: Anchor.center,
        );
}
