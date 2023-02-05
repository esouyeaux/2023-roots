import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:roots_2023/roots_game.dart';

enum HeartState {
  quarter,
  half,
  quarterHalf,
  full
}

class HeartHealthComponent extends SpriteGroupComponent<HeartState> with HasGameRef<RootsGame> {
  final int heartNumber;

  HeartHealthComponent({
    required this.heartNumber,
    required super.position,
    required super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.priority,
  });

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    final spriteSheet = SpriteSheet(
        image: await gameRef.images.load('heart_spritesheet.png'),
        srcSize: Vector2(16.0, 16.0)
    );

    sprites = {
      HeartState.full: spriteSheet.getSprite(0, 0),
      HeartState.quarterHalf: spriteSheet.getSprite(1, 0),
      HeartState.half: spriteSheet.getSprite(2, 0),
      HeartState.quarter: spriteSheet.getSprite(3, 0),
    };

    current = HeartState.full;
  }

  @override
  void update(double dt) {
    /* todo handle health depending on player.health
  if (game.player < heartNumber) {
    current = HeartState.unavailable;
  } else {
    current = HeartState.available;
  }
  super.update(dt);
  }
        */
  }
}