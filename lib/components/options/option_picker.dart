
import '../option.dart';
import 'dart:math';
import 'pea.dart';
import 'vine.dart';
import 'shock.dart';
import 'doodoo.dart';
import '../../roots_game.dart';
import '../attack.dart';

class OptionPicker {
    List<Option> _options = [];

    OptionPicker() {
        _options.add(PeaOption());
        _options.add(VineOption());
        _options.add(ShockwaveOption());
        _options.add(DoodooOption());
    }

    Option getOption() {
        if (_options.length == 0)
            return (PeaOption());
        Option ret = _options[Random().nextInt(_options.length)];

        _options.remove(ret);
        return (ret);
    }
}
