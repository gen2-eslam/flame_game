import 'package:flame/components.dart';
import 'package:two_d_game/utils/enums.dart';

class PlayerModel {
  late String character;
  final double steptime = 0.05;
  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runningAnimation;
  double moveSpeed = 100;
  Vector2 velocity = Vector2.zero();
  bool isFacingRight = true;
  PlayerDirection playerDirection = PlayerDirection.none;

  // PlayerModel({required this.character});
  // singleton

  static final PlayerModel _inst = PlayerModel._internal();

  PlayerModel._internal();

  factory PlayerModel({required String character}) {
    _inst.character = character;
    return _inst;
  }
}
