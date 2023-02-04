import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:roots_2023/roots_game.dart';

class Attack extends SpriteAnimationComponent with HasGameRef<RootsGame> {
  double attackCD = 0;
  double attackFrequency = 3;
  double attackDuration = 3;
  bool shown = false;
  Vector2 direction = Vector2(0, 0);
  Vector2 attack_spawn = Vector2(0, 0);


    Attack(attack_size, this.attackFrequency, this.attackDuration, this.attack_spawn) : super(
    position: Vector2(0.0, 0.0),
    size: attack_size
    );

}
