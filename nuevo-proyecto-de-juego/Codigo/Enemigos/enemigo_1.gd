extends CharacterBody2D

const Personajes_1 = preload("res://Codigo/Personajes/personajes_1.gd")

@export var velocidad := 70
@export var gravedad := 800

var direccion := 1
var persiguiendo := false
var jugador: Node2D = null

@onready var ray_izq = $dect_izq
@onready var ray_der = $dect_dere
@onready var anim = $AnimationPlayer
@onready var sprite = $Sprite2D

func _physics_process(delta):
	if persiguiendo and jugador != null:
		# Seguir al jugador
		var distancia = jugador.global_position.x - global_position.x
		direccion = sign(distancia)
		velocity.x = direccion * velocidad
	else:
		# Patrullaje simple
		if ray_der.is_colliding():
			direccion = -1
		elif ray_izq.is_colliding():
			direccion = 1
		velocity.x = direccion * velocidad

	# Aplicar gravedad
	velocity.y += gravedad * delta

	# Movimiento
	move_and_slide()

	# Animación
	sprite.flip_h = direccion < 0
	if abs(velocity.x) > 0:
		anim.play("Caminar ")
	else:
		anim.play("Idle")

# Señales del Area2D para detectar jugador
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Jugador" or body is Personajes_1:
		persiguiendo = true
		jugador = body

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == jugador:
		persiguiendo = false
		jugador = null
