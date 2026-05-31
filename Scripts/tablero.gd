extends Control

func _ready():
	print("debe_mover: ", GestorJuego.debe_mover)
	print("posiciones: ", GestorJuego.posiciones)
	print("jugador actual: ", GestorJuego.jugadorActual)
	_colocar_jugador(0)
	_colocar_jugador(1)
	 
	if GestorJuego.debe_mover:
		mover_jugador(GestorJuego.jugador_que_mueve)
		GestorJuego.debe_mover = false
	await get_tree().create_timer(2.0).timeout
	get_tree().change_scene_to_file("res://Escenas/elegir_pais.tscn")
func mover_jugador(jugador_idx: int):
	GestorJuego.posiciones[jugador_idx] += 1
	var nueva_pos = GestorJuego.posiciones[jugador_idx]

	print("moviendo jugador %d a casilla %d" % [jugador_idx, nueva_pos])

	if nueva_pos >= 30:
		print("%s ganó!" % GestorJuego.nombres[jugador_idx])
		return

	_colocar_jugador(jugador_idx)

func _colocar_jugador(jugador_idx: int):
	var pos = GestorJuego.posiciones[jugador_idx]
	print("colocando jugador %d en posicion %d" % [jugador_idx, pos])
	var nombre_casilla: String
	if pos == 0:
		nombre_casilla = "casilla"
	else:
		nombre_casilla = "casilla%d" % pos
		
	print("buscando nodo: ", nombre_casilla)
	var casilla = $casillas.get_node_or_null(nombre_casilla)
	if casilla == null:
		push_error("No se encontró: %s" % nombre_casilla)
		return
	print("casilla encontrada en: ", casilla.global_position)
	var jugador
	if jugador_idx == 0:
		jugador = $jugadores/jugador
	else:
		jugador = $jugadores/jugador2
	print("jugador posicion antes: ", jugador.global_position)
	jugador.global_position = casilla.global_position
	print("jugador posicion despues: ", jugador.global_position)
