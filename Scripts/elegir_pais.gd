extends Control

func _ready() -> void:
	$GridContainer/Button6.pressed.connect(_al_clickear_bandera.bind("estadosunidos"))
	$GridContainer/Button.pressed.connect(_al_clickear_bandera.bind("argentina"))
	$GridContainer/Button4.pressed.connect(_al_clickear_bandera.bind("inglaterra"))
	$GridContainer/Button2.pressed.connect(_al_clickear_bandera.bind("francia"))
	$GridContainer/Button3.pressed.connect(_al_clickear_bandera.bind("italia"))
	$GridContainer/Button5.pressed.connect(_al_clickear_bandera.bind("japon"))
	$Turno.text = "Turno: %s" % GestorJuego.nombres[GestorJuego.jugadorActual]
	$Turno.modulate = GestorJuego.colores_jugadores[GestorJuego.jugadorActual]
	$Puntaje1.modulate = GestorJuego.colores_jugadores[0]
	$Puntaje1.text = "%s: %d" % [GestorJuego.nombres[0], GestorJuego.puntajes[0]]
	$Puntaje2.modulate = GestorJuego.colores_jugadores[1]
	$Puntaje2.text = "%s: %d" % [GestorJuego.nombres[1], GestorJuego.puntajes[1]]
	_actualizar_botones()

func _al_clickear_bandera(codigo_pais: String):
	var ruta = "res://data/paises/%s.tres" % codigo_pais
	var datos_pais: DatosPais = load(ruta).duplicate(true)
	var pregunta_scene = load("res://Escenas/pregunta.tscn").instantiate()
	get_tree().root.add_child(pregunta_scene)
	pregunta_scene.iniciar(datos_pais)
	get_tree().current_scene.queue_free()
	get_tree().current_scene = pregunta_scene
	
func _actualizar_botones():
	var paises = {
	$GridContainer/Button6: "estadosunidos",
	$GridContainer/Button: "argentina",
	$GridContainer/Button4: "inglaterra",
	$GridContainer/Button2: "francia",
	$GridContainer/Button3: "italia",
	$GridContainer/Button5: "japon"
	}
	var noHayPreguntas = true
	for boton in paises:
		var codigo = paises[boton]
		var datos: DatosPais = load("res://data/paises/%s.tres" % codigo)
		var quedan = datos.preguntas.filter(func(p):
			return not GestorJuego.preguntaUsada(datos.pais, p.enunciado)
		)
		if quedan.is_empty():
			boton.modulate = Color.RED
			boton.disabled = true
		else:
			noHayPreguntas = false
	if noHayPreguntas:
		get_tree().change_scene_to_file("res://Escenas/ganador.tscn")
