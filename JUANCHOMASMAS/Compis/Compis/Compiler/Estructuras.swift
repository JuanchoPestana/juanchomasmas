//
//  Estructuras.swift
//  Compis
//
//  Created by Juancho Pestana on 3/24/18.
//  Copyright © 2018 Juancho Pestana. All rights reserved.
//

import Foundation

///////////////////////////////////////////
///////////////////////////////////////////
// TIPOS POSIBLES
enum Tipo: Int {
    case Int = 0
    case Float = 1
    case String = 2
    case Bool = 3
    case None = 4
    case ERROR = 999
}
// END
///////////////////////////////////////////
///////////////////////////////////////////


///////////////////////////////////////////
///////////////////////////////////////////
// ALCANCE DE LAS VARIABLES
enum Alcance: Int {
    case global = 0
    case local = 1
}
// END
///////////////////////////////////////////
///////////////////////////////////////////


///////////////////////////////////////////
///////////////////////////////////////////
// ESTRUCTURA DE LOS CUADRUPLOS
struct Cuadruplo {
    var operando_izquierdo : Int?
    var operando_derecho : Int?
    var operador: Operador
    var resultado_cuadruplo: Int?
}
// END
///////////////////////////////////////////
///////////////////////////////////////////


///////////////////////////////////////////
///////////////////////////////////////////
// ESTRUCTURA DE LAS VARIABLES
struct Variable {
    var tipo: Tipo!
    var alcance: Alcance!
    var direccion: Int!
    var tamano_arreglo: Int!
    var indice: Int!
}
// END
///////////////////////////////////////////
///////////////////////////////////////////


///////////////////////////////////////////
///////////////////////////////////////////
// OPERADORES
enum Operador: Int, CustomStringConvertible{
    case Suma = 0
    case Resta = 1
    case Multiplicacion = 2
    case Division = 3
    
    case Igual = 4
    case signo_igual = 5
    case Diferente = 6
    case Mayor = 7
    case MayorIgual = 8
    case Menor = 9
    case MenorIgual = 10
    
    case And = 11
    case Or = 12
    case Parentesis = 13
    
    case OUTPUT = 14
    case GOTO = 15
    case GOTOF = 16
    case PARAM = 17
    case ERA = 18
    case GOSUB = 19
    case ENDFUNC = 20
    case RETURN = 21
    case VER = 22
    case END = 23
    
    var description: String {
        switch self {
        case .Suma:
            return "+"
        case .Resta:
            return "-"
        case .Multiplicacion:
            return "*"
        case .Division:
            return "/"
            
            
        case .Igual:
            return "=="
        case .signo_igual:
            return "="
        case .Diferente:
            return "!="
        case .Mayor:
            return ">"
        case .MayorIgual:
            return ">="
        case .Menor:
            return "<"
        case .MenorIgual:
            return "<="
            
            
        case .And:
            return "&&"
        case .Or:
            return "||"
        case .Parentesis:
            return "("
            
        
        case .OUTPUT:
            return "OUTPUT"
        case .GOTO:
            return "GOTO"
        case .GOTOF:
            return "GOTOF"
        case .PARAM:
            return "PARAM"
        case .ERA:
            return "ERA"
        case .GOSUB:
            return "GOSUB"
        case .ENDFUNC:
            return "ENDFUNC"
        case .RETURN:
            return "RETURN"
        case .VER:
            return "VER"
        case .END:
            return "END"
            
        }// END SWITCH
    }// END DESCRIPTION
}
// END
///////////////////////////////////////////
///////////////////////////////////////////


///////////////////////////////////////////
///////////////////////////////////////////
// ESTRUCTURAS DE FUNCION
struct Funcion {
    var tipo_retorno: Tipo!
    var direccion_inicial: Int
    var variables = [String: Variable]()
    var parametros = [String: Variable]()
    var parametro_actual = 0
    var memoria: Memoria!
    
    init(tipo: Tipo, direccion: Int) {
        tipo_retorno = tipo
        direccion_inicial = direccion
        variables = [:]
        parametros = [:]
    }
    
    init(direccion:Int) {
        direccion_inicial = direccion
        variables = [:]
        parametros = [:]
    }
}
// END
///////////////////////////////////////////
///////////////////////////////////////////


///////////////////////////////////////////
///////////////////////////////////////////
// FUNCION PARA CONVERTIR PALABRAS A BOOLEANAS
extension String {
    func convertir_bool() -> Bool? {
        switch self {
        case "TRUE", "True", "true":
            return true
        case "FALSE","False", "false":
            return false
        default:
            return nil
        }
    }
}
// END
///////////////////////////////////////////
///////////////////////////////////////////

