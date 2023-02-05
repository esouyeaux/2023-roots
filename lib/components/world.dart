import 'package:flame/components.dart';
import 'package:roots_2023/roots_game.dart';
import 'world_collidable.dart';
import '../helpers/map_loader.dart';

class World extends SpriteComponent with HasGameRef<RootsGame> {

  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite('roots_world.png');
    size = sprite!.originalSize;
    // size = Vector2.all(4000.0);
    return super.onLoad();
  }

  @override
  void onMount() {
    super.onMount();
    addWorldCollision();
  }

  void addWorldCollision() async =>
  (await MapLoader.readWorldCollisionMap()).forEach((rect) {
    add(WorldCollidable()
      ..position = Vector2(rect.left, rect.top)
      ..width = rect.width
      ..height = rect.height);
  });
}