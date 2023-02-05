
import '../option.dart';
import '../attacks/pod_shot.dart';
import '../attack.dart';
import 'package:flutter/material.dart';

class PeaOption extends Option {
    PeaOption() : super(
        "options/peashot.png"
    );

  @override
  bool onTapUp(_) {
    this.clicked = true;
    return (true);
  }

  @override
  Attack getAttack() {
    return (PodShot());
  }

}
