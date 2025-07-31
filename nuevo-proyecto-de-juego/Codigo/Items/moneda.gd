extends Area2D


func _ready() -> void:
	$AnimationPlayer.play("Moneda")




func _on_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	 # Replace with function body.
	if body.is_in_group("Player"):
		Global.contador +=1
		print(Global.contador)
		queue_free()
