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
	indice_pregunta_actual = indice
	var preguntaActual: Pregunta = cola_preguntas[indice]
	$Label.text = preguntaActual.enunciado
	var opciones_mezcladas = preguntaActual.opciones.duplicate()
	var respuesta_correcta = opciones_mezcladas[preguntaActual.indice_correcto]
	opciones_mezcladas.shuffle()
	indiceActual = opciones_mezcladas.find(respuesta_correcta)
	var botones = $BotonesOpciones.get_children()
	for i in range(botones.size()):
		botones[i].text = opciones_mezcladas[i]
		botones[i].disabled = false
		botones[i].visible = true
		var idx = i
		botones[i].pressed.connect(func(): verificar_respuesta(idx), CONNECT_ONE_SHOT)

func verificar_respuesta(indice: int):
	var botones = $BotonesOpciones.get_children()
	for boton in botones:
		boton.disabled = true
		boton.add_theme_stylebox_override("disabled", boton.get_theme_stylebox("normal"))
	if indice == indiceActual:
		botones[indice].modulate = Color.GREEN
		$BotonContinuar.visible = true
		GestorJuego.marcar_pregunta_usada(pais_actual.pais, cola_preguntas[indice_pregunta_actual].enunciado)
	else:
		botones[indice].modulate = Color.RED
		botones[indiceActual].modulate = Color.GREEN

func cincuenta_cincuenta():
	var botones = $BotonesOpciones.get_children()
	var incorrectos = []
	for i in range(botones.size()):
		if i != indiceActual:
			incorrectos.append(i)
	incorrectos.shuffle()
	botones[incorrectos[0]].visible = false
	botones[incorrectos[1]].visible = false

func _on__50_pressed():
	cincuenta_cincuenta()
	print("cincuenta presionado")
	$Boton50.disabled = true

func _on_boton_llamada_pressed() -> void:
	print("llamada usada")
	$BotonLlamada.disabled = true

func _on_boton_continuar_pressed() -> void:
	get_tree().change_scene_to_file("res://Escenas/elegir_pais.tscn")
