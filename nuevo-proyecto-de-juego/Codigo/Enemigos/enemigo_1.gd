extends CharacterBody2D

var VELOCIDAD = 50
var movimiento = Vector2.ZERO
var forgod = true
var GRAVITY = 20

func _physics_process(delta: float) -> void:
	movimiento.y += GRAVITY

	if $dect_izq.is_colliding():
		Global.vida -= 1
	if $dect_dere.is_colliding():
		Global.vida -= 1

	if is_on_wall():
		forgod = not forgod

	if forgod:
		movimiento.x = VELOCIDAD * delta
		$CollisionShape2D.position.x = 9
		$AnimatedSprite2D.play("Caminar")
		$AnimatedSprite2D.flip_h = false
	else:
		movimiento.x = -VELOCIDAD * delta
		$CollisionShape2D.position.x = -9
		$AnimatedSprite2D.play("Caminar")
		$AnimatedSprite2D.flip_h = true

	move_and_slide()
	
