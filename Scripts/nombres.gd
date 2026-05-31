extends Control

func _on_jugar_pressed() -> void:
	GestorJuego.nombres[0] = $NombreJ1.text if $NombreJ1.text != "" else "Jugador 1"
	GestorJuego.nombres[1] = $NombreJ2.text if $NombreJ2.text != "" else "Jugador 2"
	get_tree().change_scene_to_file("res://Escenas/elegir_pais.tscn")
