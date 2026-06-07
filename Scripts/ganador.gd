extends Node2D

func _ready() -> void:
	$Ganador.text = "%s ganó la partida!" % GestorJuego.nombres[GestorJuego.ganador]
	$SonidoVictoria.play()

func _on_volver_al_menu_pressed() -> void:
	GestorJuego.reiniciar()
	get_tree().change_scene_to_file("res://Escenas/menu.tscn")
