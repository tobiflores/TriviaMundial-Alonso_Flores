extends Control

func _ready() -> void:
	print("elegir_pais _ready ejecutado")
	$GridContainer/Button6.pressed.connect(_al_clickear_bandera.bind("estadosunidos"))
	$GridContainer/Button.pressed.connect(_al_clickear_bandera.bind("argentina"))
	$GridContainer/Button4.pressed.connect(_al_clickear_bandera.bind("inglaterra"))
	$GridContainer/Button2.pressed.connect(_al_clickear_bandera.bind("francia"))
	$GridContainer/Button3.pressed.connect(_al_clickear_bandera.bind("italia"))
	$GridContainer/Button5.pressed.connect(_al_clickear_bandera.bind("alemania"))

func _al_clickear_bandera(codigo_pais: String):
	var ruta = "res://data/paises/%s.tres" % codigo_pais
	var datos_pais: DatosPais = load(ruta).duplicate(true)
	var pregunta_scene = load("res://Escenas/pregunta.tscn").instantiate()
	pregunta_scene.datos_pais = datos_pais

	get_tree().root.add_child(pregunta_scene)
	get_tree().current_scene.queue_free()
	get_tree().current_scene = pregunta_scene
