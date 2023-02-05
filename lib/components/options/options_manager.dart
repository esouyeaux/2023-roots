
import 'option_picker.dart';
import '../option.dart';
import 'package:vector_math/vector_math_64.dart';

class OptionManager {
  final OptionPicker _optionPicker = OptionPicker();

  OptionManager();

  void createMenu(List<Option> option, Vector2 pos) {
    option.add(_optionPicker.getOption());
    option.add(_optionPicker.getOption());
    option[0].position = Vector2(pos.x - 190, pos.y - 95);
    option[1].position = Vector2(pos.x + 10, pos.y - 95);
  }

}
