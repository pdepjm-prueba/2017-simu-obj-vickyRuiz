/** Acá el código del simulacro */
class Empleado {
	var rol //soldado, obrero, mucama (puede cambiar)
	var estamina
	var sumatoriaDificultades = 0
	var tareasRealizadas = 0
	const dificultadLimpiar = 10
	
	method estamina() = estamina
	method estamina(_estamina) {
		estamina = _estamina
	}
	method fuerza() = estamina/2 + 2 + rol.danioExtra()
	//method tieneHerramientasNecesarias(_herramientas) = rol.tieneHerramientasNecesarias(_herramientas)
	method experienciaPorDefender(gradoAmenaza) = gradoAmenaza
	method defender(_gradoAmenaza) {
		if (rol.puedeDefender() && self.fuerza() >= _gradoAmenaza) {
			estamina -= rol.defenderVariacionEstamina(estamina)
			sumatoriaDificultades += self.experienciaPorDefender(_gradoAmenaza)
			tareasRealizadas++
		} else {
			//que hago acá si no se pudo completar? excepcion?
		}
	} 
	
	method arreglarMaquina(maquina) {
		if(estamina > maquina.complejidad() && rol.tieneHerramientasNecesarias(maquina.herramientasRequeridas()) ) {
			estamina -= maquina.complejidad()
			sumatoriaDificultades += maquina.complejidad() * 2
			tareasRealizadas++ 
		} else {
			//No puede realizar la tarea... entonces?
		}
	}	
	
	method limpiarSector(sectorEsGrande) {
		//dificultadLimpiar = 10
		if (rol.puedeLimpiar(sectorEsGrande, self)) {
			estamina -= rol.limpiarVariacionEstima(sectorEsGrande)
			sumatoriaDificultades += dificultadLimpiar
			tareasRealizadas++
		}
			
	}

	
	method comerFruta(fruta) {
		estamina += fruta.estaminaOtorgada()
	}
	method experiencia() = sumatoriaDificultades * tareasRealizadas
}

object banana {
	method estaminaOtorgada() = 10
}
object manzana {
	method estaminaOtorgada() = 5
}
object uva {
	method estaminaOtorgada() = 1
}
class Biclope inherits Empleado {
	var ojos = 2
	const maxEstamina = 10
	
	override method estamina(_estamina) {
		estamina = _estamina.min(maxEstamina)		
	}
	
}
class Ciclope inherits Empleado {
	var ojos = 1
	
	override method experienciaPorDefender(gradoAmenaza) = gradoAmenaza * 2
	override method fuerza() = super().fuerza() / 2
	
}

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
	var arma
	var practica = 0
	var danioACausar
	
	override method danioExtra() = practica //INterpreto bien la consigna?
	override method defenderVariacionEstamina(estamina) = estamina
	 
	constructor () {
		//practica = 0
	}
}
class Mucama inherits Rol {
	method puedeDefender() = false
	override method puedeLimpiar(sectorEsGrande, empleado) = true 
}
class Obrero inherits Rol {
	var cinturonDeHerramientas = #{} //SET
	
	override method tieneHerramientasNecesarias(_herramientas) = _herramientas.all({herramienta => cinturonDeHerramientas.contains(herramienta)})
	
	
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