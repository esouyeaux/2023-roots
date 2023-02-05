import 'package:flame/components.dart';
import 'package:roots_2023/roots_game.dart';
import 'package:flutter/material.dart';

import 'attack.dart';

class Option extends SpriteComponent with HasGameRef<RootsGame> {
  String imagePath;

    Option(this.imagePath) : super(
    priority: 5,
    size: Vector2.all(180.0),
    );

 @override
 Future<void> onLoad() async {
   super.onLoad();
   sprite = await gameRef.loadSprite(imagePath);
 }

}

