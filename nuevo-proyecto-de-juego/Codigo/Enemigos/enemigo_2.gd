extends CharacterBody2D

var VELOCIDAD = 50
var movimiento = Vector2.ZERO
var forgod = true
var GRAVITY = 20

var puede_girar = true

func _process(_delta):
	hit()

func _physics_process(delta: float) -> void:
	# Aplicar gravedad
	movimiento.y += GRAVITY

	# ATAQUE si detecta al jugador con raycasts
	if $dect_izq.is_colliding():
		$Sprite2D.flip_h = true
		$AnimationPlayer.play("AtacarIzq")
		movimiento.x = 0


	elif $dect_dere.is_colliding():
		$Sprite2D.flip_h = false
		$AnimationPlayer.play("AtacarDere")
		movimiento.x = 0
	

	else:
		# Cambiar dirección al chocar con pared (solo si se permite)
		if is_on_wall() and puede_girar:
			forgod = not forgod
			puede_girar = false
			# Espera 0.2 segundos antes de volver a permitir el giro
			await get_tree().create_timer(0.2).timeout
			puede_girar = true

		# Movimiento horizontal y animación
		if forgod:
			movimiento.x = VELOCIDAD
			$AnimationPlayer.play("Caminar")
			$Sprite2D.flip_h = false
		else:
			movimiento.x = -VELOCIDAD
			$AnimationPlayer.play("Caminar")
			$Sprite2D.flip_h = true

	# Asignar la velocidad al cuerpo
	velocity = movimiento
	move_and_slide()
	

func hit():
	if $hit_izq.is_colliding():
		Global.vida -= 1
	if $hit_dere.is_colliding():
		Global.vida -= 1
