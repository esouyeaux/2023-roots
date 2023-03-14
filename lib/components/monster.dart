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
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Attack) {
      //modify 100 by other.dmg ?
      setHealth = getHealth - 100;
      if (getHealth <= 0) {
        removeFromParent();
        player.setXpToNextLevel = player.getXpToNextLevel - 10;
      }
    }
    // if (other is WorldCollidable) {
    //   }
    // }
    // if (other is Player) {
    //   removeFromParent();
    //   }
    }
}
