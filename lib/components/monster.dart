import 'package:roots_2023/components/attack.dart';

import 'entity.dart';
import 'package:flame/components.dart';
import 'player.dart';

import 'package:flame/collisions.dart';
import 'world_collidable.dart';

class Monster extends Entity with CollisionCallbacks {
  //todo replace by monster spritesheet depending on EntityType

  late Player player;
  late Vector2 velocity;
  bool active = true;

  Monster(monsterType, position) : super(
    "monster_$monsterType.png",
    position);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    player = gameRef.player;
    setHealth = 100;
  }

  @override
  void update(double delta) {
    if (!active)
      return;
    super.update(delta);
    velocity = player.position - position;
    velocity.normalize();
    position += velocity * delta * (getMoveSpeed/2);
  }
  @override
  void onMount() {
    super.onMount();

    // Adding a circular hitbox with radius as 0.8 times
    // the smallest dimension of this components size.
    final shape = CircleHitbox.relative(
      0.8,
      parentSize: size,
      position: size / 2,
      anchor: Anchor.center,
    );
    add(shape);
  }

@override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other)
  {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Attack) {
          setHealth = getHealth - 100;
      if (getHealth <= 0) {
        removeFromParent();
        player.setXpToNextLevel = player.getXpToNextLevel - 10;
        print("xp left : ${player.getXpToNextLevel}");
      }
    }
  }
}