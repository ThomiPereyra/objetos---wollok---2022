// Herencia simple
// pruebo commit

class Persona {
	const enfermedades = []
	var temperatura
	var cantidadCelulas
	
	method cantidadCelulas() {
		return cantidadCelulas 
	}
	
	method contraerEnfermedad(unaEnfermedad) {
		enfermedades.add(unaEnfermedad)
	}
	
	method tieneEnfermedad(unaEnfermedad) {
		return enfermedades.contains(unaEnfermedad)
	}
	
	method vivirUnDia() {
		enfermedades.forEach({ enfermedad => enfermedad.afectarA(self) })
	}
	
	method subirTemperatura(unosGrados) {
		temperatura = 45.min(temperatura + unosGrados)
	}
	
	method bajarCantidadCelulas(unaCantidadDeCelulas) {
		cantidadCelulas = 0.max(cantidadCelulas - unaCantidadDeCelulas)
	}
	
	method cantidadDeCelulasAmenazadasPorEnfermedadesAgresivas() {
	  return self.enfermedadesAgresivas().sum({ unaEnfermedad => unaEnfermedad.cantidadCelulasAmenazantes()})
	}
	
	method enfermedadesAgresivas() {
	  return enfermedades.filter({ unaEnfermedad => unaEnfermedad.esAgresivaPara(self) })
	}
	
	method enfermedadMasPeligrosa() {
	  return enfermedades.max({ unaEnfermedad => unaEnfermedad.cantidadCelulasAmenazantes() })
	}
	
	method estaEnComa() {
	  return temperatura == 45 || cantidadCelulas < 1000000
	}
	
	method cantidadDeEnfermedades() {
	  return enfermedades.size()
	}
	
	method tomarMedicamento(unaCantidad) {
	  enfermedades.forEach({ unaEnfermedad => unaEnfermedad.atenuar(unaCantidad) })
	  enfermedades.removeAllSuchThat({ unaEnfermedad => unaEnfermedad.estaCurada() })
	}
}

class Medico inherits Persona {
  var dosis
  
  override method contraerEnfermedad(unaEnfermedad) {
    super(unaEnfermedad)
    self.atenderA(self)
  }
  
  method atenderA(unaPersona) {
    unaPersona.tomarMedicamento(dosis * 15)
  }
}

class JefeDeDepartamento inherits Medico(dosis = 0) {
	const subordinados = #{}
	
	method incluirSubordinado(unSubordinado) {
		subordinados.add(unSubordinado)
	}
	
	override method atenderA(unaPersona) {
		self.delegar(unaPersona)
	}
	
	method delegar(unaPersona) {
		subordinados.anyOne().atenderA(unaPersona)
	}
}

// Method lookup