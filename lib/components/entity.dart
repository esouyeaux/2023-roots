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
  int _health = 300; // 1 heart = 100hp
  int get getHealth => _health;
  set setHealth(int h) => _health = h;

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
}
