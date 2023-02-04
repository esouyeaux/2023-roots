import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import '../attack.dart';

class PodShot extends Attack {
  late final SpriteAnimation _standingAnimation;

    PodShot () : super (Vector2.all(20.0), 2, 4, Vector2(-10, -10));

  @override
  Future<void> onLoad() async {
    _loadAnimations().then((_) => {animation = _standingAnimation});
  }

    Future<void> _loadAnimations() async {
    final spriteSheet = SpriteSheet(
      image: await gameRef.images.load("attack03_spritesheet.png"),
      srcSize: Vector2(32.0, 32.0),
    );
    _standingAnimation
    = spriteSheet.createAnimation(row: 0, stepTime: 1000000, to: 1);
  }

  @override
  void update(double delta) {
    super.update(delta);
    
    this.position += Vector2(delta * this.direction.x, delta * this.direction.y);
  }

}
