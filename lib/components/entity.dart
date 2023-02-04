import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:roots_2023/roots_game.dart';
import '../helpers/direction.dart';
import '../helpers/entity.dart';

class Entity extends SpriteAnimationComponent with HasGameRef<RootsGame> {
  // display
  String imagePath;
  final double _animationSpeed = 0.15;
  late final SpriteAnimation _standingAnimation;
  Direction direction = Direction.none;

  // attributes
  final double _attack = 300.0;
  final double _attackSpeed = 300.0;
  final double _defense = 300.0;
  final double _moveSpeed = 300.0;
  EntityType entityType = EntityType.sprout;

  Entity(this.imagePath): super(
    size: Vector2.all(50.0)
  );

  @override
  Future<void> onLoad() async {
    position = gameRef.size / 2;
    _loadAnimations().then((_) => {animation = _standingAnimation});
  }

  Future<void> _loadAnimations() async {
    final spriteSheet = SpriteSheet(
      image: await gameRef.images.load(imagePath),
      srcSize: Vector2(29.0, 32.0),
    );
    _standingAnimation
    = spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, to: 2);
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
        animation = _standingAnimation;
        break;
    }
  }

  void moveUp(double delta) {
    position.add(Vector2(0, -(delta * _moveSpeed)));
  }

  void moveDown(double delta) {
    position.add(Vector2(0, delta * _moveSpeed));
  }

  void moveLeft(double delta) {
    position.add(Vector2(-(delta * _moveSpeed), 0));
  }

  void moveRight(double delta) {
    position.add(Vector2(delta * _moveSpeed, 0));
  }
}
