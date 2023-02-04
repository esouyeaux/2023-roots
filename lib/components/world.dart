import 'package:flame/components.dart';
import 'package:roots_2023/roots_game.dart';

class World extends SpriteComponent with HasGameRef<RootsGame> {
  @override
  Future<void>? onLoad() async {
    sprite = await gameRef.loadSprite('rayworld_background.png');
    size = sprite!.originalSize;
    return super.onLoad();
  }
}