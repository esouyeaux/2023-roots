import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:roots_2023/roots_game.dart';
import '../helpers/direction.dart';
import '../helpers/entity.dart';

class Entity extends SpriteAnimationComponent with HasGameRef<RootsGame> {
  // display
  String imagePath;
  final double _animationSpeed = 0.3;
  late final SpriteAnimation _standingAnimation;
  Direction direction = Direction.none;

  // attributes
  final double _attack = 300.0;
  final double _attackSpeed = 300.0;
  final double _defense = 300.0;
  double _moveSpeed = 300.0;

  double get getMoveSpeed => _moveSpeed;
  set setMoveSpeed(double moveSpeed) => _moveSpeed = moveSpeed;

  EntityType entityType = EntityType.sprout;

  // todo : take size in constructor to display larger enemies
  Entity(
    this.imagePath,
    Vector2? spawnPos
    ) : super(
    priority: 2,
    size: Vector2.all(40.0),
    position: spawnPos,
  );

  @override
  Future<void> onLoad() async {
    _loadAnimations().then((_) => {animation = _standingAnimation});
  }

  Future<void> _loadAnimations() async {
    final spriteSheet = SpriteSheet(
      image: await gameRef.images.load(imagePath),
      srcSize: Vector2(16.0, 16.0),
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
    if (position.y - (delta * _moveSpeed) < 0)
      position.y = 0;
    else
      position.add(Vector2(0, -(delta * _moveSpeed)));
  }

  void moveDown(double delta) {
    if (position.y + delta * _moveSpeed > 2400 - size.y)
      position.y = 2400 - size.y;
    else
    position.add(Vector2(0, delta * _moveSpeed));
  }

  void moveLeft(double delta) {
    if (position.x - (delta * _moveSpeed) < 0)
      position.x = 0;
    else
      position.add(Vector2(-(delta * _moveSpeed), 0));
  }

  void moveRight(double delta) {
    if (position.x + delta * _moveSpeed > 2400 - size.x)
      position.x = 2400 - size.x;
    else
      position.add(Vector2(delta * _moveSpeed, 0));
  }
}
