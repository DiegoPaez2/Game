extends Control


func _on_pausa_pressed() -> void:
	get_tree().paused = true


func _on_continuar_pressed() -> void:
	get_tree().paused = false


func _on_reinicio_pressed() -> void:
	get_tree().reload_current_scene()
