
import 'option_picker.dart';
import '../option.dart';
import 'package:vector_math/vector_math_64.dart';
import '../attack.dart';

class OptionManager {
  final OptionPicker _optionPicker = OptionPicker();
  bool pick_ready = false;

  OptionManager();

  void createMenu(List<Option> option, Vector2 pos) {
    option.add(_optionPicker.getOption());
    option.add(_optionPicker.getOption());
    option[0].position = Vector2(pos.x - 190, pos.y - 95);
    option[1].position = Vector2(pos.x + 10, pos.y - 95);
  }

  void update(List<Option> option) {
    pick_ready = false;
    for (var opt in option)
      if (opt.clicked)
        pick_ready = true;
  }

  void getOption(List<Option> option, List<Attack> attacks) {
    pick_ready = false;
    for (var opt in option)
      if (opt.clicked)
        attacks.add(opt.getAttack());
  }

}
