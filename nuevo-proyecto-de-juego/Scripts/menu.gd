extends Control

func _on_individual_pressed() -> void:
	Global.modo_de_juego = "individual"
	get_tree().change_scene_to_file("res://Escenas/Mapas/Mapa1.tscn")

func _on_multi_pressed() -> void:
	Global.modo_de_juego = "grupal"
	get_tree().change_scene_to_file("res://Escenas/Mapas/Mapa1.tscn")

func _on_salir_pressed() -> void:
	get_tree().quit()
