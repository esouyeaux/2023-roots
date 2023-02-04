import 'dart:math';

import 'package:flame/components.dart';

import 'monster.dart';
import 'player.dart';

class EnemyManager extends Component with HasGameRef {
  late Timer timer;
  late Player player;
  Random random = Random();

  EnemyManager(this.player) : super () {
    timer = Timer(2, onTick: _spawnEnemy, repeat: true);
  }

  void _spawnEnemy() {
    double spawnAngle = random.nextDouble() * 2 * pi;
    Vector2 spawnPosition = player.position + Vector2(cos(spawnAngle) * 400, sin(spawnAngle) * 400);
    Monster monster = Monster(spawnPosition);
    monster.anchor = Anchor.center;
    gameRef.add(monster);
  }

  @override
  void onMount() {
    super.onMount();
    timer.start();
  }

  @override
  void update(double delta) {
    super.update(delta);
    // Update timers with delta time to make them tick.
    timer.update(delta);
  }
}