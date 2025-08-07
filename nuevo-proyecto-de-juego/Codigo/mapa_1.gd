extends Node2D


func _ready():
	if Global.modo_de_juego == "individual":
		$Jugador2.hide()
		$Jugador2.set_process(false)
		$Jugador2.set_physics_process(false)
	else:
		$Jugador2.show()
		$Jugador2.set_process(true)
		$Jugador2.set_physics_process(true)
