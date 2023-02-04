import 'entity.dart';
import 'package:flame/components.dart';

class Player extends Entity {
  //todo replace by player spritesheet depending on EntityType
  Player(): super('sapling_spritesheet.png', Vector2(1200, 1200));
}
