extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -250.0
const GRAVITY = 550.0  # Ajusta según necesites

@onready var animSprite = $AnimatedSprite2D

func _physics_process(delta):
	var input_vector = Vector2.ZERO

	if Input.is_action_pressed("derecha2"):
		input_vector.x += 1
	if Input.is_action_pressed("izquierda2"):
		input_vector.x -= 1

	velocity.x = input_vector.x * SPEED

	if input_vector.x != 0:
		animSprite.flip_h = input_vector.x < 0

	if Input.is_action_just_pressed("arriba2") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	velocity.y += GRAVITY * delta

	if not is_on_floor():
		if velocity.y < 0 and animSprite.animation != "Saltar":
			animSprite.play("Saltar")
		elif velocity.y >= 0 and animSprite.animation != "Caer":
			animSprite.play("Caer")
	else:
		if abs(velocity.x) < 1.0:
			if animSprite.animation != "Idle":
				animSprite.play("Idle")
		else:
			if animSprite.animation != "Correr":
				animSprite.play("Correr")


	move_and_slide()
