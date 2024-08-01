import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:two_d_game/actors/player.dart';
import 'package:two_d_game/actors/player_model.dart';

class Level extends World {
  late TiledComponent level;
  final String levelName;
  final Player player;
  Level({required this.player, required this.levelName});

  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load(
      "$levelName.tmx",
      Vector2.all(16),
    );
    add(level);
    final spawnPointsLayer = level.tileMap.getLayer<ObjectGroup>("spwnpoints");
    for (final sp in spawnPointsLayer!.objects) {
      switch (sp.class_) {
        case "player":
          player.position = Vector2(sp.x, sp.y);
          add(player);
          break;
      }
    }

    return super.onLoad();
  }
}
