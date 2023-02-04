import 'dart:ui';
import 'components/player.dart';
import 'components/world.dart';
import 'package:flame/game.dart';
import '../helpers/direction.dart';
import 'components/attack.dart';
import 'components/attacks/default.dart';
import 'components/attacks/attack2.dart';
import 'components/attacks/pod_shot.dart';
import 'components/attacks/vine.dart';
import 'dart:math';

class RootsGame extends FlameGame {
  final World _world = World();
  final Player _player = Player();
  final List<Attack> _attack = [];

  @override
  Future<void> onLoad() async {
    await add(_world);
    add(_player);
    _attack.add(DefaultAttack());
    // _attack.add(Attack2());
    //_attack.add(PodShot());
    _attack.add(Vine());
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
      //atk.update(delta);
      atk.attackCD += delta;
      if (!atk.shown && atk.attackCD > atk.attackFrequency) {
        atk.attackCD -= atk.attackFrequency;
          atk.position = _player.position + (_player.size / 2) + atk.attack_spawn;
          atk.direction = Vector2(Random().nextInt(201) - 100.5, Random().nextInt(201) - 100.5);
          add(atk);
          atk.shown = true;
      } else if (atk.shown && atk.attackCD > atk.attackDuration) {
        atk.attackCD -= atk.attackDuration;
          remove(atk);
          atk.shown = false;
      }
    }
  }

}
