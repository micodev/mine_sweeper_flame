import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:game_making/flame_get_started/core/startup.dart';
import 'package:game_making/flame_get_started/helper/game_state.dart';

import 'color_switcher.dart';
import 'level_component.dart';
import 'screen_bottom_component.dart';

class PlayerComponent extends PositionComponent
    with HasGameRef<StartUpGame>, CollisionCallbacks {
  PlayerComponent()
      : super(
          anchor: Anchor.center,
        );
  GameState gameState = GameState.idle;
  final _velocity = Vector2.zero();
  final _gravity = 980.0;
  final _jumpSpeed = 350.0;
  final double radius = 25;
  final Vector2 currentPosition = Vector2(0, 0);
  String currentLevel = 'level0';
  final checkPointPosition = Vector2.zero();
  //bool isFailed = true;
  bool isLevelHit = false;
  Paint paint = Paint()
    ..color = Colors.red // Change color as desired
    ..style = PaintingStyle.fill;
  @override
  void onLoad() async {
    super.onLoad();
    currentPosition.setFrom(
        Vector2(gameRef.size.x / 2, gameRef.size.y * 0.9 - (radius * 4)));
    position = currentPosition;
    size = Vector2.all(radius * 2);
    add(CircleHitbox(
      radius: radius,
    ));
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    final circleCenter = (size / 2);
    canvas.drawCircle(circleCenter.toOffset(), radius, paint);
  }

  @override
  void update(double dt) {
    if (gameState == GameState.playing) {
      currentPosition.y += _velocity.y * dt;
      _velocity.y += _gravity * dt;
      position.setFrom(currentPosition);
      print(
          '${currentPosition.y} , ${gameRef.camera.viewfinder.position.y} , ${gameRef.size.y / 2}');
      if (currentPosition.y <
          gameRef.camera.viewfinder.position.y + gameRef.size.y / 2) {
        gameRef.camera.viewfinder.position =
            Vector2(0, currentPosition.y - gameRef.size.y / 2);
      }
    } else if (gameState == GameState.idle) {
      position.setFrom(currentPosition);
    } else if (gameState == GameState.rest) {
      position.setFrom(currentPosition);
      if (checkPointPosition != Vector2.zero()) {
        gameRef.camera.moveTo(
            -checkPointPosition
              ..y = -(gameRef.size.y / 2),
            speed: 3500);
      }
      gameState = GameState.idle;
    }
    print(gameState);
    super.update(dt);
  }

  void jump() {
    gameState = GameState.playing;
    _velocity.y = -_jumpSpeed;
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    print("onCollision ${other.runtimeType}");
    if (other is ColorSwitcherComponent) {
      print('hit ColorSwitcherComponent');
      other.circleHitbox!.collisionType = CollisionType.inactive;
      other.add(ScaleEffect.to(
          Vector2(0.01, 0.01),
          EffectController(
            duration: 0.2,
            infinite: false,
            onMax: () {
              other.removeFromParent();
            },
          )));

      //change player color
      other.colors.shuffle();
      paint = Paint()
        ..color = other.colors[0]
        ..style = PaintingStyle.fill;
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);

    if (other is LevelComponent) {
      debugPrint('end hit LevelComponent');
      if (checkPointPosition.y >= other.position.y) {
        checkPointPosition.setFrom(currentPosition);
      } else {
        print('not a check point');
      }
    } else if (other is ScreenBottomComponent) {
      _velocity.y = 0;
      gameState = GameState.idle;
      if (checkPointPosition == Vector2.zero()) {
        currentPosition.y = gameRef.size.y * 0.9 - (radius * 4);
      } else {
        gameRef.camera.moveTo(
          Vector2(0, checkPointPosition.y - gameRef.size.y),
          speed: 6500,
        );
        currentPosition.y = checkPointPosition.y - (radius * 4);
      }
    }
    print("onCollisionEnd ${other.runtimeType}");
  }
}
