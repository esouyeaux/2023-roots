import 'dart:ui';
import 'package:roots_2023/components/monster.dart';
import 'package:flame/components.dart';

import 'components/player.dart';
import 'components/world.dart';
import 'components/enemy_manager.dart';
import 'package:flame/game.dart';
import '../helpers/direction.dart';
import 'components/option.dart';
import 'components/options/options_manager.dart';
import 'components/attack.dart';
import 'components/attacks/default.dart';
import 'components/attacks/attack2.dart';
import 'components/attacks/pod_shot.dart';
import 'components/attacks/vine.dart';
import 'dart:math';

class RootsGame extends FlameGame with HasTappables {
  final World _world = World();
  final Player player = Player();
  final List<Attack> attack = [];
  final List<Option> option = [];
  final OptionManager options_manager = OptionManager();
  bool in_menu = true;
  late EnemyManager enemyManager;

  @override
  Future<void> onLoad() async {
    await add(_world);
    player.anchor = Anchor.center;
    add(player);
    enemyManager = EnemyManager(player);
    add(enemyManager);
    createMenu();
    player.position = _world.size / 2;
    camera.followComponent(player,
        worldBounds: Rect.fromLTRB(0, 0, _world.size.x, _world.size.y));
  }

  void onJoypadDirectionChanged(Direction direction) {
    if (!in_menu)
      player.direction = direction;
  }

  @override
  void update(double delta) {
    super.update(delta);

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

}
