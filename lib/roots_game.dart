import 'dart:ui';
import 'package:roots_2023/components/monster.dart';
import 'package:flame/components.dart';

import 'components/player.dart';
import 'components/world.dart';
import 'components/enemy_manager.dart';
import 'package:flame/game.dart';
import '../helpers/direction.dart';

class RootsGame extends FlameGame {
  final World _world = World();
  final Player player = Player();

  @override
  Future<void> onLoad() async {
    await add(_world);
    player.anchor = Anchor.center;
    add(player);
    EnemyManager enemyManager = EnemyManager(player);
    add(enemyManager);
    camera.followComponent(player,
        worldBounds: Rect.fromLTRB(0, 0, _world.size.x, _world.size.y));
  }

  void onJoypadDirectionChanged(Direction direction) {
    player.direction = direction;
  }
}
