import 'package:roots_2023/components/monster.dart';

import 'entity.dart';
import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/services.dart';

import 'world_collidable.dart';

//import 'package:flutter/material.dart' hide Image, Draggable;

class Player extends Entity with CollisionCallbacks {
  //todo replace by player spritesheet depending on EntityType
  JoystickComponent joystick;
  final double _animationSpeed = 0.3;
  late final SpriteAnimation _standingAnimation;
  late ShapeHitbox hitbox;
  bool _isOnEdge = false;

  int _xpToNextLevel = 100;
  int get getXpToNextLevel => _xpToNextLevel;
  set setXpToNextLevel(int xp) => _xpToNextLevel = xp;
  bool frozen = false;

  Player({
    required this.joystick,
  }) : super('sapling_spritesheet.png', Vector2(0, 0));
  


//activate to view hitbox
  @override
  Future<void> onLoad() async {
    _loadAnimations().then((_) => {animation = _standingAnimation});
  //   final defaultPaint = Paint()
  //     ..color = Colors.red
  //     ..style = PaintingStyle.stroke;
  //   hitbox = CircleHitbox()
  //     ..paint = defaultPaint
  //     ..renderShape = true;
    // add(hitbox);
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

  Future<void> _loadAnimations() async {
    final spriteSheet = SpriteSheet(
      image: await gameRef.images.load(imagePath),
      srcSize: Vector2(16.0, 16.0),
    );
    _standingAnimation
    = spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, to: 2);
  }

  @override
  void update(double dt) {
    if (frozen)
      return;
    super.update(dt);
    if (!joystick.delta.isZero()) {
      position.add(joystick.relativeDelta.normalized() * getMoveSpeed * dt);
    }
    if (_xpToNextLevel <= 0) {
      //modify sprite on level up
      _xpToNextLevel = 100;
      game.createMenu();
    }
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other)
  {
    super.onCollisionStart(intersectionPoints, other);
    if (other is WorldCollidable) {
      joystick.delta.negate();
      _isOnEdge = true;
    }
    if (other is Monster && !_isOnEdge) {
        position.add(other.velocity * 25);
        setHealth = getHealth - 25;
        print(getHealth);
        if (getHealth <= 0) {
          removeFromParent();
          //modify to endscreen + replay ?
          SystemNavigator.pop();
        }
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is WorldCollidable) {
      if (intersectionPoints.length == 2) {
        final mid = (intersectionPoints.elementAt(0) + intersectionPoints.elementAt(1)) / 2;
        final collisionNormal = absoluteCenter - mid;
        final separationDistance = (size.x / 2) - collisionNormal.length;
        position.add(collisionNormal.normalized().scaled(separationDistance));
      }
    }
    // if (other is Monster) {
    //   }
  }

  @override
  void onCollisionEnd(
    PositionComponent other,
  ) {
    super.onCollisionEnd(other);
    if (other is WorldCollidable) {
      _isOnEdge = false;
    }
  }
}
