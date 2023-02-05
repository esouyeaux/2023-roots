
import '../option.dart';
import '../attacks/vine.dart';
import '../attack.dart';
import 'package:flutter/material.dart';

class VineOption extends Option {
    VineOption() : super(
        "options/vine.png"
    );

  @override
  bool onTapUp(_) {
    this.clicked = true;
    return (true);
  }

  @override
  Attack getAttack() {
    return (Vine());
  }
}
