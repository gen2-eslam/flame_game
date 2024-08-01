import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:two_d_game/pixel_adventure.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Flame.device.fullScreen();
  await Flame.device.setLandscape();
  PixelAdventure game = PixelAdventure();
  game.onLoad();
  runApp(
    GameWidget(
      game: kDebugMode ? PixelAdventure() : game,
    ),
  );
}
