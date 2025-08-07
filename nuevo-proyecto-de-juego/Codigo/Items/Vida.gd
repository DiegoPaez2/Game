extends Area2D

func _ready() -> void:
	$AnimationPlayer.play("Vida")

func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	if body.is_in_group("Player"):
		Global.vida += 1
		print("Jugador 1 vida:", Global.vida)
		queue_free()
	elif body.is_in_group("Player2"):
		Global.vida1 += 1
		print("Jugador 2 vida:", Global.vida1)
		queue_free()
