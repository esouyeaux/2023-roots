import 'entity.dart';
import 'package:flame/components.dart';
import 'player.dart';

class Monster extends Entity {
  //todo replace by monster spritesheet depending on EntityType

  late Player player;

  Monster(position) : super(
    'axe_spritesheet.png', 
    position);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    player = gameRef.player;
  }

  @override
  void update(double delta) {
    super.update(delta);
    Vector2 direction = player.position - position;
    direction.normalize();
    position += direction * delta * (getMoveSpeed/2);
  }
}
