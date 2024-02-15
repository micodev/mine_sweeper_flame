import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'mine_swapper/mine_swapper.dart';

void main() {
  final game = MineSwapperGame();
  runApp(GameWidget(game: game));
}
