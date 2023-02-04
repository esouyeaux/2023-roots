import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import '../helpers/direction.dart';
 
class Player extends SpriteAnimationComponent with HasGameRef {
  Direction direction = Direction.none;
  final double _playerSpeed = 300.0;
  final double _animationSpeed = 0.15;
  late final SpriteAnimation _standingAnimation;

 Player()
     : super(
         size: Vector2.all(100.0),
         angle: 1.57,
       );

 @override
 Future<void> onLoad() async {
  position = gameRef.size / 2;
   _loadAnimations().then((_) => {animation = _standingAnimation});
}
Future<void> _loadAnimations() async {
   final spriteSheet = SpriteSheet(
     image: await gameRef.images.load('sapling.png'),
     srcSize: Vector2(64.0, 64.0),
   );
 _standingAnimation = spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, to: 2);
 }

 @override
 void update(double delta) {
   super.update(delta);
   movePlayer(delta);
 }
 
 void movePlayer(double delta) {
   switch (direction) {
  case Direction.up:
    moveUp(delta);
    break;
  case Direction.down:
    moveDown(delta);
    break;
  case Direction.left:
    moveLeft(delta);
    break;
  case Direction.right:
    moveRight(delta);
    break;
  case Direction.none:
    break;
}
 }
 void moveDown(double delta) {
   position.add(Vector2(0, delta * _playerSpeed));
}
 void moveUp(double delta) {
   position.add(Vector2(0, - delta * _playerSpeed));
}
 void moveLeft(double delta) {
   position.add(Vector2(- delta * _playerSpeed, 0));
}
 void moveRight(double delta) {
   position.add(Vector2(delta * _playerSpeed, 0));
}
}
