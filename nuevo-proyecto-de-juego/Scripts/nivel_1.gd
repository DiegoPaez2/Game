extends Node2D

@onready var jugador = $Jugador
@onready var panel_pausa = $UI/ContenedorUI/CenterContainer/PanelContainer
@onready var boton_pausa = $UI/ContenedorUI/BotonPausa
@onready var boton_continuar = $UI/ContenedorUI/CenterContainer/PanelContainer/VBoxContainer/Continuar
@onready var boton_reiniciar = $UI/ContenedorUI/CenterContainer/PanelContainer/VBoxContainer/Reiniciar
@onready var boton_regresar = $UI/ContenedorUI/CenterContainer/PanelContainer/VBoxContainer/RegresarMenu

var posicion_inicial = Vector2.ZERO
var menu_activo = false

func _ready():
	posicion_inicial = jugador.position
	panel_pausa.visible = false  # Empieza oculto
	
	# Conexiones de botones
	boton_pausa.connect("pressed", Callable(self, "_on_boton_pausa_pressed"))
	boton_continuar.connect("pressed", Callable(self, "_on_continuar_pressed"))
	boton_reiniciar.connect("pressed", Callable(self, "_on_reiniciar_pressed"))
	boton_regresar.connect("pressed", Callable(self, "_on_regresar_menu_pressed"))

func _input(event):
	if event.is_action_pressed("pausar"):
		_toggle_menu_pausa()

func _on_boton_pausa_pressed():
	_toggle_menu_pausa()

func _toggle_menu_pausa():
	menu_activo = !menu_activo
	panel_pausa.visible = menu_activo  # Mostrar/ocultar todo el PanelContainer
	get_tree().paused = menu_activo

func _on_continuar_pressed():
	_toggle_menu_pausa()

func _on_reiniciar_pressed():
	jugador.position = posicion_inicial
	_toggle_menu_pausa()

func _on_regresar_menu_pressed():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://menu.tscn")
