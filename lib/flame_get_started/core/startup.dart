import 'dart:ui';

import 'package:flame/camera.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:game_making/flame_get_started/component/level_component.dart';
import 'package:game_making/flame_get_started/component/screen_bottom_component.dart';

import '../component/color_switcher.dart';
import '../component/player_component.dart';

class StartUpGame extends FlameGame with TapCallbacks, HasCollisionDetection {
  static double height = 1920;
  static double width = 1080;
  StartUpGame() : super();
  final player = PlayerComponent();
  final screenBottom = ScreenBottomComponent();

  // @override
  // bool get debugMode => true;
  @override
  Color backgroundColor() {
    return const Color(0xFF1A1A1A); // Replace with your preferred color
  }

  @override
  void onLoad() async {
    super.onLoad();
    world = World();
    size.setValues(width, height);
    camera = CameraComponent.withFixedResolution(
        world: world, width: width, height: height);
    camera.viewfinder.anchor = Anchor.topLeft;
    addAll([world, camera]);

    //fixed resolution game Ratio 16/9
    //size.setFrom(resolution);
    //camera.viewport = FixedResolutionViewport(resolution: resolution);
    // world.add(RectangleComponent(
    //   size: Vector2(-9999999, 9999999),
    //   position: Vector2(-50000, -9999),
    //   paint: Paint()..color = const Color.fromARGB(255, 168, 164, 164),
    // ));
    add(RectangleComponent(
      size: Vector2(width, height),
      position: Vector2(0, 0),
    )
      ..setColor(const Color.fromARGB(255, 36, 36, 36))
      ..add(RectangleHitbox(
        position: Vector2(0, height),
      )));
    world.add(player);

    for (int i = 0; i < 10; i++) {
      world.add(ColorSwitcherComponent(
        position: Vector2(width / 2, -i * 1200),
      ));
    }
    for (int i = 0; i < 10; i++) {
      world.add(LevelComponent(
          currentLevel: "level${i + 1}",
          currentPosition: Vector2(width / 2, -i * 750)));
    }
    world.add(screenBottom);

    // add(PositionComponent()
    //   ..position = Vector2(0, 800)
    //   ..add(RectangleHitbox())
    //   ..size = Vector2(size.x, 1));
  }

  @override
  void onTapDown(TapDownEvent event) {
    //TODO: implement onTapDown
    super.onTapDown(event);
    player.jump();
  }
}
