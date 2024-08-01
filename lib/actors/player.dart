import 'dart:async';

import 'package:flame/components.dart';
import 'package:flutter/services.dart';
import 'package:two_d_game/actors/player_model.dart';
import 'package:two_d_game/pixel_adventure.dart';
import 'package:two_d_game/utils/enums.dart';

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<PixelAdventure>, KeyboardHandler {
  Player({
    required this.playerModel,
    // required super.position,
  });

  late PlayerModel playerModel;

  @override
  FutureOr<void> onLoad() {
    _loadAllAnimations();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    _updatePlaterMovement(dt);
    super.update(dt);
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final isLeftKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyA) ||
        keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    final isRightKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyD) ||
        keysPressed.contains(LogicalKeyboardKey.arrowRight);
    if (isLeftKeyPressed && isRightKeyPressed) {
      playerModel.playerDirection = PlayerDirection.none;
    } else if (isRightKeyPressed) {
      playerModel.playerDirection = PlayerDirection.right;
    } else if (isLeftKeyPressed) {
      playerModel.playerDirection = PlayerDirection.left;
    } else {
      playerModel.playerDirection = PlayerDirection.none;
    }
    return super.onKeyEvent(event, keysPressed);
  }

  void _loadAllAnimations() {
    playerModel.idleAnimation = _spriteAnimation(amount: 11, state: "Idle");

    playerModel.runningAnimation = _spriteAnimation(amount: 12, state: "Run");
    animations = {
      PlayerState.idle: playerModel.idleAnimation,
      PlayerState.running: playerModel.runningAnimation,
    };
    current = PlayerState.idle;
  }

  SpriteAnimation _spriteAnimation(
      {required int amount, required String state}) {
    return SpriteAnimation.fromFrameData(
      game.images.fromCache(
          "Main Characters/${playerModel.character}/$state (32x32).png"),
      SpriteAnimationData.sequenced(
        amount: amount,
        stepTime: playerModel.steptime,
        textureSize: Vector2.all(32),
      ),
    );
  }

  void _updatePlaterMovement(double dt) {
    double dirx = 0;
    switch (playerModel.playerDirection) {
      case PlayerDirection.left:
        if (playerModel.isFacingRight == true) {
          flipHorizontallyAroundCenter();
          playerModel.isFacingRight = false;
        }
        current = PlayerState.running;
        dirx -= playerModel.moveSpeed;
        break;
      case PlayerDirection.right:
        if (playerModel.isFacingRight == false) {
          flipHorizontallyAroundCenter();
          playerModel.isFacingRight = true;
        }
        current = PlayerState.running;

        dirx += playerModel.moveSpeed;
        break;
      case PlayerDirection.none:
        current = PlayerState.idle;
        break;
    }
    playerModel.velocity = Vector2(dirx, 0);
    position += playerModel.velocity * dt;
  }
}
