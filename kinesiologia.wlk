class Paciente{

  var edad
  var fortalezaMuscular
  var nivelDeDolor
  const property aparatosAsignados=[]

  method nivelDeDolor() =nivelDeDolor
  method fortalezaMuscular() =fortalezaMuscular 
  method edad() =edad  

  method usar(unAparato) {
    if(! self.puedeUsar(unAparato)){
      self.error("no cumple los requisitos para ser usado")
    }
    unAparato.serUsado(self)

  }

  method disminuirDolor(unValor) {
    nivelDeDolor-=unValor
  }

  method fortalecerMusculos(unValor) {
    fortalezaMuscular+= unValor
  }

  method puedeUsar(unAparato) =unAparato.puedeSerUsadoPor(self) 

  method agregarRutina(unAparato){
    aparatosAsignados.add(unAparato)
  }

  method puedeHacerLaRutina() =self.aparatosAsignados().all({a=>a.puedeSerUsadoPor(self)})  

  method realizarSesion() {
    if(self.puedeHacerLaRutina()){
      aparatosAsignados.forEach({a=>a.serUsadoPor(self)})
    }
  }
  

}

class PacienteResistente inherits Paciente {

  override method realizarSesion() {
    super()
    self.fortalecerMusculos(self.aparatosAsignados().size())
  }
  
}

class PacienteCaprichoso inherits Paciente {

  override method puedeHacerLaRutina() =self.aparatosAsignados().all({a=>a.puedeSerUsadoPor(self)}) and self.aparatosAsignados().any({a=> a.color()=="rojo"})

  override method realizarSesion() {
    super()
    super()
  }
  
}

class PacienteDeRecuperacionRapida inherits Paciente{

 override method realizarSesion() {
    super()
    self.disminuirDolor(dolorConfigurable.nivel())
  }


}

object dolorConfigurable {
  
  method nivel() =3 
}


class Aparato {
  var color="blanco"

  method puedeSerUsadoPor(unPaciente) 
  method serUsadoPor(unPaciente)
   
}

class Magneto inherits Aparato{

  var imantacion=800

  override method puedeSerUsadoPor(unPaciente) =true

  override method serUsadoPor(unPaciente){
    unPaciente.disminuirDolor(unPaciente.nivelDeDolor()*0.1)
    imantacion=(imantacion-1).max(0)
  }

  method realizarMantenimiento() {
    imantacion=(imantacion+500).min(800)
  }

  method nesecitaMantenimiento() =imantacion<100 
  
}

class Bicicleta inherits Aparato{

  var cantDesajusteDeTornillos=0
  var vecesQuePerdioAceite=0

  override method puedeSerUsadoPor(unPaciente) =unPaciente.edad()>8

  override method serUsadoPor(unPaciente){
    if(unPaciente.nivelDeDolor()>30){self.desajustarTornillos()}
    if(unPaciente.edad()>29 and unPaciente.edad()<51 ){self.perderAceite()}
    unPaciente.disminuirDolor(4)
    unPaciente.fortalecerMusculos(3)
  }

  method desajustarTornillos() {
    cantDesajusteDeTornillos=cantDesajusteDeTornillos+1
  }

  method perderAceite() {
    vecesQuePerdioAceite=vecesQuePerdioAceite+1
  }

  method realizarMantenimiento() {
    cantDesajusteDeTornillos=10
    vecesQuePerdioAceite=0
  }

  method nesecitaMantenimiento() = cantDesajusteDeTornillos >9 or vecesQuePerdioAceite > 4
  
}



class Minitramp inherits Aparato {

  override method puedeSerUsadoPor(unPaciente) =unPaciente.nivelDeDolor()<20

  override method serUsadoPor(unPaciente){
    unPaciente.fortalecerMusculos(unPaciente.edad()*0.1)
  }

    method realizarMantenimiento() {}

  method nesecitaMantenimiento() = false
  
}


object centro {

  const aparatos=[]
  const pacientes=[]

  method coloresDeLosAparatos() =aparatos.map({a=>a.color()}).asSet()
  method pacientesMenoresDe8() =pacientes.filter({p=> p.edad()<8})
  method cantidadDePacientesQueNoPuedenRealizarSesion() =pacientes.count({p=> !p.puedeHacerLaRutina()})
  method estaEnOptimasCondiciones() = aparatos.all({a=> ! a.nesecitaMantenimiento()})
  method estaComplicado() =aparatos.count({a=> a.nesecitaMantenimiento()}) > (aparatos.size() /2 )
  method visitaDelTecnico() {
    aparatos.filter({a=> a.nesecitaMantenimiento()}).forEach({a=> a.realizarMantenimiento()})
  }


  
}

