extends CharacterBody2D

@export var velocidad := 70
@export var gravedad := 800

var direccion := 1
var persiguiendo := false
var jugador: Node2D = null

@onready var ray_izq = $dect_izq
@onready var ray_der = $dect_dere
@onready var sprite = $AnimatedSprite2D

func _physics_process(delta):
	# Aplicar gravedad
	velocity.y += gravedad * delta

	if persiguiendo and jugador:
		var direccion_x = jugador.global_position.x - global_position.x
		direccion = sign(direccion_x)
		velocity.x = direccion * velocidad
	else:
		# Patrullaje automático
		if ray_der.is_colliding():
			direccion = -1
		elif ray_izq.is_colliding():
			direccion = 1
		velocity.x = direccion * velocidad

	move_and_slide()

	# Flip del sprite
	sprite.flip_h = direccion < 0

	# Animaciones
	if abs(velocity.x) > 0:
		if sprite.animation != "Caminar" or not sprite.is_playing():
			sprite.play("Caminar")
	else:
		if sprite.animation != "Idle" or not sprite.is_playing():
			sprite.play("Idle")

# Señal de detección del jugador
func _on_area_2d_body_entered(body):
	if body.name == "Jugador":
		jugador = body
		persiguiendo = true
		print("Jugador detectado")

# Señal de salida del jugador
func _on_area_2d_body_exited(body):
	if body == jugador:
		jugador = null
		persiguiendo = false
		print("Jugador perdido")
