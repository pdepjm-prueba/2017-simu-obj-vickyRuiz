class Rol {
	method tieneEstasHerramientas(_herramientasRequeridas) = _herramientasRequeridas.isEmpty()
	method puedeDefender() = true
	method danioExtra() = 0
	
	method ejecutarTarea(tarea, empleado) {
		tarea.ejecutarla(empleado)
		empleado.agregarTarea(tarea)
	}
	/*method arreglarMaquina(empleado, maquina, tarea) {
		empleado.estamina( empleado.estamina() - maquina.complejidad())
	}*/
	method defenderSector(empleado) {
		empleado.estamina(empleado.estamina() / 2)
	}
	method puedeLimpiar(empleado, esSectorGrande) = empleado.estamina() >= self.estaminaRequeridaParaLimpiar(esSectorGrande)
	method limpiarSector(empleado, esSectorGrande) {
		empleado.estamina( empleado.estamina() - self.estaminaRequeridaParaLimpiar(esSectorGrande))		
	} 
	method estaminaRequeridaParaLimpiar(esSectorGrande) {
		if (esSectorGrande) return 4
		return 1
	}
	method puedeArreglarMaquina(empleado, maquina, tarea) = empleado.estamina() > maquina.complejidad() && empleado.tieneEstasHerramientas(maquina.herramientasRequeridas())
}

class Soldado inherits Rol {
	var danioQueCausa = 0 /* empieza en 0, se pierde cuando cambia de rol */
	override method danioExtra() = danioQueCausa * 3
	override method defenderSector(empleado) {
		danioQueCausa += 2
	}
	
}
class Obrero inherits Rol {
	var herramientas = #{}
	constructor (_herramientas) {
		herramientas = _herramientas
	}
	override method tieneEstasHerramientas(_herramientasRequeridas) = _herramientasRequeridas.all({herramienta => herramientas.contains(herramienta)}) 
}
class Mucama inherits Rol {
	override method puedeDefender() = false
	override method estaminaRequeridaParaLimpiar(esSectorGrande) = 0
	override method limpiarSector(empleado, esSectorGrande) {}
	override method puedeLimpiar(empleado, esSectorGrande) = true
}

//Punto 4. 
class Capataz inherits Rol {
	var subordinados = #{}
	
	constructor(_subordinados){subordinados = _subordinados}
	
	 
	
	override method puedeArreglarMaquina(empleado, maquina, tarea) =
		self.quienMasPuedeArreglarMaquina(maquina).isEmpty() && not super(empleado,maquina, tarea) 
			
	method quienMasPuedeArreglarMaquina(maquina) =
		subordinados.filter({subordinado => subordinado.puedeArreglarMaquina()}).max({subordinado => subordinado.experiencia()})
	
	method subordinadoIdoneo(accion) {
		return subordinados.filter({subordinado => subordinado.apply({accion})}).max({subordinado => subordinado.experiencia()})
	}
	method ejecutarTarea(tarea, empleado) {
		if (self.subordinadoIdoneo(tarea.accion()).isEmpty)
		tarea.ejecutarla(empleado)
		empleado.agregarTarea(tarea)
	}
		
	override method arreglarMaquina(empleado, maquina, tarea) {
		var ejecutor = self.quienMasPuedeArreglarMaquina(maquina)
		if (ejecutor.isEmpty()) { ejecutor = empleado } /* para esta altura ya se chequeo que pueda (el o sus subordinados) arreglar la maquina */
		ejecutor.ejecutarTarea(tarea)
	}		
}