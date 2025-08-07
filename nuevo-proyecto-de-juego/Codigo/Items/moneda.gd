extends Area2D

func _ready() -> void:
	$AnimationPlayer.play("Moneda")

func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.is_in_group("Player"):
		Global.moneda += 1
		print("Jugador 1:", Global.moneda)
		queue_free()
	elif body.is_in_group("Player2"):
		Global.moneda1 += 1
		print("Jugador 2:", Global.moneda1)
		queue_free()
