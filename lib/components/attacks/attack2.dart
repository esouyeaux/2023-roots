import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import '../attack.dart';

class Attack2 extends Attack {
  late final SpriteAnimation _standingAnimation;

    Attack2 () : super (Vector2.all(50.0), 1, 3, Vector2(-25, 0), 100);

  @override
  Future<void> onLoad() async {
    _loadAnimations().then((_) => {animation = _standingAnimation});
  }

    Future<void> _loadAnimations() async {
    final spriteSheet = SpriteSheet(
      image: await gameRef.images.load("attack02_spritesheet.png"),
      srcSize: Vector2(32.0, 32.0),
    );
    _standingAnimation
    = spriteSheet.createAnimation(row: 0, stepTime: 1000000, to: 1);
  }

}
