import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/image_composition.dart';
import 'package:two_d_game/actors/player.dart';
import 'package:two_d_game/actors/player_model.dart';
import 'package:two_d_game/levels/level.dart';

class PixelAdventure extends FlameGame
    with HasKeyboardHandlerComponents, DragCallbacks {
  late CameraComponent cam;

  @override
  Color backgroundColor() => const Color(0xff211f30);
  Player player = Player(
    playerModel: PlayerModel(character: "Ninja Frog"),
  );
  late JoystickComponent joystick;

  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();
    final Level world = Level(
      levelName: "level-01",
      player: player,
    );
    cam = CameraComponent.withFixedResolution(
        width: 640, height: 360, world: world);
    cam.viewfinder.anchor = Anchor.topLeft;
    addAll([
      cam,
      world,
    ]);
    addJoystick();
    return super.onLoad();
  }

  void addJoystick() {
    joystick = JoystickComponent(
      
    );
  }
}
