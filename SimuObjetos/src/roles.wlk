class Rol {
	method tieneHerramientasNecesarias(_herramientas) = _herramientas.size() == 0
	method danioExtra() = 0
	method defenderVariacionEstamina(estamina) = estamina/2
	method puedeLimpiar(sectorEsGrande, empleado) = (sectorEsGrande && empleado.estamina() >= 4) || (!sectorEsGrande && empleado.estamina() >= 1)
	method limpiarVariacionEstamina(esGrande) {
		if (esGrande) return 4
		return 1
	}
}
class Soldado inherits Rol {
//	var arma
	var practica = 0
//	var danioACausar
	
	override method danioExtra() = practica //INterpreto bien la consigna?
	override method defenderVariacionEstamina(estamina) = estamina
	//ACA FALTA LA PRACTICA!!

}
class Mucama inherits Rol {
	method puedeDefender() = false
	override method puedeLimpiar(sectorEsGrande, empleado) = true 
}
class Obrero inherits Rol {
	var cinturonDeHerramientas = #{} //SET
	
	override method tieneHerramientasNecesarias(_herramientas) = _herramientas.all({herramienta => cinturonDeHerramientas.contains(herramienta)})
	
	
}
