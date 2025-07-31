extends CharacterBody2D

@export var velocidad := 70
@export var gravedad := 800

enum Estado { PATRULLANDO, PERSIGUIENDO }
var estado = Estado.PATRULLANDO

var direccion := 1
var jugador: Node2D = null

@onready var ray_izq = $dect_izq
@onready var ray_der = $dect_dere
@onready var area_deteccion = $Area2D

func _physics_process(delta):
	match estado:
		Estado.PATRULLANDO:
			patrullar()
		Estado.PERSIGUIENDO:
			perseguir()

	if is_on_floor():
		velocity.y = 0
	else:
		velocity.y += gravedad * delta

	move_and_slide()

	$Sprite2D.flip_h = (direccion < 0)

	if velocity.x != 0:
		$AnimationPlayer.play("Caminar")
	else:
		$AnimationPlayer.play("Idle")

func patrullar():
	if ray_der.is_colliding():
		direccion = -1
	elif ray_izq.is_colliding():
		direccion = 1

	velocity.x = direccion * velocidad

func perseguir():
	if jugador:
		direccion = 1 if jugador.global_position.x > global_position.x else -1
		velocity.x = direccion * velocidad
	else:
		estado = Estado.PATRULLANDO

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Jugador":
		jugador = body
		estado = Estado.PERSIGUIENDO

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body == jugador:
		jugador = null
		estado = Estado.PATRULLANDO
