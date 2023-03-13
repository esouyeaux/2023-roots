import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:roots_2023/roots_game.dart';

class Attack extends SpriteAnimationComponent with HasGameRef<RootsGame>, CollisionCallbacks {
  double attackCD = 0;
  double attackFrequency = 3;
  double attackDuration = 3;
  bool shown = false;
  Vector2 direction = Vector2(0, 0);
  Vector2 attack_spawn = Vector2(0, 0);
  double damage_multiplier = 0;


    Attack(attack_size, this.attackFrequency, this.attackDuration, this.attack_spawn, this.damage_multiplier) : super(
    position: Vector2(0.0, 0.0),
    size: attack_size
    );

  @override
  void onMount() {
    super.onMount();
    final shape = CircleHitbox.relative(
      1,
      parentSize: size,
      position: size / 2,
      anchor: Anchor.center,
    );
    add(shape);
  }
}
