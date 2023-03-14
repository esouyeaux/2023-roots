import 'dart:math';

import 'package:flame/components.dart';

import 'monster.dart';
import 'player.dart';

class EnemyManager extends Component with HasGameRef {
  late Timer timer;
  late Player player;
  Random random = Random();
  bool active = false;
  List<Monster> monsters = [];

  EnemyManager(this.player) : super () {
    timer = Timer(2, onTick: _spawnEnemy, repeat: true);
  }

  void _spawnEnemy() {
    if (active) {
      double spawnAngle = random.nextDouble() * 2 * pi;
      Vector2 spawnPosition = player.position + Vector2(cos(spawnAngle) * 400, sin(spawnAngle) * 400);
      int monsterType = random.nextInt(2) + 1;
      Monster monster = Monster(monsterType, spawnPosition);
      monster.anchor = Anchor.center;
      gameRef.add(monster);
      monsters.add(monster);
    }
  }

  @override
  void onMount() {
    super.onMount();
    timer.start();
  }

  @override
  void update(double dt) {
    super.update(dt);
    for (var mon in monsters) {
      mon.active = active;
    }
    // Update timers with delta time to make them tick.
    timer.update(dt);
  }
}
