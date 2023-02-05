import 'package:flame/components.dart';
import 'package:roots_2023/roots_game.dart';
import 'heart.dart';

class Hud extends PositionComponent with HasGameRef<RootsGame> {
  Hud({
    super.position,
    super.size,
    super.scale,
    super.angle,
    super.anchor,
    super.children,
    super.priority = 5,
  }) {
    positionType = PositionType.viewport;
  }

  @override
  Future<void>? onLoad() async {
    for (var i = 100; i <= game.player.getHealth; i = i + 100) {
      final positionX = 140 + 0.16 * i;
      await add(
        HeartHealthComponent(
          heartNumber: 1,
          position: Vector2(positionX.toDouble(), 10),
          size: Vector2.all(16),
        ),
      );
    }

    return super.onLoad();
  }
}