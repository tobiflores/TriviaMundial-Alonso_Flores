extends Node

var preguntas_usadas: Dictionary = {}
var jugadorActual: int = 0
var puntajes: Array[int] = [0, 0]
var correctasConsecutivas: int = 0
var nombres: Array[String] = ["Jugador 1", "Jugador 2"]

func marcar_pregunta_usada(pais: String, enunciado: String):
	if not preguntas_usadas.has(pais):
		preguntas_usadas[pais] = []
	preguntas_usadas[pais].append(enunciado)

func preguntaUsada(pais: String, enunciado: String) -> bool:
	if not preguntas_usadas.has(pais):
		return false
	return preguntas_usadas[pais].has(enunciado)

func respuesta_correcta():
	puntajes[jugadorActual] += 1
	correctasConsecutivas += 1
	if correctasConsecutivas >= 3:
		pasar_turno()

func respuesta_incorrecta():
	pasar_turno()

func pasar_turno():
	jugadorActual = (jugadorActual + 1) % 2
	correctasConsecutivas = 0
