func _al_clickear_bandera(codigo_pais: String):
	var ruta = "res://data/paises/%s.tres" % codigo_pais
	var datos_pais: DatosPais = load(ruta).duplicate(true)
