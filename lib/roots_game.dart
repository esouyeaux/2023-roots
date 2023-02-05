import 'package:flame/events.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

import 'components/player.dart';
import 'components/world.dart';
import 'components/enemy_manager.dart';
import 'package:flame/game.dart';
import '../helpers/direction.dart';
import 'components/attack.dart';
import 'components/attacks/default.dart';
import 'components/attacks/vine.dart';
import 'dart:math';
import 'components/world_collidable.dart';
import 'helpers/map_loader.dart';

class RootsGame extends FlameGame with HasDraggables, PanDetector {
  final World _world = World();
  final List<Attack> _attack = [];
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
    _attack.add(DefaultAttack());
    _attack.add(Vine());
    player.position = _world.size / 2;
    // todo add player collision
    camera.followComponent(player);
    addWorldCollision();
  }

  @override
  void onPanDown(DragDownInfo info) {
    joystick.position = Vector2(info.eventPosition.widget.x, info.eventPosition.widget.y);
  }

  @override
  void update(double delta) {
    super.update(delta);

    for (var atk in _attack) {
      atk.attackCD += delta;
      if (!atk.shown && atk.attackCD > atk.attackFrequency) {
        atk.attackCD -= atk.attackFrequency;
          atk.position = player.position + atk.attack_spawn;
          atk.direction = Vector2(Random().nextInt(201) - 100.5, Random().nextInt(201) - 100.5);
          add(atk);
          atk.shown = true;
      } else if (atk.shown && atk.attackCD > atk.attackDuration) {
        atk.attackCD -= atk.attackDuration;
          remove(atk);
          atk.shown = false;
      }
    }
  }

  void addWorldCollision() async =>
    (await MapLoader.readWorldCollisionMap()).forEach((rect) {
      add(WorldCollidable()
        ..position = Vector2(rect.left, rect.top)
        ..width = rect.width
        ..height = rect.height);
    });
}
