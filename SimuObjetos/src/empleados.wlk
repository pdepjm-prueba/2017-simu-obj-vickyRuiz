import roles.*
import auxiliares.* 
import tareas.*

class Empleado {
	var estamina
	var rol /* soldado, obrero, mucama */
	var tareas = []
	
	constructor(_estamina, _rol) {
		self.estamina(_estamina)
		rol = _rol
	}
	
	method estamina() = estamina
	method estamina(_estamina) {
		estamina = _estamina
	}
	
	/* PUNTO 1 - Los objetos WKO de las frutas están en auxiliares.wlk*/
	method comerFruta(_fruta) {
		self.estamina(estamina + _fruta.otorgaEstamina())		
	}
	/* PUNTO 2 */
	method experiencia() = tareas.size() * tareas.sum({tarea => tarea.dificultad(self)})
	
	/* PUNTO 3 */	
	method ejecutarTarea(_tarea) {
		if (!_tarea.puedeEjecutarla(self)) {
			throw new Exception("No puede ejecutar esta tarea.")
		}
		_tarea.ejecutarla(self) // o afectar estamina?
		tareas.add(_tarea)
	}
	
	
	
	
	method tieneEstasHerramientas(_herramientasRequeridas) = rol.tieneEstasHerramientas(_herramientasRequeridas)
	method puedeDefender(gradoAmenaza) = rol.puedeDefender() && self.fuerza() >= gradoAmenaza 
	method defenderSector(gradoAmenaza) {
		rol.defenderSector(self)
	}	
	method puedeLimpiar(esSectorGrande) = rol.puedeLimpiar(self, esSectorGrande)
	method limpiarSector(esSectorGrande) {
		rol.limpiarSector(self, esSectorGrande)
	}
	
	method fuerza() = estamina + 2 + rol.danioExtra()

}
class Biclope inherits Empleado {
	override method estamina(_estamina) {
		estamina = _estamina.min(10)
	}
	method dificultadDefender(gradoAmenaza) = gradoAmenaza
}
class Ciclope inherits Empleado {
	override method fuerza() = super() / 2
	method dificultadDefender(gradoAmenaza) = gradoAmenaza * 2
}