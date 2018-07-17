//
//  Memoria.swift
//  Compis
//
//  Created by Juancho Pestana on 4/10/18.
//  Copyright © 2018 Juancho Pestana. All rights reserved.
//

import Foundation

class MemoriaVirtual {
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // DECLARACIONES
    var memoria_local:Memoria = MemoriaLocal()
    var memoria_global:Memoria = MemoriaGlobal()
    var memoria_constante:Memoria = MemoriaConstante()
    var pila_cuadruplos: [Int] = []
    var pila_memoria: [Memoria] = []
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // TRAER VALOR QUE ESTA EN UNA DIRECCION DADA
    func traer_valor(direccion: Int) -> (Any, Tipo) {
        var direccion_dos = direccion
        if direccion < 0 {
            direccion_dos = Main.main_global.memoria_virtual.traer_valor(direccion: -1 * direccion).0 as! Int
        }
        
        if direccion_dos < 120000 {
            return memoria_global.traer_valor(direccion:direccion_dos)
        } else if direccion_dos < 130000 {
            return memoria_local.traer_valor(direccion:direccion_dos)
        } else {
            return memoria_constante.traer_valor(direccion:direccion_dos)
        }
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // PONER VALOR EN UNA DIRECCION ESPECIFICA
    func poner_valor(direccion: Int, resultado: Any) {
        if direccion < 120000 {
            memoria_global.poner_valor(direccion: direccion, resultado:resultado)
        } else if direccion >= 120000 && direccion < 130000 {
            memoria_local.poner_valor(direccion: direccion, resultado:resultado)
        } else {
            memoria_constante.poner_valor(direccion: direccion, resultado:resultado)
        }
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // PONER VALOR DE UN PARAMETRO EN DIRECCION DE MEMORIA
    func poner_valor_parametro(direccion: Int, resultado: Any) {
        var direccion_dos = direccion
        if direccion < 0 {
            direccion_dos = Main.main_global.memoria_virtual.traer_valor(direccion: -1 * direccion).0 as! Int
        }
        
        if direccion_dos < 120000 {
            memoria_global.poner_valor(direccion: direccion_dos, resultado:resultado)
        } else if direccion_dos >= 120000 && direccion_dos < 130000 {
            pila_memoria[pila_memoria.count - 1].poner_valor(direccion: direccion_dos, resultado:resultado)
        } else {
            memoria_constante.poner_valor(direccion: direccion_dos, resultado:resultado)
        }
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
}// END MEMORIA VIRTUAL



class Memoria {
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // DECLARACIONES
    var memoria_INT: [Int?]! = []
    var memoria_FLOAT: [Float?]! = []
    var memoria_STRING: [String?]! = []
    var memoria_BOOL: [Bool?]! = []
    
    var direccion_Inicial_INT = 0
    var direccion_Inicial_FLOAT = 1000
    var direccion_Inicial_STRING = 2000
    var direccion_Inicial_BOOL = 3000
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // INICIALIZADOR
    init() {}
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // TRAER VALOR DE UNA DIRECCION DADA
    func traer_valor(direccion: Int) -> (Any, Tipo) {
        if direccion < direccion_Inicial_FLOAT {
            return (memoria_INT[direccion - direccion_Inicial_INT]! as Int, Tipo.Int)
        } else if direccion < direccion_Inicial_STRING {
            return (memoria_FLOAT[direccion - direccion_Inicial_FLOAT]! as Float, Tipo.Float)
        } else if direccion < direccion_Inicial_BOOL {
            return (memoria_STRING[direccion - direccion_Inicial_STRING]! as String, Tipo.String)
        } else {
            return (memoria_BOOL[direccion - direccion_Inicial_BOOL]! as Bool, Tipo.Bool)
        }
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // INICIALIZAR TODAS LAS DIRECCIONES SUMANDOLES UN VALOR RECIBIDO
    init(valor: Int) {
        direccion_Inicial_INT = valor
        direccion_Inicial_FLOAT += valor
        direccion_Inicial_STRING += valor
        direccion_Inicial_BOOL += valor
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // PONER VALOR EN UNA DIRECCION ESPECIFICA
    func poner_valor(direccion: Int, resultado: Any) {
        var direccion_dos = direccion
        if direccion < 0 {
            direccion_dos = Main.main_global.memoria_virtual.traer_valor(direccion: -1 * direccion).0 as! Int
        }
        if direccion_dos < direccion_Inicial_FLOAT {
            memoria_INT[direccion_dos - direccion_Inicial_INT] = resultado as? Int
        } else if direccion_dos < direccion_Inicial_STRING {
            memoria_FLOAT[direccion_dos - direccion_Inicial_FLOAT] = resultado as? Float
        } else if direccion_dos < direccion_Inicial_BOOL {
            memoria_STRING[direccion_dos - direccion_Inicial_STRING] = resultado as? String
        } else {
            memoria_BOOL[direccion_dos - direccion_Inicial_BOOL] = resultado as? Bool
        }
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // PONER MEMORIA INTS
    func set_memoria_INT(valor: Int?) -> Int {
        memoria_INT.append(valor)
        return direccion_Inicial_INT + memoria_INT.count - 1
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // PONER MEMORIA FLOATS
    func set_memoria_FLOAT(valor: Float?) -> Int {
        memoria_FLOAT.append(valor)
        return direccion_Inicial_FLOAT + memoria_FLOAT.count - 1
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // PONER MEMORIA STRINGS
    func set_memoria_STRING(valor: String?) -> Int {
        memoria_STRING.append(valor)
        return direccion_Inicial_STRING + memoria_STRING.count - 1
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // PONER MEMORIA BOOLS
    func set_memoria_BOOL(valor: Bool?) -> Int {
        memoria_BOOL.append(valor)
        return direccion_Inicial_BOOL + memoria_BOOL.count - 1
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // DUPLICAR MEMORIA PARA LLAMADAS RECURSIVAS
    func duplicar () -> Memoria {
        let duplicar = Memoria()
        duplicar.direccion_Inicial_INT = direccion_Inicial_INT
        duplicar.direccion_Inicial_FLOAT = direccion_Inicial_FLOAT
        duplicar.direccion_Inicial_STRING = direccion_Inicial_STRING
        duplicar.direccion_Inicial_BOOL = direccion_Inicial_BOOL
        
        duplicar.memoria_INT = memoria_INT
        duplicar.memoria_FLOAT = memoria_FLOAT
        duplicar.memoria_STRING = memoria_STRING
        duplicar.memoria_BOOL = memoria_BOOL
        return duplicar
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
   
    
}// END MEMORIA
