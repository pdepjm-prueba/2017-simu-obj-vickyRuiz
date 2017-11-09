object banana {
	method otorgaEstamina() = 10  
}
object manzana {
	method otorgaEstamina() = 5  
}
object uva {
	method otorgaEstamina() = 1  
}

/* Hace falta? */
class Maquina {
	var complejidad
	var herramientasRequeridas = #{}
	
	constructor (_complejidad, _herramientasRequeridas) {
		complejidad = _complejidad
		herramientasRequeridas = _herramientasRequeridas
	}
	method complejidad() = complejidad
	method herramientasRequeridas() = herramientasRequeridas
}