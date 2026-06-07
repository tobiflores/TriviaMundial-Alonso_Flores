extends Node

var datos_pais: DatosPais = null
var pais_actual: DatosPais
var cola_preguntas: Array[Pregunta] = []
var indiceActual: int = 0
var indice_pregunta_actual: int = 0

func iniciar(datos: DatosPais):
	pais_actual = datos
	cola_preguntas = datos.preguntas.duplicate().filter(func(p):
		return not GestorJuego.preguntaUsada(datos.pais, p.enunciado))
	cola_preguntas.shuffle()
	mostrar_pregunta(0)

func mostrar_pregunta(indice: int):
	$Grafico.visible = false
	$BotonContinuar.visible = false
	$Turno.text = "Turno: %s" % GestorJuego.nombres[GestorJuego.jugadorActual]
	indice_pregunta_actual = indice
	var preguntaActual: Pregunta = cola_preguntas[indice]
	$Label.text = preguntaActual.enunciado
	var opciones_mezcladas = preguntaActual.opciones.duplicate()
	var respuesta_correcta = opciones_mezcladas[preguntaActual.indice_correcto]
	opciones_mezcladas.shuffle()
	indiceActual = opciones_mezcladas.find(respuesta_correcta)
	var botones = $BotonesOpciones.get_children()
	for boton in botones:
		boton.modulate = Color.WHITE
	for i in range(botones.size()):
		botones[i].text = opciones_mezcladas[i]
		botones[i].disabled = false
		botones[i].visible = true
		var idx = i
		botones[i].pressed.connect(func(): verificar_respuesta(idx), CONNECT_ONE_SHOT)
	var jugador = GestorJuego.jugadorActual
	if GestorJuego.usos_cincuenta[jugador] <= 0:
		$Boton50.disabled = true
	else:
		$Boton50.disabled = false
	$usos50.text = "%d" % GestorJuego.usos_cincuenta[jugador]
	if GestorJuego.usos_llamada[jugador] <= 0:
		$BotonLlamada.disabled = true
	else:
		$BotonLlamada.disabled = false
	$usosLlamada.text = "%d" % GestorJuego.usos_llamada[jugador]

func verificar_respuesta(indice: int):
	var botones = $BotonesOpciones.get_children()
	for boton in botones:
		boton.disabled = true
		boton.add_theme_stylebox_override("disabled", boton.get_theme_stylebox("normal"))
		GestorJuego.marcar_pregunta_usada(pais_actual.pais, cola_preguntas[indice_pregunta_actual].enunciado)
	if indice == indiceActual:
		botones[indice].modulate = Color.GREEN
		$BotonContinuar.visible = true
		GestorJuego.respuesta_correcta()
	else:
		botones[indice].modulate = Color.RED
		botones[indiceActual].modulate = Color.GREEN
		$BotonContinuar.visible = true
		GestorJuego.respuesta_incorrecta()

func cincuenta_cincuenta():
	var botones = $BotonesOpciones.get_children()
	var incorrectos = []
	for i in range(botones.size()):
		if i != indiceActual:
			incorrectos.append(i)
	incorrectos.shuffle()
	botones[incorrectos[0]].visible = false
	botones[incorrectos[1]].visible = false

func mostrar_estadistica():
	var porcentajes = calcular_porcentajes()
	var letras = ["A", "B", "C", "D"]
	var barras = [$Grafico/VBoxContainer/HBoxContainerA, 
				  $Grafico/VBoxContainer/HBoxContainerB,
				  $Grafico/VBoxContainer/HBoxContainerC,
				  $Grafico/VBoxContainer/HBoxContainerD]
	
	for i in range(4):
		barras[i].get_child(0).text = "%s: %d%%" % [letras[i], porcentajes[i]]
		barras[i].get_child(1).custom_minimum_size = Vector2(porcentajes[i] * 2, 20)
	
	$Grafico.visible = true

func calcular_porcentajes() -> Array:
	var porcentajes = [0, 0, 0, 0]
	var correcta_gana = randf() < 0.7
	
	if correcta_gana:
		porcentajes[indiceActual] = randi_range(60, 80)
	else:
		var incorrecta = (indiceActual + 1) % 4
		porcentajes[incorrecta] = randi_range(60, 80)
	
	var resto = 100
	for i in range(4):
		resto -= porcentajes[i]
	
	var indices_vacios = []
	for i in range(4):
		if porcentajes[i] == 0:
			indices_vacios.append(i)
	
	indices_vacios.shuffle()
	for i in range(indices_vacios.size() - 1):
		var valor = randi_range(1, resto - (indices_vacios.size() - 1 - i))
		porcentajes[indices_vacios[i]] = valor
		resto -= valor
	porcentajes[indices_vacios[-1]] = max(1, resto)
	
	return porcentajes

func _on__50_pressed():
	var jugador = GestorJuego.jugadorActual
	if GestorJuego.usos_cincuenta[jugador] <= 0:
		return
	cincuenta_cincuenta()
	GestorJuego.usos_cincuenta[jugador] -= 1
	$Boton50.disabled = true
	$BotonLlamada.disabled = true
	$usos50.text = "%d" % GestorJuego.usos_cincuenta[jugador]

func _on_boton_llamada_pressed() -> void:
	var jugador = GestorJuego.jugadorActual
	if GestorJuego.usos_llamada[jugador] <= 0:
		return
	mostrar_estadistica()
	GestorJuego.usos_llamada[jugador] -= 1
	$BotonLlamada.disabled = true
	$Boton50.disabled = true
	$usosLlamada.text = "%d" % GestorJuego.usos_llamada[jugador]

func _on_boton_continuar_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/tablero.tscn")
