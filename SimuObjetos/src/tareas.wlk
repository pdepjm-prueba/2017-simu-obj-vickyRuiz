class Tarea {
	method serEjecutadoPor(empleado) {}
	method puedeHacerla(empleado) = true
}
class ArreglarMaquina inherits Tarea {
	var maquina
	//var empleado
	constructor (_maquina) {
		maquina = _maquina
		//empleado = _empleado
	}
	override method puedeHacerla(empleado) = 
		   empleado.estamina() >= maquina.complejidad() 
		&& empleado.tieneHerramientas(maquina.herramientasRequeridas())
	 // && empleado.rol().tieneHerramientasNecesarias(maquina.herramientasRequeridas()) //mal: ROMPE ENCAPSULAMIENTO 
	
	override method serEjecutadoPor(empleado){
		empleado.estamina(empleado.estamina() - maquina.complejidad())
	}
	method dificultad(empleado) = maquina.complejidad() * 2

}
class LimpiarSector inherits Tarea {
	constructor(esGrande, empleado) {} 
	method dificultad(empleado) {}
	/*
	method limpiarSector(sectorEsGrande) {
		//dificultadLimpiar = 10
		if (rol.puedeLimpiar(sectorEsGrande, self)) {
			self.estamina( estamina - rol.limpiarVariacionEstima(sectorEsGrande))
			sumatoriaDificultades += dificultadLimpiar
			tareasRealizadas++
		} else {
			//no se puede hacer
		}		
	}*/
}

class DefenderSector inherits Tarea {
	var gradoAmenaza
	constructor(_gradoAmenaza) {
		gradoAmenaza = _gradoAmenaza
	}
	method dificultad(empleado) = empleado.factorDefensa() * gradoAmenaza
	
	override method puedeHacerla(empleado) = empleado.puedeDefender() && empleado.fuerza() >= _gradoAmenaza  
	
	override method serEjecutadoPor(empleado) {
		empleado.estamina(empleado.estamina() - empleado.rol().defenderVariacionEstamina(empleado.estamina())) //ENCAPUSLAMINEOT???
	}
}