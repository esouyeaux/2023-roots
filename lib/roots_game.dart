import 'dart:ui';
import 'components/player.dart';
import 'components/world.dart';
import 'package:flame/game.dart';
import '../helpers/direction.dart';
import 'components/attack.dart';
import 'components/attacks/default.dart';
import 'components/attacks/attack2.dart';

class RootsGame extends FlameGame {
  final World _world = World();
  final Player _player = Player();
  final List<Attack> _attack = [];

  @override
  Future<void> onLoad() async {
    await add(_world);
    add(_player);
    _attack.add(DefaultAttack());
    _attack.add(Attack2());
    _player.position = _world.size / 2;
    camera.followComponent(_player,
        worldBounds: Rect.fromLTRB(0, 0, _world.size.x, _world.size.y));
  }

  void onJoypadDirectionChanged(Direction direction) {
    _player.direction = direction;
  }

  @override
  void update(double delta) {
    super.update(delta);

    for (var atk in _attack) {
      atk.attackCD += delta;
      if (atk.attackCD > atk.attackFrequency) {
        atk.attackCD -= atk.attackFrequency;
        if (!atk.shown) {
          atk.position = _player.position;
          add(atk);
          atk.shown = true;
        } else {
          remove(atk);
          atk.shown = false;
        }
      }
    }
  }

}
