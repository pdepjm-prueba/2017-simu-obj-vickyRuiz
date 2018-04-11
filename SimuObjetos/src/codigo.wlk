//Consejos: leer todo el parcial + anotar relaciones entre cosas en papel + empezar a trabajar en codigo
//No dejar clases desconectadas en diagrama (ergo en codigo tampoco)
//los wko se representan, pero no las instancias de clase
//solo va a haber 3 tests, uno con una excepcion seguramente!
//No romper encapsulamiento de objetos
//No pensar demasiado en los errores, avanzar y demostrar lo que sabemos

import frutas.*
import roles.* 

//Nuevo comentario - Esto es un cambio!

class Empleado {
	var rol //soldado, obrero, mucama (puede cambiar)
	var estamina

	var tareasRealizadas = []
	
	const dificultadLimpiar = 10
	
	constructor(_rol, _estamina) {
		rol = _rol
		estamina = _estamina
	}
	
	method estamina() = estamina
	method estamina(_estamina) {
		estamina = _estamina
	}
	method factorDefensa() = 1
	
	method fuerza() = estamina/2 + 2 + rol.danioExtra()
	
	//method tieneHerramientasNecesarias(_herramientas) = rol.tieneHerramientasNecesarias(_herramientas)
	method experienciaPorDefender(gradoAmenaza) = gradoAmenaza
	 
	method tieneHerramientas(herramientasNecesarias) {
		rol.tieneHerramientasNecesarias(herramientasNecesarias)
	}
	method puedeDefender() = rol.puedeDefender()
	
	method hacerTarea(tarea) {
		if (not tarea.puedeHacerla(self)) {
			throw error
		}
		tareasRealizadas.add(tarea)
		tarea.serEjecutadaPor(self)
		
	}
		
	// Punto 1.
	method comerFruta(fruta) {
		estamina += fruta.estaminaOtorgada()
	}
	//Punto 2.
	method experiencia() = tareasRealizadas.size() * tareasRealizadas.sum({tarea => tarea.dificultad()})
}

class Biclope inherits Empleado {
	const maxEstamina = 10
	override method estamina(_estamina) {
		estamina = _estamina.min(maxEstamina)		
	}	
	
}
class Ciclope inherits Empleado {
	override method factorDefensa() = 2
		
	override method experienciaPorDefender(gradoAmenaza) = gradoAmenaza * 2
	override method fuerza() = super()/ 2 //No necesito agregar super().fuerza()
	
	
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