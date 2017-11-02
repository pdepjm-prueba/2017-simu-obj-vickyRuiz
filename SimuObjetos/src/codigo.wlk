//Consejos: leer todo el parcial + anotar relaciones entre cosas en papel + empezar a trabajar en codigo
//No dejar clases desconectadas en diagrama (ergo en codigo tampoco)
import frutas.*
import roles.* 

class Empleado {
	var rol //soldado, obrero, mucama (puede cambiar)
	var estamina
	var sumatoriaDificultades = 0
	var tareasRealizadas = 0
	const dificultadLimpiar = 10
	
	constructor(_rol, _estamina) {
		rol = _rol
		estamina = _estamina
	}
	
	method estamina() = estamina
	method estamina(_estamina) {
		estamina = _estamina
	}
	method fuerza() = estamina/2 + 2 + rol.danioExtra()
	//method tieneHerramientasNecesarias(_herramientas) = rol.tieneHerramientasNecesarias(_herramientas)
	method experienciaPorDefender(gradoAmenaza) = gradoAmenaza
	method defender(_gradoAmenaza) {
		if (rol.puedeDefender() && self.fuerza() >= _gradoAmenaza) {
			self.estamina(estamina - rol.defenderVariacionEstamina(estamina))
			sumatoriaDificultades += self.experienciaPorDefender(_gradoAmenaza)
			tareasRealizadas++
		} else {
			//que hago acá si no se pudo completar? excepcion?
		}
	} 
	
	method arreglarMaquina(maquina) {
		if(estamina > maquina.complejidad() && rol.tieneHerramientasNecesarias(maquina.herramientasRequeridas()) ) {
			self.estamina(estamina - maquina.complejidad())
			sumatoriaDificultades += maquina.complejidad() * 2
			tareasRealizadas++ 
		} else {
			//No puede realizar la tarea... entonces?
		}
	}	
	
	method limpiarSector(sectorEsGrande) {
		//dificultadLimpiar = 10
		if (rol.puedeLimpiar(sectorEsGrande, self)) {
			self.estamina( estamina - rol.limpiarVariacionEstima(sectorEsGrande))
			sumatoriaDificultades += dificultadLimpiar
			tareasRealizadas++
		} else {
			//no se puede hacer
		}		
	}
	// Punto 1.
	method comerFruta(fruta) {
		estamina += fruta.estaminaOtorgada()
	}
	//Punto 2.
	method experiencia() = sumatoriaDificultades * tareasRealizadas
}

class Biclope inherits Empleado {

	const maxEstamina = 10
	override method estamina(_estamina) {
		estamina = _estamina.min(maxEstamina)		
	}	
}
class Ciclope inherits Empleado {	
	override method experienciaPorDefender(gradoAmenaza) = gradoAmenaza * 2
	override method fuerza() = super().fuerza() / 2
}

class Maquina {
	var complejidad
	var herramientasRequeridas = #{} //SET
	
	constructor (_complejidad, _herramientas) {
		complejidad = _complejidad
		herramientasRequeridas = _herramientas
	} 
	method complejidad() = complejidad
	method herramientasRequeridas() = herramientasRequeridas 		
}