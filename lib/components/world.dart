import 'package:flame/components.dart';
import 'package:roots_2023/roots_game.dart';

class World extends SpriteComponent with HasGameRef<RootsGame> {
  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite('roots_world.png');
    size = Vector2.all(4000.0);
    return super.onLoad();
  }
}