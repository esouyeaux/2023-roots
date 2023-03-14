import 'package:flame/events.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'components/player.dart';
import 'components/world.dart';
import 'components/enemy_manager.dart';
import 'package:flame/game.dart';
import '../helpers/direction.dart';
import 'components/option.dart';
import 'components/options/options_manager.dart';
import 'components/attack.dart';
import 'components/attacks/default.dart';
import 'components/attacks/vine.dart';
import 'dart:math';
import 'components/world_collidable.dart';
import 'helpers/map_loader.dart';
import 'overlays/hud.dart';

class RootsGame extends FlameGame with HasDraggables, PanDetector, HasTappables, HasCollisionDetection {
  late Timer interval;
  final timerOverlay = 'timerOverlay';
  Duration countdown = const Duration(minutes: 5);
  final World _world = World();
  final List<Attack> attack = [];
  late Player player;
  final List<Option> option = [];
  final OptionManager options_manager = OptionManager();
  bool in_menu = true;
  late EnemyManager enemyManager;

  JoystickComponent joystick = JoystickComponent(
      anchor: Anchor.center,
      position: Vector2(-100, -100),
      size: 100,
      background: CircleComponent(
        radius: 60,
        paint: Paint()..color = Colors.white.withOpacity(0.5),
      ),
      knob: CircleComponent(radius: 30),
    );

  @override
  Future<void> onLoad() async {
    interval = getInterval();
    interval.start();

    await add(_world);
    add(joystick);
    player = Player(joystick: joystick);
    player.anchor = Anchor.center;
    add(player);
    enemyManager = EnemyManager(player);
    add(enemyManager);
    player.position = _world.size / 2;
    createMenu();
    // todo add player collision
    camera.followComponent(player);
    add(Hud());
    add(ScreenHitbox());
  }

  @override
  void onPanDown(DragDownInfo info) {
    if (!in_menu) {
      joystick.position = Vector2(info.eventPosition.widget.x, info.eventPosition.widget.y);
    }
  }

  @override
  void update(double delta) {
    super.update(delta);
    interval.update(delta);
  
    options_manager.update(option);
    if (options_manager.pick_ready) {
      remove(option[0]);
      remove(option[1]);
      options_manager.getOption(option, attack);
      option.clear();
      in_menu = false;
      enemyManager.active = true;
    }

    if (!in_menu) {
      for (var atk in attack) {
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
  }

  void createMenu() {
    in_menu = true;

    options_manager.createMenu(option, player.position);
    add(option[0]);
    add(option[1]);
  }

  String getFormattedRemainingTime() {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(countdown.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(countdown.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  Timer getInterval() {
    return Timer(
      1,
      repeat: true,
      onTick: () {
        if (countdown > const Duration(seconds: 1)) {
          countdown -= const Duration(seconds: 1);
        } else {
          theEnd();
        }
        overlays.remove(timerOverlay);
        overlays.add(timerOverlay);
      },
    );
  }

  void theEnd() {
    interval.stop();
  }
}
