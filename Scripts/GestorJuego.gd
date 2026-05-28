extends Node

var preguntas_usadas: Dictionary = {}

func marcar_pregunta_usada(pais: String, enunciado: String):
	if not preguntas_usadas.has(pais):
		preguntas_usadas[pais] = []
	preguntas_usadas[pais].append(enunciado)

func preguntaUsada(pais: String, enunciado: String) -> bool:
	if not preguntas_usadas.has(pais):
		return false
	return preguntas_usadas[pais].has(enunciado)
