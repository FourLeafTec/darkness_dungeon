import 'package:darkness_dungeon/core/decoration.dart';
import 'package:darkness_dungeon/core/enemy/enemy.dart';
import 'package:darkness_dungeon/core/map/map_game.dart';
import 'package:darkness_dungeon/core/player/player.dart';
import 'package:darkness_dungeon/core/util/joystick_controller.dart';
import 'package:flame/game.dart';
import 'package:flame/position.dart';
import 'package:flutter/cupertino.dart';

class RPGGame extends BaseGame {
  final BuildContext context;
  final Player player;
  final MapGame map;
  final List<Enemy> enemies;
  final List<GameDecoration> decorations;
  final JoystickController joystickController;
  Position mapCamera = Position.empty();
  Function(RPGGame) gameListener;

  RPGGame({
    @required this.context,
    @required this.player,
    @required this.map,
    @required this.joystickController,
    this.enemies,
    this.decorations,
  })  : assert(
          player != null,
        ),
        assert(
          map != null,
        ),
        assert(
          joystickController != null,
        ) {
    joystickController.joystickListener = player;

    add(map);
    decorations?.forEach((decoration) {
      add(decoration);
    });
    enemies?.forEach((enemy) {
      add(enemy);
    });
    add(player);

    add(joystickController);
  }

  @override
  void update(double t) {
    super.update(t);
    if (gameListener != null) gameListener(this);
  }

  void addListener(Function(RPGGame) gameListener) {
    this.gameListener = gameListener;
  }
}