import 'package:flame/events.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'components/player.dart';
import 'components/world.dart';
import 'components/enemy_manager.dart';
import 'package:flame/game.dart';

class RootsGame extends FlameGame with HasDraggables, PanDetector {
  final World _world = World();
  late Player player;
  JoystickComponent joystick = JoystickComponent(
      anchor: Anchor.center,
      position: Vector2(-100, -100),
      // size: 100,
      background: CircleComponent(
        radius: 60,
        paint: Paint()..color = Colors.white.withOpacity(0.5),
      ),
      knob: CircleComponent(radius: 30),
    );

  @override
  Future<void> onLoad() async {
    await add(_world);
    add(joystick);
    player = Player(joystick: joystick);
    player.anchor = Anchor.center;
    add(player);
    EnemyManager enemyManager = EnemyManager(player);
    add(enemyManager);
    camera.followComponent(player,
        worldBounds: Rect.fromLTRB(0, 0, _world.size.x, _world.size.y));
  }

  @override
  void onPanDown(DragDownInfo info) {
    joystick.position = Vector2(info.eventPosition.widget.x, info.eventPosition.widget.y);
  }
}
