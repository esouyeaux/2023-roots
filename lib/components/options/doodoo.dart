
import '../option.dart';
import '../attacks/attack2.dart';
import '../attack.dart';
import 'package:flutter/material.dart';

class DoodooOption extends Option {
    DoodooOption() : super(
        "options/doodoo.png"
    );

  @override
  bool onTapUp(_) {
    this.clicked = true;
    return (true);
  }

  @override
  Attack getAttack() {
    return (Attack2());
  }

}
