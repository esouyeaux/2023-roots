import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import '../attack.dart';

class DefaultAttack extends Attack {
  late final SpriteAnimation _standingAnimation;

    DefaultAttack () : super (Vector2(100.0, 50.0), 3, 2, Vector2(-50, 20));

  @override
  Future<void> onLoad() async {
    _loadAnimations().then((_) => {animation = _standingAnimation});
  }

    Future<void> _loadAnimations() async {
    final spriteSheet = SpriteSheet(
      image: await gameRef.images.load("attack01_spritesheet.png"),
      srcSize: Vector2(64.0, 32.0),
    );
    _standingAnimation
    = spriteSheet.createAnimation(row: 0, stepTime: 0.3, to: 2);
  }

}
