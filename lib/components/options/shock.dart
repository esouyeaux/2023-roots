
import '../option.dart';
import '../attacks/default.dart';
import '../attack.dart';
import 'package:flutter/material.dart';

class ShockwaveOption extends Option {
    ShockwaveOption() : super(
        "options/shockwave.png"
    );

  @override
  bool onTapUp(_) {
    this.clicked = true;
    return (true);
  }

  @override
  Attack getAttack() {
    return (DefaultAttack());
  }

}
