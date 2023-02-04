import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:roots_2023/roots_game.dart';

class Attack extends SpriteAnimationComponent with HasGameRef<RootsGame> {
  double attackCD = 0;
  double attackFrequency = 3;
  bool shown = false;


    Attack(attack_size, this.attackFrequency) : super(
    position: Vector2(0.0, 0.0),
    size: Vector2.all(attack_size)
    );

}
