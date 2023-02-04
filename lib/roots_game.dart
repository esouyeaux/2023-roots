import 'dart:ui';
import 'components/player.dart';
import 'components/world.dart';
import 'package:flame/game.dart';
import '../helpers/direction.dart';

class RootsGame extends FlameGame {
  final World _world = World();
  final Player _player = Player();

  @override
  Future<void> onLoad() async {
    await add(_world);
    add(_player);
    _player.position = _world.size / 2;
    camera.followComponent(_player,
        worldBounds: Rect.fromLTRB(0, 0, _world.size.x, _world.size.y));
  }

  void onJoypadDirectionChanged(Direction direction) {
    _player.direction = direction;
  }
}
