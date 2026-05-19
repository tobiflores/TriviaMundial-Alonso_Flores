extends Node

var pais_actual: DatosPais
var cola_preguntas: Array[Pregunta] = []
var indiceActual: int = 0

func iniciar(datos: DatosPais):
	pais_actual = datos
	cola_preguntas = datos.preguntas.duplicate()
	cola_preguntas.shuffle()
	mostrar_pregunta(0)

func mostrar_pregunta(indice: int):
	var preguntaActual: Pregunta = cola_preguntas[indice]
	$LabelPregunta.text = preguntaActual.enunciado
	var opciones_mezcladas = preguntaActual.opciones.duplicate()
	opciones_mezcladas.shuffle()
	for i in range($BotonesOpciones.get_child_count()):
		$BotonesOpciones.get_child(i).text = opciones_mezcladas[i]
