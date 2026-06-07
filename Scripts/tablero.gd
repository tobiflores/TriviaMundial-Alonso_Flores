extends Control

func _ready():
	_colocar_jugador(0)
	_colocar_jugador(1)
	
	if GestorJuego.debe_mover:
		mover_jugador(GestorJuego.jugador_que_mueve)
		GestorJuego.debe_mover = false
		if GestorJuego.ganador != -1:
			return
	
	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file("res://Escenas/elegir_pais.tscn")

func mover_jugador(jugador_idx: int):
	GestorJuego.posiciones[jugador_idx] += 1
	var nueva_pos = GestorJuego.posiciones[jugador_idx]
	if nueva_pos >= 30:
		GestorJuego.ganador = jugador_idx
		get_tree().change_scene_to_file("res://Escenas/ganador.tscn")
		return
	_colocar_jugador(jugador_idx)

func _colocar_jugador(jugador_idx: int):
	var pos = GestorJuego.posiciones[jugador_idx]
	var nombre_casilla: String
	if pos == 0:
		nombre_casilla = "inicio"
	elif pos == 1:
		nombre_casilla = "casilla"
	else:
		nombre_casilla = "casilla%d" % pos
	var casilla = $casillas.get_node_or_null(nombre_casilla)
	if casilla == null:
		push_error("No se encontró: %s" % nombre_casilla)
		return
	var jugador
	if jugador_idx == 0:
		jugador = $jugadores/jugador
		if GestorJuego.posiciones[0] == GestorJuego.posiciones[1]:
			jugador.global_position = casilla.global_position + Vector2(10, 0)
		else:
			jugador.global_position = casilla.global_position
	else:
		jugador = $jugadores/jugador2
		if GestorJuego.posiciones[0] == GestorJuego.posiciones[1]:
			jugador.global_position = casilla.global_position + Vector2(-10, 0)
		else:
			jugador.global_position = casilla.global_position
