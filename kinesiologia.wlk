class Paciente{

  var edad
  var fortalezaMuscular
  var nivelDeDolor

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

  method puedeUsar(unAparato) =unAparato.puedeSerUsado(self) 
  

}


class Aparato {
   
}

class Magneto{

  method puedeSerUsado(unPaciente) =true

  method serUsado(unPaciente){
    unPaciente.disminuirDolor(unPaciente.nivelDeDolor()*0.1)
    
  }
  
}

class Bicicleta{

  method puedeSerUsado(unPaciente) =unPaciente.edad()>8

  method serUsado(unPaciente){
    unPaciente.disminuirDolor(4)
    unPaciente.fortalecerMusculos(3)
  }
  
}

class Minitramp {

  method puedeSerUsado(unPaciente) =unPaciente.nivelDeDolor()<20

  method serUsado(unPaciente){
    unPaciente.fortalecerMusculos(unPaciente.edad()*0.1)
  }
  
}


