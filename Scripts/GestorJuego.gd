extends Node

var preguntas_usadas: Dictionary = {}
var jugadorActual: int = 0
var puntajes: Array[int] = [0, 0]
var correctasConsecutivas: int = 0
var nombres: Array[String] = ["Jugador 1", "Jugador 2"]
var posiciones: Array[int] = [0, 0]
var debe_mover: bool = false
var jugador_que_mueve: int = 0
var usos_cincuenta: Array[int] = [3, 3]
var usos_llamada: Array[int] = [3, 3]
var ganador: int = -1
var colores_jugadores: Array[Color] = [Color(1, 0.3, 0.3), Color(0.3, 0.5, 1)]

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
	debe_mover = true
	jugador_que_mueve = jugadorActual
	if correctasConsecutivas >= 3:
		pasar_turno()

func respuesta_incorrecta():
	pasar_turno()

func pasar_turno():
	jugadorActual = (jugadorActual + 1) % 2
	correctasConsecutivas = 0
	
func reiniciar():
	puntajes = [0, 0]
	posiciones = [0, 0]
	jugadorActual = 0
	correctasConsecutivas = 0
	preguntas_usadas = {}
	ganador = -1
	nombres = ["Jugador 1", "Jugador 2"]
