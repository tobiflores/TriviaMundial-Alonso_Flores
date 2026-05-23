extends Node

var datos_pais: DatosPais = null
var pais_actual: DatosPais
var cola_preguntas: Array[Pregunta] = []
var indiceActual: int = 0

func _ready() -> void:
	iniciar(datos_pais)

func iniciar(datos: DatosPais):
	pais_actual = datos
	cola_preguntas = datos.preguntas.duplicate()
	cola_preguntas.shuffle()
	mostrar_pregunta(0)

func mostrar_pregunta(indice: int):
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
