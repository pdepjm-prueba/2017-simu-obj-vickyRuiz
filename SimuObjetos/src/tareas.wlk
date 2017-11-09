class ArreglarMaquina {
	var maquina
	
	constructor(_maquina) {
		maquina = _maquina
	}
	
	method puedeEjecutarla(empleado) = empleado.estamina() > maquina.complejidad() && empleado.tieneEstasHerramientas(maquina.herramientasRequeridas())
	method ejecutarla(empleado) {
		empleado.estamina( empleado.estamina() - maquina.complejidad())
	}
	method dificultad(empleado) = maquina.complejidad() * 2	
}

class DefenderSector {
	var gradoAmenaza
	
	constructor (_gradoAmenaza) {
		gradoAmenaza = _gradoAmenaza
	}
	method puedeEjecutarla(empleado) = empleado.puedeDefender(gradoAmenaza)
	method ejecutarla(empleado) {
		empleado.defenderSector(gradoAmenaza)
	} 
	method dificultad(empleado) {
		empleado.dificultadDefender(gradoAmenaza)
	}
}
class LimpiarSector {
	var esSectorGrande
	constructor(_esSectorGrande) {
		esSectorGrande = _esSectorGrande
	}
	method puedeEjecutarla(empleado) = empleado.puedeLimpiar(esSectorGrande)
	method ejecutarla(empleado) {
		empleado.limpiarSector(esSectorGrande)
	}
	method dificultad(empleado) = 10
}

