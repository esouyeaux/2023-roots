import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import '../attack.dart';

class Vine extends Attack {
  late final SpriteAnimation _standingAnimation;
  double turn_speed = 2;

    Vine () : super (Vector2(200.0, 50), 5, 4, Vector2(0, 0));

  @override
  Future<void> onLoad() async {
    _loadAnimations().then((_) => {animation = _standingAnimation});
  }

    Future<void> _loadAnimations() async {
    final spriteSheet = SpriteSheet(
      image: await gameRef.images.load("attack04_spritesheet.png"),
      srcSize: Vector2(64.0, 16.0),
    );
    _standingAnimation
    = spriteSheet.createAnimation(row: 0, stepTime: 1000000, to: 1);
  }

  @override
  void update(double delta) {
    super.update(delta);

    angle += delta * turn_speed;
  }

}
