import 'entity.dart';
import 'package:flame/components.dart';

class Player extends Entity {
  //todo replace by player spritesheet depending on EntityType
  JoystickComponent joystick;
  Player({
    required this.joystick,
  }) : super('sapling_spritesheet.png', Vector2(1200, 1200));

  @override
  void update(double dt) {
    super.update(dt);
    if (!joystick.delta.isZero()) {
      position.add(joystick.relativeDelta.normalized() * getMoveSpeed * dt);
    }
  } 
}
