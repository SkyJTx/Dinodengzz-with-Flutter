import 'dart:async';
import 'dart:ui';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:ruam_mitt/Dinodengzz/Component/collision_block.dart';
import 'package:ruam_mitt/Dinodengzz/Component/custom_hitbox.dart';
import 'package:ruam_mitt/Dinodengzz/Component/player.dart';
import 'package:ruam_mitt/Dinodengzz/Component/utils.dart';
import 'package:ruam_mitt/Dinodengzz/routes.dart';

enum State { idle, run, hit }

class Patrick extends SpriteAnimationGroupComponent
    with HasGameRef<GameRoutes>, CollisionCallbacks {
  final double _gravity = 9.82;
  final Player player;
  final double offNeg;
  final double offPos;
  Patrick({
    super.position,
    super.size,
    this.offNeg = 0,
    this.offPos = 0,
    required this.player,
  });

  List<CollisionBlock> collisionBlocks = [];

  static const stepTime = 0.05;
  static const tileSize = 16;
  static const runSpeed = 80;
  static const _bounceHeight = 400.0;
  final textureSize = Vector2(32, 32);

  Vector2 velocity = Vector2.zero();
  double rangeNeg = 0;
  double rangePos = 0;
  double sight = 45;
  double moveDirection = 1;
  double targetDirection = -1;
  bool gotStomped = false;
  CustomHitBox hitbox = CustomHitBox(
    offsetX: 0,
    offsetY: 0,
    width: 32,
    height: 32,
  );

  late final SpriteAnimation _idleAnimation;
  late final SpriteAnimation _runAnimation;
  late final SpriteAnimation _hitAnimation;

  bool isOnGround = false;

  @override
  FutureOr<void> onLoad() {
    //debugMode = true;
    add(RectangleHitbox(
      position: Vector2(4, 6),
      size: Vector2(24, 22),
    ));
    _loadAllAnimations();
    _calculateRange();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (!gotStomped) {
      _updateState();
      _movement(dt);
      _applyGravity(dt);
      _checkVerticalCollisions();
    }
    super.update(dt);
  }

  void _loadAllAnimations() {
    _idleAnimation = _spriteAnimation('Idle', 12);
    _runAnimation = _spriteAnimation('Run', 12);
    _hitAnimation = _spriteAnimation('Hit', 8)..loop = false;

    animations = {
      State.idle: _idleAnimation,
      State.run: _runAnimation,
      State.hit: _hitAnimation,
    };

    current = State.idle;
  }

  SpriteAnimation _spriteAnimation(String state, int amount) {
    return SpriteAnimation.fromFrameData(
      game.images.fromCache('Opponent (Patrick)/$state (32x32).png'),
      SpriteAnimationData.sequenced(
        amount: amount,
        stepTime: stepTime,
        textureSize: textureSize,
      ),
    );
  }

  void _calculateRange() {
    rangeNeg = position.x - offNeg * tileSize;
    rangePos = position.x + offPos * tileSize;
  }

  void _movement(dt) {
    velocity.x = 0;

    double playerOffset = (player.scale.x > 0) ? 0 : -player.width;
    double patrickOffset = (scale.x > 0) ? 0 : -width;

    if (playerInRange()) {
      targetDirection =
          (player.x + playerOffset < position.x + patrickOffset) ? -1 : 1;
      velocity.x = targetDirection * runSpeed;
    }
    moveDirection = lerpDouble(moveDirection, targetDirection, 0.1) ?? 1;
    position.x += velocity.x * dt;
  }

  bool playerInRange() {
    double playerOffset = (player.scale.x > 0) ? 0 : -player.width;

    return player.x + playerOffset >= rangeNeg &&
        player.x + playerOffset <= rangePos &&
        player.y + player.height + sight > position.y &&
        player.y < position.y + height + sight;
  }

  void _updateState() {
    current = (velocity.x != 0) ? State.run : State.idle;

    if ((moveDirection < 0 && scale.x > 0) ||
        (moveDirection > 0 && scale.x < 0)) {
      flipHorizontallyAroundCenter();
    }
  }

  void collidedWithPlayer() async {
    if (player.velocity.y > 0 && player.y + player.height > position.y) {
      gotStomped = true;
      current = State.hit;
      player.velocity.y = -_bounceHeight;
      await animationTicker?.completed;
      removeFromParent();
    } else {
      player.collidedwithEnemy();
    }
  }

  void _applyGravity(double dt) {
    velocity.y += _gravity;
    position.y += velocity.y * dt;
  }

  void _checkVerticalCollisions() {
    for (final block in collisionBlocks) {
      if (checkCollision(this, block)) {
        if (velocity.y > 0) {
          velocity.y = 0;
          position.y = block.y - hitbox.height - hitbox.offsetY;
          isOnGround = true;
          break;
        }
        if (velocity.y < 0) {
          velocity.y = 0;
          position.y = block.y + hitbox.height - hitbox.offsetY;
        }
      }
    }
  }
}
