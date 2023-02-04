import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:roots_2023/roots_game.dart';

class Attack extends SpriteAnimationComponent with HasGameRef<RootsGame> {
  String imagePath;
    final double _animationSpeed = 0.3;
    late final SpriteAnimation _standingAnimation;
  double attackCD = 0;
  double attackFrequency = 3;
  bool shown = false;


    Attack(this.imagePath, attack_size, newPos) : super(
    position: newPos + Vector2(-20.0, 30.0),
    size: Vector2.all(attack_size)
    );

  @override
  Future<void> onLoad() async {
    _loadAnimations().then((_) => {animation = _standingAnimation});
  }

    Future<void> _loadAnimations() async {
    final spriteSheet = SpriteSheet(
      image: await gameRef.images.load(imagePath),
      srcSize: Vector2(64.0, 32.0),
    );
    _standingAnimation
    = spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, to: 2);
  }

}
