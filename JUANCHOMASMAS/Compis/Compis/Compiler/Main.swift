//
//  Main.swift
//  Compis
//
//  Created by Juancho Pestana on 3/28/18.
//  Copyright © 2018 Juancho Pestana. All rights reserved.
//

import UIKit


@objc class Main: NSObject{
    static var main_global = Main()
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // DECLARACIONES
    var tabla_funciones = [String:Funcion]()
    var funcion_actual: String = "programa"
    var operadores: [Operador] = []
    var tipos_ids: [Tipo] = []
    var direcciones_ids: [Int] = []
    var llamada_funcion: [String] = []
    var arreglo_pendiente: [Int] = []
    var valores_retorno: [Int] = []
    let memoria_virtual = MemoriaVirtual()
    var cubo_semantico: NSDictionary?
    var cuadruplos: [Cuadruplo] = []
    var cuadruplos_pendientes: [Int] = []
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // CUBO SEMANTICO
    override init(){
        cubo_semantico = [
            "+" : [
                [000,001,999,999],
                [001,001,999,999],
                [999,999,999,999],
                [999,999,999,999]
            ],
            "-" : [
                [000,001,999,999],
                [001,001,999,999],
                [999,999,999,999],
                [999,999,999,999]
            ],
            "*" : [
                [000,001,999,999],
                [001,001,999,999],
                [999,999,999,999],
                [999,999,999,999]
            ],
            "/" : [
                [001,001,999,999],
                [001,001,999,999],
                [999,999,999,999],
                [999,999,999,999]
            ],
            "=" : [
                [000,999,999,999],
                [999,001,999,999],
                [999,999,002,999],
                [999,999,999,003]
            ],
            "!=" : [
                [003,999,999,999],
                [999,003,999,999],
                [999,999,003,999],
                [999,999,999,003]
            ],
            "==" : [
                [003,999,999,999],
                [999,003,999,999],
                [999,999,003,999],
                [999,999,999,003]
            ],
            ">" : [
                [003,003,999,999],
                [003,003,999,999],
                [999,999,999,999],
                [999,999,999,999]
            ],
            "<" : [
                [003,003,999,999],
                [003,003,999,999],
                [999,999,999,999],
                [999,999,999,999]
            ],
            ">=" : [
                [003,003,999,999],
                [003,003,999,999],
                [999,999,999,999],
                [999,999,999,999]
            ],
            "<=" : [
                [003,003,999,999],
                [003,003,999,999],
                [999,999,999,999],
                [999,999,999,999]
            ],
            "&&" : [
                [999,999,999,999],
                [999,999,999,999],
                [999,999,999,999],
                [999,999,999,003]
            ],
            "||" : [
                [999,999,999,999],
                [999,999,999,999],
                [999,999,999,999],
                [999,999,999,003]
            ]
            
        ]
        // END CUBO SEMANTICO
        ///////////////////////////////////////////
        ///////////////////////////////////////////
        
        
    }// END
    
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // VERIFICAR SI YA EXISTE LA FUNCION EN TABLA DE FUNCIONES
    func verificar_funcion_existe(_ id: String) -> Bool{
        return tabla_funciones[id] != nil ? true : false
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // AGREGAR FUNCION A TABLA DE FUNCIONES
    func agregar_funcion(_ id: String, tipo: String) -> Bool {
        if verificar_funcion_existe(id) {
            return false
        }
        
        funcion_actual = tipo
        tabla_funciones[funcion_actual] = Funcion(tipo: string_a_tipo(tipo: tipo), direccion: cuadruplos.count)
        
        return true
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // AGREGAR EL TIPO DE RETORNO A LA FUNCION
    func agregar_tipo_retorno_funcion(_ id: String, tipo: String) {
        tabla_funciones[id]?.tipo_retorno = string_a_tipo(tipo: tipo)
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // AGREGAR FUNCION A TABLA DE FUNCIONES
    func agregar_funcion_2(_ id: String) {
        tabla_funciones[id] = Funcion(direccion: cuadruplos.count)
        funcion_actual = id
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // VERIFICAR SI YA EXISTE VARIABLE EN TABLA DE VARIABLES PARA EVITAR DUPLICADAS
    func verificar_variable_existe(_ id: String) -> Bool {
        if tabla_funciones[funcion_actual]?.variables[id] != nil {
            return true
        }
        else if tabla_funciones["Programa"]?.variables[id] != nil {
            return true
        }
        else if tabla_funciones[funcion_actual]?.parametros[id] != nil {
            return true
        }
        
        return false
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // AGREGAR VARIABLE A TABLA DE VARIABLES
    func agregar_variable(_ id: String, tipo:String, parametro:Bool) {
        
        let direccion = crear_direcciones_variables(tipo: tipo)
        var alcance: Alcance = .global
        
        if funcion_actual == "Programa" {
            alcance = .global
        }else{
            alcance = .local
        }
        
        let tipo = string_a_tipo(tipo: tipo)
        if parametro {
            
            tabla_funciones[funcion_actual]?.parametros[id] = Variable(tipo: tipo, alcance: alcance, direccion: direccion, tamano_arreglo: nil, indice: tabla_funciones[funcion_actual]?.parametros.count)
        } else {
            tabla_funciones[funcion_actual]?.variables[id] = Variable(tipo: tipo, alcance: alcance, direccion: direccion,  tamano_arreglo: nil, indice: nil)
        }
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // VERIFICAR SI EL PARAMETRO EXISTE EN TABLA DE VARIABLES
    func verificar_parametro_existe(_ id: String) -> Bool{
        if tabla_funciones[funcion_actual]?.parametros[id] != nil {
            return true
        }
        else if tabla_funciones["programa"]?.variables[id] != nil {
            return true
        }
        return false
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // AGREGAR ARREGLO A TABLA DE VARIABLES
    func agregar_arreglo(_ id: String, tipo: String, tamano:Int) {
        agregar_variable(id, tipo: tipo, parametro: false)
        tabla_funciones[funcion_actual]?.variables[id]?.tamano_arreglo = tamano
      
        for _ in 0...tamano-1 {
            _ = crear_direcciones_variables(tipo:tipo)
        }
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    //  CREAR LAS DIRECCIONES EN MEMORIA PARA LAS VARIABLES   *** CREO QUE AQUI NO HACE FALTA MANDAR UN VALOR
    func crear_direcciones_variables(tipo:String) -> Int {
        var alcance: Alcance = .global
        var direccion = 0
        if funcion_actual == "Programa" {
            alcance = .global
        }else{
            alcance = .local
        }
        
        switch tipo {
        case "Int":
            if alcance == .global {
                direccion = memoria_virtual.memoria_global.set_memoria_INT(valor: 10000)
            } else {
                direccion = memoria_virtual.memoria_local.set_memoria_INT(valor: 10000)
            }
        case "Float":
            if alcance == .global {
                direccion = memoria_virtual.memoria_global.set_memoria_FLOAT(valor: 10000.0)
            } else {
                direccion = memoria_virtual.memoria_local.set_memoria_FLOAT(valor: 10000.0)
            }
        case "Bool":
            if alcance == .global {
                direccion = memoria_virtual.memoria_global.set_memoria_BOOL(valor: false)
            } else {
                direccion = memoria_virtual.memoria_local.set_memoria_BOOL(valor: false)
            }
        default:
            if alcance == .global {
                direccion = memoria_virtual.memoria_global.set_memoria_STRING(valor: "")
            } else {
                direccion = memoria_virtual.memoria_local.set_memoria_STRING(valor: "")
            }
        }
        
        return direccion
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // TRAER DIRECCION INICIAL DE LA FUNCION
    func traer_direccion_inicio_funcion(id: String) -> Int {
        let funcion = tabla_funciones[id]
        
        if funcion != nil{
           return funcion!.direccion_inicial
        }else{
            return -1
        }
        
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // TRAER EL NOMBRE DE LA FUNCION DADA UNA DIRECCION
    func traer_nombre_funcion(direccion: Int) -> String {
        for funcion in tabla_funciones {
            if funcion.value.direccion_inicial == direccion {
                return funcion.key
            }
        }
        
        return "ERROR"
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // TRAER EL TIPO DE VARIABLE DADO EL NOMBRE DE LA MISMA
    func traer_tipo_variable(_ id:String) -> Tipo {
        if tabla_funciones[funcion_actual]?.variables[id] != nil {
            return (tabla_funciones[funcion_actual]?.variables[id]?.tipo)!
        }
        else if tabla_funciones[funcion_actual]?.parametros[id] != nil {
            return (tabla_funciones[funcion_actual]?.parametros[id]?.tipo)!
        }
        else if tabla_funciones["Programa"]?.variables[id] != nil {
            return (tabla_funciones["Programa"]?.variables[id]?.tipo)!
        }
        return Tipo.ERROR
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // TRAER EL TIPO Y LA DIRECCION DE UN PARAMETRO DADO EL NOMBRE DE LA FUNCION Y EL INDICE DEL PARAMETRO
    func traer_tipo_direccion_parametro(indice: Int, funcion: String) -> (Tipo, Int) {
        for parametro in (tabla_funciones[funcion]?.parametros)! {
            if parametro.value.indice == indice {
                return (parametro.value.tipo, parametro.value.direccion)
            }
        }
        return (Tipo.ERROR, -1)
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // TRAER LA DIRECCION DE UNA VARIABLE DADO EL NOMBRE DE LA MISMA
    func traer_direccion_variable(id: String) -> Int {
        if let variable = tabla_funciones[funcion_actual]?.variables[id] {
            return variable.direccion
        }
        if let variable = tabla_funciones[funcion_actual]?.parametros[id] {
            return variable.direccion
        }
        if let variable = tabla_funciones["Programa"]?.variables[id] {
            return variable.direccion
        }
        
        return -1
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // TRAER SIGUIENTE OPERADOR DE LA PILA DE OPERADORES
    func traer_siguiente_operador() -> String {

        if !(operadores.count > 0){
            return "NO HAY"
        }
        
        if (operadores[operadores.count - 1] == Operador.Parentesis){
            return "NO HAY"
        }
        return operadores[operadores.count-1].description
        
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////

    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // TRAER EL TAMANO DE UN ARREGLO DADA SU DIRECCION
    func traer_tamano_arreglo(direccion: Int) -> Int {
        
        for arreglo in (tabla_funciones[funcion_actual]?.variables)! {
            if arreglo.value.direccion == direccion{
                return (arreglo.value.tamano_arreglo)
            }
        }
        
        for arreglo in (tabla_funciones["Programa"]?.variables)! {
            if arreglo.value.direccion == direccion{
                return (arreglo.value.tamano_arreglo)
            }
        }
        return -1
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // IMPRIMIR TABLA DE FUNCIONES
    func imprimir_tabla_funciones() {
        print(tabla_funciones)
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // IMPRIMIR CUADRUPLOS
    func imprimir_cuadruplos() {
        var indice = 0;
        for cuadruplo in cuadruplos {
            print(String(indice), terminator:" ")
            print(cuadruplo)
            indice += 1
        }
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // CONVERTIR EL SIMBOLO DE LA OPERACION A TIPO OPERADOR
    func string_a_operador(operador: String) -> Operador {
        
        switch operador {
        case "+":
            return Operador.Suma
        case "-":
            return Operador.Resta
        case "*":
            return Operador.Multiplicacion
        case "/":
            return Operador.Division
        case ">":
            return Operador.Mayor
        case ">=":
            return Operador.MayorIgual
        case "<":
            return Operador.Menor
        case "<=":
            return Operador.MenorIgual
        case "=":
            return Operador.signo_igual
        case "==":
            return Operador.Igual
        case "!=":
            return Operador.Diferente
        case "&&":
            return Operador.And
        case "||":
            return Operador.Or
        default:
            return Operador.Parentesis
        }
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // CONVERTIR PALABRAS RECIBIDAS A TIPO
    func string_a_tipo(tipo: String) -> Tipo {
        
        switch tipo.lowercased() {
        case "string":
            return .String
        case "int":
            return .Int
        case "float":
            return .Float
        case "bool":
            return .Bool
        case "void":
            return .None
        default:
            return .None
        }
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // REINICIAR VARIABLE GLOBAL DE TIPO MAIN PARA CADA NUEVA EJECUCION DE UN PROGRAMA
    func reiniciar() {
        Main.main_global = Main()
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // AGREGA ID CON TIPO A PILA DE OPERACIONES
    func push_direccion_id(_ nombre: String, tipo: String) {
        if verificar_variable_existe(nombre){
            direcciones_ids.append(traer_direccion_variable(id: nombre))
            tipos_ids.append(traer_tipo_variable(nombre))
        } else {
            switch tipo.lowercased() {
            case "int":
                let direccion = memoria_virtual.memoria_constante.set_memoria_INT(valor: Int(nombre)!)
                direcciones_ids.append(direccion)
                tipos_ids.append(Tipo.Int)
            case "float":
                let direccion = memoria_virtual.memoria_constante.set_memoria_FLOAT(valor: Float(nombre)!)
                direcciones_ids.append(direccion)
                tipos_ids.append(Tipo.Float)
            case "string":
                var valor = nombre
                valor = String(valor.dropLast())
                valor = String(valor.dropFirst())
                let direccion = memoria_virtual.memoria_constante.set_memoria_STRING(valor: valor)
                direcciones_ids.append(direccion)
                tipos_ids.append(Tipo.String)
            case "bool":
                let direccion = memoria_virtual.memoria_constante.set_memoria_BOOL(valor: nombre.convertir_bool())
                direcciones_ids.append(direccion)
                tipos_ids.append(Tipo.Bool)
            default:
                break
            }
        }
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // AGREGA OPERADOR A PILA DE OPERACIONES
    func push_operador(_ operador: String) {
        operadores.append(string_a_operador(operador: operador))
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // SACAR PARENTESIS DE PILA DE OPERACIONES
    func pop_parentesis() {

        if (operadores[operadores.count - 1] == Operador.Parentesis) {
        return
        }
        operadores.removeLast()
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    //  GENERAR CUADRUPLOS
    func generar_cuadruplo() -> Bool {
        let tipo_operando_derecho = tipos_ids.popLast()
        let tipo_operando_izquierdo = tipos_ids.popLast()
        let operando_derecho = direcciones_ids.popLast()
        let operando_izquierdo = direcciones_ids.popLast()
        let operador = operadores.popLast()
        
        let arreglo_oper = cubo_semantico!.value(forKey: (operador?.description)!) as! [[Int]]
        let tipo_resultado = Tipo(rawValue: arreglo_oper[(tipo_operando_izquierdo?.rawValue)!][(tipo_operando_derecho?.rawValue)!])
        
        if tipo_resultado == .ERROR{
            print("ERROR")
            return false
        }
        
        var direccion_resultado = 0
        
        switch tipo_resultado! {
        case .Int:
            direccion_resultado =  memoria_virtual.memoria_local.set_memoria_INT(valor: 10000)
            cuadruplos.append(Cuadruplo(operando_izquierdo: operando_izquierdo!, operando_derecho: operando_derecho, operador: operador!, resultado_cuadruplo: direccion_resultado))
        case .Float:
            direccion_resultado = memoria_virtual.memoria_local.set_memoria_FLOAT(valor: 10000.0)
            cuadruplos.append(Cuadruplo(operando_izquierdo: operando_izquierdo!, operando_derecho: operando_derecho, operador: operador!, resultado_cuadruplo: direccion_resultado))
        case .String:
            direccion_resultado = memoria_virtual.memoria_local.set_memoria_STRING(valor: "")
            cuadruplos.append(Cuadruplo(operando_izquierdo: operando_izquierdo!, operando_derecho: operando_derecho, operador: operador!, resultado_cuadruplo: direccion_resultado))
        case .Bool:
            direccion_resultado = memoria_virtual.memoria_local.set_memoria_BOOL(valor: false)
            cuadruplos.append(Cuadruplo(operando_izquierdo: operando_izquierdo!, operando_derecho: operando_derecho, operador: operador!, resultado_cuadruplo: direccion_resultado))
        default:
            return false
        }
        
        direcciones_ids.append(direccion_resultado)
        tipos_ids.append(tipo_resultado!)
//        imprimir_cuadruplos()
        return true
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // GENERAR CUADRUPLO ASIGNACION
    func generar_cuadruplo_asignacion() -> Bool {
        let operador = operadores.popLast()
        let tipo_temporal = tipos_ids.popLast()
        let variable_temporal = direcciones_ids.popLast()
        let resultado_cuadruplo = direcciones_ids.popLast()
        let tipo_resultado = tipos_ids.popLast()
        
        if tipo_temporal != tipo_resultado{
            return false
        }
        
        cuadruplos.append(Cuadruplo(operando_izquierdo: variable_temporal, operando_derecho: nil, operador: operador!, resultado_cuadruplo: resultado_cuadruplo!))
//        imprimir_cuadruplos()
        return true
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // GENERAR CUADRUPLO GOTOF
    func generar_cuadruplo_GOTOF(_ codigo:Int) {
        
        let direccion_variables_temporales = direcciones_ids.popLast()
        let tipo_temporal = tipos_ids.popLast()
        
        if tipo_temporal != Tipo.Bool{
            print("ERROR")
            return
        }
        
        cuadruplos.append(Cuadruplo(operando_izquierdo: direccion_variables_temporales, operando_derecho: nil, operador: Operador.GOTOF, resultado_cuadruplo: 100000))
        
        cuadruplos_pendientes.append(cuadruplos.count - 1)
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // GENERAR CUADRUPLO GOTO
    func generar_cuadruplo_GOTO(_ codigo:Int) {
        
        if let ulti = cuadruplos_pendientes.popLast() {
             cuadruplos[ulti].resultado_cuadruplo = cuadruplos.count + 1
        }
       
        cuadruplos.append(Cuadruplo(operando_izquierdo: nil, operando_derecho: nil, operador: Operador.GOTO, resultado_cuadruplo: 100000))
        
        if codigo != 99 {
            let indice_pendiente = cuadruplos.count
            cuadruplos_pendientes.append(indice_pendiente - 1)
        }
        
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // GENERAR CUADRUPLO OUTPUT
    func generar_cuadruplo_OUTPUT(_ id:String) {
        let direccion_variable = direcciones_ids.popLast()
        _ = tipos_ids.popLast()
        
        cuadruplos.append(Cuadruplo(operando_izquierdo: nil, operando_derecho: nil, operador: Operador(rawValue: 14)!, resultado_cuadruplo: direccion_variable))
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // GENERAR CUADRUPLO CONDICION WHILE
    func generar_cuadruplo_condicion_WHILE() {
        cuadruplos_pendientes.append(cuadruplos.count - 1)
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // RELLENAR CUADRUPLO DEL WHILE
    func rellenar_cuadruplo_end_ciclo() {
        // Step 2 end = pjumps.pop()
        let ulti = cuadruplos_pendientes.popLast()
        
        if let siguiente = cuadruplos_pendientes.popLast() {
            cuadruplos[ulti!].resultado_cuadruplo = siguiente + 1
        }
        
        imprimir_cuadruplos()
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // GENERAR CUADRUPLO ERA
    func generar_cuadruplo_ERA(_ nombre: String) {
        let cuadruplo_inicio_funcion = traer_direccion_inicio_funcion(id: nombre)
        
        if cuadruplo_inicio_funcion <= 0 {
            print("ERROR")
            return
        }
        
        cuadruplos.append(Cuadruplo(operando_izquierdo: cuadruplo_inicio_funcion, operando_derecho: nil, operador: Operador(rawValue: 18)!, resultado_cuadruplo: nil))
        llamada_funcion.append(nombre)
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // GENERAR CUADRUPLO END OF FUNCTION
    func generar_cuadruplo_end_of_function() {
        if funcion_actual != "main" {
            cuadruplos.append(Cuadruplo(operando_izquierdo: nil, operando_derecho: nil, operador: Operador(rawValue: 20)!, resultado_cuadruplo: nil))
        }
        
        tabla_funciones[funcion_actual]?.memoria = memoria_virtual.memoria_local
        memoria_virtual.memoria_local = Memoria(valor: memoria_virtual.memoria_local.direccion_Inicial_INT)
//        imprimir_cuadruplos()
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // GENERAR CUADRUPLO GOSUB
    func generar_cuadruplo_GOSUB() {
        let nombre_funcion = llamada_funcion.popLast()
        let direccion_funcion: Int = traer_direccion_inicio_funcion(id: nombre_funcion!)
        
        cuadruplos.append(Cuadruplo(operando_izquierdo: direccion_funcion, operando_derecho: nil, operador: Operador(rawValue: 19)!, resultado_cuadruplo: nil))
        tabla_funciones[nombre_funcion!]?.parametro_actual = 0
        
        if (tabla_funciones[nombre_funcion!]?.tipo_retorno)! != Tipo.None {
            let direccion_retorno = valores_retorno.popLast()
            direcciones_ids.append(direccion_retorno!)
            tipos_ids.append((tabla_funciones[nombre_funcion!]?.tipo_retorno)!)
        }
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // GENERAR CUADRUPLO PARAMETRO
    func generar_cuadruplo_parametro() -> Bool {
        let direccion_argumento = direcciones_ids.popLast()
        let tipo_argumento = tipos_ids.popLast()
        let nombre_funcion = llamada_funcion[llamada_funcion.count - 1]
        let indice_parametro = tabla_funciones[nombre_funcion]?.parametro_actual
        let tupla_parametro = traer_tipo_direccion_parametro(indice: indice_parametro!, funcion: nombre_funcion)
        
        if tupla_parametro.0 == .ERROR{
            print("ERROR")
            return false
        }
        
        let tipo_parametro = tupla_parametro.0
        let direccion_parametro = tupla_parametro.1
        
        if tipo_argumento != tipo_parametro {
            print("ERROR")
            return false
        }
        
        cuadruplos.append(Cuadruplo(operando_izquierdo: direccion_argumento, operando_derecho: nil, operador: Operador(rawValue: 17)!, resultado_cuadruplo: direccion_parametro))
        
        tabla_funciones[funcion_actual]?.parametro_actual += 1
        
        return true
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // GENERAR CUADRUPLO RETORNO
    func generar_cuadruplo_retorno() -> Bool{
        
        if tabla_funciones[funcion_actual]?.tipo_retorno == Tipo.None {
            print("ERROR")
            return false
        }
        
        let tipo_popeado = tipos_ids.popLast()
        let direccion_popeada = direcciones_ids.popLast()
        
        
        if tabla_funciones[funcion_actual]?.tipo_retorno != tipo_popeado {
            print("ERROR")
            return false
        }
        
        cuadruplos.append(Cuadruplo(operando_izquierdo: nil, operando_derecho: nil, operador: Operador(rawValue: 21)!, resultado_cuadruplo: direccion_popeada))
        valores_retorno.append(direccion_popeada!)
        return true
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // GENERAR CUADRUPLO VOID
    func generar_cuadruplo_retorno_VOID() -> Bool {
        
        if tabla_funciones[funcion_actual]?.tipo_retorno != Tipo.None {
            print("ERROR");
            return false
        }
        
        cuadruplos.append(Cuadruplo(operando_izquierdo: nil, operando_derecho: nil, operador: Operador(rawValue: 21)!, resultado_cuadruplo: nil))
        return true
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // RELLENAR CUADRUPLO DE CONDICION
    func rellenar_condicion_end_cuadruplo() {

        let ulti = cuadruplos_pendientes.popLast()
        
        let siguiente_cuadruplo = cuadruplos.count
        cuadruplos[ulti!].resultado_cuadruplo = siguiente_cuadruplo
        
//        imprimir_cuadruplos()
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // VERIFICAR QUE EXISTA ARREGLO Y METERLO A PILA DE ARREGLOS PENDIENTES
    func verificar_si_arreglo() -> Bool {
        
        let direccion_arreglo = direcciones_ids.popLast()
        let tamano = traer_tamano_arreglo(direccion: direccion_arreglo!)
        
        if tamano > 0 {
            arreglo_pendiente.append(direccion_arreglo!)
            return true
        }
        return false
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // VERIFICAR QUE ARREGLO NO SALGA DE SU TAMANO
    func verificar_rango_expresion_arreglo() -> Void {
        
        let tamano = direcciones_ids[direcciones_ids.count-1]
        let arr = arreglo_pendiente[arreglo_pendiente.count-1]
        let tamano_arreglo = traer_tamano_arreglo(direccion: arr)
        
        cuadruplos.append(Cuadruplo(operando_izquierdo: tamano_arreglo, operando_derecho: 0, operador: .VER, resultado_cuadruplo: tamano))
//        imprimir_cuadruplos()
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // AGREGAR GAP A DIRECCION BASE
    func agregar_gap_a_direccion_base() -> Bool {
        
        let dir_arr_base = arreglo_pendiente.popLast()
        let gap = direcciones_ids.popLast()
        let tipo_gap = tipos_ids.popLast()
        
        if tipo_gap != Tipo.Int{
            print("ERROR")
            return false
        }
        
        let direccion_arreglo_target = memoria_virtual.memoria_local.set_memoria_INT(valor: 100000)
        
        direcciones_ids.append(-1 * direccion_arreglo_target)
        cuadruplos.append(Cuadruplo(operando_izquierdo: gap, operando_derecho: -1 * dir_arr_base!, operador: .Suma, resultado_cuadruplo: direccion_arreglo_target))
        
        return true
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // GENERAR CUADRUPLO END OF PROGRAM
    func generar_cuadruplo_end_of_program() {
        
        cuadruplos.append(Cuadruplo(operando_izquierdo: nil, operando_derecho: nil, operador: Operador(rawValue: 23)!, resultado_cuadruplo: nil))
        cuadruplos[0].resultado_cuadruplo = tabla_funciones["main"]?.direccion_inicial
        imprimir_cuadruplos()
        memoria_virtual.pila_memoria.append((tabla_funciones["main"]?.memoria)!)
        memoria_virtual.memoria_local = memoria_virtual.pila_memoria.popLast()!
        ejecutar(cuadruplos: cuadruplos)
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    

    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // MAQUINA VIRTUAL
    func ejecutar(cuadruplos: [Cuadruplo]) {
        var numero_cuadruplo = 0
        
        while numero_cuadruplo < cuadruplos.count{
            let cuadruplo = cuadruplos[numero_cuadruplo]
            
            switch cuadruplo.operador {
                
                ///////////////////////////////////////////
                ///////////////////////////////////////////
                //
                case .Suma:
                ejecutar_suma(direccion_izquierda: cuadruplo.operando_izquierdo!, direccion_derecha: cuadruplo.operando_derecho!, direccion_resultado: cuadruplo.resultado_cuadruplo!)
                break
                // END
                ///////////////////////////////////////////
                ///////////////////////////////////////////
                
                
                
                ///////////////////////////////////////////
                ///////////////////////////////////////////
                //
                case .Resta:
                ejecutar_resta(direccion_izquierda: cuadruplo.operando_izquierdo!, direccion_derecha: cuadruplo.operando_derecho!, direccion_resultado: cuadruplo.resultado_cuadruplo!)
                break
                // END
                ///////////////////////////////////////////
                ///////////////////////////////////////////
                
                
                
                ///////////////////////////////////////////
                ///////////////////////////////////////////
                //
                case .Multiplicacion:
                ejecutar_multiplicacion(direccion_izquierda: cuadruplo.operando_izquierdo!, direccion_derecha: cuadruplo.operando_derecho!, direccion_resultado: cuadruplo.resultado_cuadruplo!)
                break
                // END
                ///////////////////////////////////////////
                ///////////////////////////////////////////
                
                
                
                ///////////////////////////////////////////
                ///////////////////////////////////////////
                //
                case .Division:
                ejecutar_division(direccion_izquierda: cuadruplo.operando_izquierdo!, direccion_derecha: cuadruplo.operando_derecho!, direccion_resultado: cuadruplo.resultado_cuadruplo!)
                break
                // END
                ///////////////////////////////////////////
                ///////////////////////////////////////////
                
                
                
                ///////////////////////////////////////////
                ///////////////////////////////////////////
                //
                case .Mayor:
                ejecutar_mayor(direccion_izquierda: cuadruplo.operando_izquierdo!, direccion_derecha: cuadruplo.operando_derecho!, direccion_resultado: cuadruplo.resultado_cuadruplo!)
                break
                // END
                ///////////////////////////////////////////
                ///////////////////////////////////////////
                
                
                
                ///////////////////////////////////////////
                ///////////////////////////////////////////
                //
                case .MayorIgual:
                ejecutar_mayor_igual(direccion_izquierda: cuadruplo.operando_izquierdo!, direccion_derecha: cuadruplo.operando_derecho!, direccion_resultado: cuadruplo.resultado_cuadruplo!)
                break
                // END
                ///////////////////////////////////////////
                ///////////////////////////////////////////
                
                
                
                ///////////////////////////////////////////
                ///////////////////////////////////////////
                //
                case .Menor:
                ejecutar_menor(direccion_izquierda: cuadruplo.operando_izquierdo!, direccion_derecha: cuadruplo.operando_derecho!, direccion_resultado: cuadruplo.resultado_cuadruplo!)
                break
                // END
                ///////////////////////////////////////////
                ///////////////////////////////////////////
                
                
                
                ///////////////////////////////////////////
                ///////////////////////////////////////////
                //
                case .MenorIgual:
                ejecutar_menor_igual(direccion_izquierda: cuadruplo.operando_izquierdo!, direccion_derecha: cuadruplo.operando_derecho!, direccion_resultado: cuadruplo.resultado_cuadruplo!)
                break
                // END
                ///////////////////////////////////////////
                ///////////////////////////////////////////
                
                
                
                ///////////////////////////////////////////
                ///////////////////////////////////////////
                //
                case .Igual:
                ejecutar_igual(direccion_izquierda: cuadruplo.operando_izquierdo!, direccion_derecha: cuadruplo.operando_derecho!, direccion_resultado: cuadruplo.resultado_cuadruplo!)
                break
                // END
                ///////////////////////////////////////////
                ///////////////////////////////////////////
                
                
                
                ///////////////////////////////////////////
                ///////////////////////////////////////////
                //
                case .signo_igual:
                memoria_virtual.poner_valor(direccion:cuadruplo.resultado_cuadruplo!, resultado: memoria_virtual.traer_valor(direccion: cuadruplo.operando_izquierdo!).0)
                break
                // END
                ///////////////////////////////////////////
                ///////////////////////////////////////////
                
                
                
                ///////////////////////////////////////////
                ///////////////////////////////////////////
                //
                case .Diferente:
                ejecutar_diferente(direccion_izquierda: cuadruplo.operando_izquierdo!, direccion_derecha: cuadruplo.operando_derecho!, direccion_resultado: cuadruplo.resultado_cuadruplo!)
                break
                // END
                ///////////////////////////////////////////
                ///////////////////////////////////////////
                
                
                
                ///////////////////////////////////////////
                ///////////////////////////////////////////
                //
                case .And:
                ejecutar_AND(direccion_izquierda: cuadruplo.operando_izquierdo!, direccion_derecha: cuadruplo.operando_derecho!, direccion_resultado: cuadruplo.resultado_cuadruplo!)
                break
                // END
                ///////////////////////////////////////////
                ///////////////////////////////////////////
                
                
                
                ///////////////////////////////////////////
                ///////////////////////////////////////////
                //
                case .Or:
                ejecutar_OR(direccion_izquierda: cuadruplo.operando_izquierdo!, direccion_derecha: cuadruplo.operando_derecho!, direccion_resultado: cuadruplo.resultado_cuadruplo!)
                break
                // END
                ///////////////////////////////////////////
                ///////////////////////////////////////////
                
                
                
                ///////////////////////////////////////////
                ///////////////////////////////////////////
                //
                case .OUTPUT:
                ejecutar_OUTPUT(direccion: cuadruplo.resultado_cuadruplo!)
                break
                // END
                ///////////////////////////////////////////
                ///////////////////////////////////////////
                
                
                
                ///////////////////////////////////////////
                ///////////////////////////////////////////
                //
                case .GOTO:
                numero_cuadruplo = cuadruplo.resultado_cuadruplo! - 1
                break
                // END
                ///////////////////////////////////////////
                ///////////////////////////////////////////
                
                
               
                ///////////////////////////////////////////
                ///////////////////////////////////////////
                //
                case .GOTOF:
                if (!(memoria_virtual.traer_valor(direccion: cuadruplo.operando_izquierdo!).0 as! Bool)) {
                    numero_cuadruplo = cuadruplo.resultado_cuadruplo! - 1
                }
                break
                // END
                ///////////////////////////////////////////
                ///////////////////////////////////////////
                
                
                
                ///////////////////////////////////////////
                ///////////////////////////////////////////
                //
                case .ERA:
                ejecutar_ERA(direccion_funcion: cuadruplo.operando_izquierdo!)
                break
                // END
                ///////////////////////////////////////////
                ///////////////////////////////////////////
                
                
                
                ///////////////////////////////////////////
                ///////////////////////////////////////////
                //
                case .GOSUB:
                ejecutar_SUB(numero_cuadruplo: numero_cuadruplo)
                numero_cuadruplo = cuadruplo.operando_izquierdo! - 1
                break
                // END
                ///////////////////////////////////////////
                ///////////////////////////////////////////
                
                
                
                ///////////////////////////////////////////
                ///////////////////////////////////////////
                //
                case .PARAM:
                ejecutar_PARAM(direccion: cuadruplo.resultado_cuadruplo!, direccion_popeada: cuadruplo.operando_izquierdo!)
                break
                // END
                ///////////////////////////////////////////
                ///////////////////////////////////////////
                
                
                
                ///////////////////////////////////////////
                ///////////////////////////////////////////
                //
                case .ENDFUNC:
                numero_cuadruplo = memoria_virtual.pila_cuadruplos.popLast()!
                break
                // END
                ///////////////////////////////////////////
                ///////////////////////////////////////////
                
                
                
                ///////////////////////////////////////////
                ///////////////////////////////////////////
                //
                case .END:
                parser_terminar_programa();
                break
                // END
                ///////////////////////////////////////////
                ///////////////////////////////////////////
                
                
                
                default:
                break
            }
            numero_cuadruplo += 1;
        }
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // EJECUTAR SUMA
    func ejecutar_suma(direccion_izquierda:Int, direccion_derecha:Int, direccion_resultado:Int) {
        
        var direccion_izquierda_dos = direccion_izquierda
        
        if direccion_derecha < 0 {
            
            if direccion_izquierda < 0 {
                let par_izquierda = memoria_virtual.traer_valor(direccion: -1 * direccion_izquierda)
                let empalme = par_izquierda.0 as! Int
                memoria_virtual.poner_valor(direccion: direccion_resultado, resultado: -1 * direccion_derecha + (memoria_virtual.traer_valor(direccion: empalme).0 as! Int))
                return
            }
            
            let par_izquierda = memoria_virtual.traer_valor(direccion: direccion_izquierda)
            let empalme = par_izquierda.0 as! Int
            memoria_virtual.poner_valor(direccion: direccion_resultado, resultado: -1 * direccion_derecha + empalme)
            return
        }
        
        if direccion_izquierda < 0 {
            direccion_izquierda_dos = -1 * direccion_izquierda
        }
        
        var par_izquierda = memoria_virtual.traer_valor(direccion: direccion_izquierda_dos)
        let par_derecha = memoria_virtual.traer_valor(direccion: direccion_derecha)
        
        if direccion_izquierda < 0 {
            par_izquierda = memoria_virtual.traer_valor(direccion: par_izquierda.0 as! Int)
        }
        
        
        if par_izquierda.1 == .Int && par_derecha.1 == .Int {
            let valor_izquierdo = par_izquierda.0 as! Int
            let valor_derecho = par_derecha.0 as! Int
            
            memoria_virtual.poner_valor(direccion: direccion_resultado, resultado: valor_izquierdo + valor_derecho)
            return
        } else if par_izquierda.1 == .Int && par_derecha.1 == .Float {
            let valor_izquierdo = Float(par_izquierda.0 as! Int)
            let valor_derecho = par_derecha.0 as! Float
            
            memoria_virtual.poner_valor(direccion: direccion_resultado, resultado: valor_izquierdo + valor_derecho)
            return
        } else if par_izquierda.1 == .Float && par_derecha.1 == .Int {
            let valor_izquierdo = par_izquierda.0 as! Float
            let valor_derecho = Float(par_derecha.0 as! Int)
            
            memoria_virtual.poner_valor(direccion: direccion_resultado, resultado: valor_izquierdo + valor_derecho)
            return
        }
        
        let valor_izquierdo = par_izquierda.0 as! Float
        let valor_derecho = par_derecha.0 as! Float
        
        memoria_virtual.poner_valor(direccion: direccion_resultado, resultado: valor_izquierdo + valor_derecho)
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // EJECUTAR RESTA
    func ejecutar_resta(direccion_izquierda:Int, direccion_derecha:Int, direccion_resultado:Int) {
        let par_izquierda = memoria_virtual.traer_valor(direccion: direccion_izquierda)
        let par_derecha = memoria_virtual.traer_valor(direccion: direccion_derecha)
        
        if par_izquierda.1 == .Int && par_derecha.1 == .Int {
            let valor_izquierdo = par_izquierda.0 as! Int
            let valor_derecho = par_derecha.0 as! Int
            
            memoria_virtual.poner_valor(direccion: direccion_resultado, resultado: valor_izquierdo - valor_derecho)
            return
        } else if par_izquierda.1 == .Int && par_derecha.1 == .Float {
            let valor_izquierdo = Float(par_izquierda.0 as! Int)
            let valor_derecho = par_derecha.0 as! Float
            
            memoria_virtual.poner_valor(direccion: direccion_resultado, resultado: valor_izquierdo - valor_derecho)
            return
        } else if par_izquierda.1 == .Float && par_derecha.1 == .Int {
            let valor_izquierdo = par_izquierda.0 as! Float
            let valor_derecho = Float(par_derecha.0 as! Int)
            
            memoria_virtual.poner_valor(direccion: direccion_resultado, resultado: valor_izquierdo - valor_derecho)
            return
        }
        
        let valor_izquierdo = par_izquierda.0 as! Float
        let valor_derecho = par_derecha.0 as! Float
        
        memoria_virtual.poner_valor(direccion: direccion_resultado, resultado: valor_izquierdo - valor_derecho)
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // EJECUTAR MULTIPLICACION
    func ejecutar_multiplicacion(direccion_izquierda:Int, direccion_derecha:Int, direccion_resultado:Int) {
        let par_izquierda = memoria_virtual.traer_valor(direccion: direccion_izquierda)
        let par_derecha = memoria_virtual.traer_valor(direccion: direccion_derecha)
        
        if par_izquierda.1 == .Int && par_derecha.1 == .Int {
            let valor_izquierdo = par_izquierda.0 as! Int
            let valor_derecho = par_derecha.0 as! Int
            
            memoria_virtual.poner_valor(direccion: direccion_resultado, resultado: valor_izquierdo * valor_derecho)
            return
            
        } else if par_izquierda.1 == .Int && par_derecha.1 == .Float {
            let valor_izquierdo = Float(par_izquierda.0 as! Int)
            let valor_derecho = par_derecha.0 as! Float
            
            memoria_virtual.poner_valor(direccion: direccion_resultado, resultado: valor_izquierdo * valor_derecho)
            return
            
        } else if par_izquierda.1 == .Float && par_derecha.1 == .Int {
            let valor_izquierdo = par_izquierda.0 as! Float
            let valor_derecho = Float(par_derecha.0 as! Int)
            
            memoria_virtual.poner_valor(direccion: direccion_resultado, resultado: valor_izquierdo * valor_derecho)
            return
        }
        
        let valor_izquierdo = par_izquierda.0 as! Float
        let valor_derecho = par_derecha.0 as! Float
        
        memoria_virtual.poner_valor(direccion: direccion_resultado, resultado: valor_izquierdo * valor_derecho)
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // EJECUTAR DIVISION
    func ejecutar_division(direccion_izquierda:Int, direccion_derecha:Int, direccion_resultado:Int) {
        
        let par_izquierda = memoria_virtual.traer_valor(direccion: direccion_izquierda)
        let par_derecha = memoria_virtual.traer_valor(direccion: direccion_derecha)
        
        if par_izquierda.1 == .Int && par_derecha.1 == .Int {
            let valor_izquierdo = Float(par_izquierda.0 as! Int)
            let valor_derecho = Float(par_derecha.0 as! Int)
            
            memoria_virtual.poner_valor(direccion: direccion_resultado, resultado: valor_izquierdo / valor_derecho)
            return
        } else if par_izquierda.1 == .Int && par_derecha.1 == .Float {
            let valor_izquierdo = Float(par_izquierda.0 as! Int)
            let valor_derecho = par_derecha.0 as! Float
            
            memoria_virtual.poner_valor(direccion: direccion_resultado, resultado: valor_izquierdo / valor_derecho)
            return
        } else if par_izquierda.1 == .Float && par_derecha.1 == .Int {
            let valor_izquierdo = par_izquierda.0 as! Float
            let valor_derecho = Float(par_derecha.0 as! Int)
            
            memoria_virtual.poner_valor(direccion: direccion_resultado, resultado: valor_izquierdo / valor_derecho)
            return
        }
        
        let valor_izquierdo = par_izquierda.0 as! Float
        let valor_derecho = par_derecha.0 as! Float
        
        memoria_virtual.poner_valor(direccion: direccion_resultado, resultado: valor_izquierdo / valor_derecho)
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // EJECUTAR MAYOR
    func ejecutar_mayor(direccion_izquierda:Int, direccion_derecha:Int, direccion_resultado:Int) {
        
        let par_izquierda = memoria_virtual.traer_valor(direccion: direccion_izquierda)
        let par_derecha = memoria_virtual.traer_valor(direccion: direccion_derecha)
        
        if par_izquierda.1 == .Int && par_derecha.1 == .Int {
            let valor_izquierdo = par_izquierda.0 as! Int
            let valor_derecho = par_derecha.0 as! Int
            
            memoria_virtual.poner_valor(direccion: direccion_resultado, resultado: valor_izquierdo > valor_derecho)
            return
            
        } else if par_izquierda.1 == .Int && par_derecha.1 == .Float {
            let valor_izquierdo = Float(par_izquierda.0 as! Int)
            let valor_derecho = par_derecha.0 as! Float
            
            memoria_virtual.poner_valor(direccion: direccion_resultado, resultado: valor_izquierdo > valor_derecho)
            return
            
        } else if par_izquierda.1 == .Float && par_derecha.1 == .Int {
            let valor_izquierdo = par_izquierda.0 as! Float
            let valor_derecho = Float(par_derecha.0 as! Int)
            
            memoria_virtual.poner_valor(direccion: direccion_resultado, resultado: valor_izquierdo > valor_derecho)
            return
        }
        
        let valor_izquierdo = par_izquierda.0 as! Float
        let valor_derecho = par_derecha.0 as! Float
        
        memoria_virtual.poner_valor(direccion: direccion_resultado, resultado: valor_izquierdo > valor_derecho)
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // EJECUTAR MAYOR IGUAL
    func ejecutar_mayor_igual(direccion_izquierda:Int, direccion_derecha:Int, direccion_resultado:Int) {
        let par_izquierda = memoria_virtual.traer_valor(direccion: direccion_izquierda)
        let par_derecha = memoria_virtual.traer_valor(direccion: direccion_derecha)
        
        if par_izquierda.1 == .Int && par_derecha.1 == .Int {
            let valor_izquierdo = par_izquierda.0 as! Int
            let valor_derecho = par_derecha.0 as! Int
            
            memoria_virtual.poner_valor(direccion: direccion_resultado, resultado: valor_izquierdo >= valor_derecho)
            return
        } else if par_izquierda.1 == .Int && par_derecha.1 == .Float {
            let valor_izquierdo = Float(par_izquierda.0 as! Int)
            let valor_derecho = par_derecha.0 as! Float
            
            memoria_virtual.poner_valor(direccion: direccion_resultado, resultado: valor_izquierdo >= valor_derecho)
            return
        } else if par_izquierda.1 == .Float && par_derecha.1 == .Int {
            let valor_izquierdo = par_izquierda.0 as! Float
            let valor_derecho = Float(par_derecha.0 as! Int)
            
            memoria_virtual.poner_valor(direccion: direccion_resultado, resultado: valor_izquierdo >= valor_derecho)
            return
        }
        
        let valor_izquierdo = par_izquierda.0 as! Float
        let valor_derecho = par_derecha.0 as! Float
        
        memoria_virtual.poner_valor(direccion: direccion_resultado, resultado: valor_izquierdo >= valor_derecho)
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // EJECUTAR MENOR
    func ejecutar_menor(direccion_izquierda:Int, direccion_derecha:Int, direccion_resultado:Int) {
        
        let par_izquierda = memoria_virtual.traer_valor(direccion: direccion_izquierda)
        let par_derecha = memoria_virtual.traer_valor(direccion: direccion_derecha)
        
        if par_izquierda.1 == .Int && par_derecha.1 == .Int {
            let valor_izquierdo = par_izquierda.0 as! Int
            let valor_derecho = par_derecha.0 as! Int
            
            memoria_virtual.poner_valor(direccion: direccion_resultado, resultado: valor_izquierdo < valor_derecho)
            return
            
        } else if par_izquierda.1 == .Int && par_derecha.1 == .Float {
            let valor_izquierdo = Float(par_izquierda.0 as! Int)
            let valor_derecho = par_derecha.0 as! Float
            
            memoria_virtual.poner_valor(direccion: direccion_resultado, resultado: valor_izquierdo < valor_derecho)
            return
            
        } else if par_izquierda.1 == .Float && par_derecha.1 == .Int {
            let valor_izquierdo = par_izquierda.0 as! Float
            let valor_derecho = Float(par_derecha.0 as! Int)
            
            memoria_virtual.poner_valor(direccion: direccion_resultado, resultado: valor_izquierdo < valor_derecho)
            return
        }
        
        let valor_izquierdo = par_izquierda.0 as! Float
        let valor_derecho = par_derecha.0 as! Float
        
        memoria_virtual.poner_valor(direccion: direccion_resultado, resultado: valor_izquierdo < valor_derecho)
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // EJECUTAR MENOR IGUAL
    func ejecutar_menor_igual(direccion_izquierda:Int, direccion_derecha:Int, direccion_resultado:Int) {
        let par_izquierda = memoria_virtual.traer_valor(direccion: direccion_izquierda)
        let par_derecha = memoria_virtual.traer_valor(direccion: direccion_derecha)
        
        if par_izquierda.1 == .Int && par_derecha.1 == .Int {
            let valor_izquierdo = par_izquierda.0 as! Int
            let valor_derecho = par_derecha.0 as! Int
            
            memoria_virtual.poner_valor(direccion: direccion_resultado, resultado: valor_izquierdo <= valor_derecho)
            return
        } else if par_izquierda.1 == .Int && par_derecha.1 == .Float {
            let valor_izquierdo = Float(par_izquierda.0 as! Int)
            let valor_derecho = par_derecha.0 as! Float
            
            memoria_virtual.poner_valor(direccion: direccion_resultado, resultado: valor_izquierdo <= valor_derecho)
            return
        } else if par_izquierda.1 == .Float && par_derecha.1 == .Int {
            let valor_izquierdo = par_izquierda.0 as! Float
            let valor_derecho = Float(par_derecha.0 as! Int)
            
            memoria_virtual.poner_valor(direccion: direccion_resultado, resultado: valor_izquierdo <= valor_derecho)
            return
        }
        
        let valor_izquierdo = par_izquierda.0 as! Float
        let valor_derecho = par_derecha.0 as! Float
        
        memoria_virtual.poner_valor(direccion: direccion_resultado, resultado: valor_izquierdo <= valor_derecho)
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // EJECUTAR IGUAL
    func ejecutar_igual(direccion_izquierda:Int, direccion_derecha:Int, direccion_resultado:Int) {
        let par_izquierda = memoria_virtual.traer_valor(direccion: direccion_izquierda)
        let par_derecha = memoria_virtual.traer_valor(direccion: direccion_derecha)
        
        if par_izquierda.1 == .Int && par_derecha.1 == .Int {
            let valor_izquierdo = par_izquierda.0 as! Int
            let valor_derecho = par_derecha.0 as! Int
            
            memoria_virtual.poner_valor(direccion: direccion_resultado, resultado: valor_izquierdo == valor_derecho)
            return
            
        } else if par_izquierda.1 == .Float && par_derecha.1 == .Float {
            let valor_izquierdo = par_izquierda.0 as! Float
            let valor_derecho = par_derecha.0 as! Float
            
            memoria_virtual.poner_valor(direccion: direccion_resultado, resultado: valor_izquierdo == valor_derecho)
            return
            
        } else if par_izquierda.1 == .String && par_derecha.1 == .String {
            let valor_izquierdo = par_izquierda.0 as! String
            let valor_derecho = par_derecha.0 as! String
            
            memoria_virtual.poner_valor(direccion: direccion_resultado, resultado: valor_izquierdo == valor_derecho)
            return
            
        } else if par_izquierda.1 == .Bool && par_derecha.1 == .Bool {
            let valor_izquierdo = par_izquierda.0 as! Bool
            let valor_derecho = par_derecha.0 as! Bool
            
            memoria_virtual.poner_valor(direccion: direccion_resultado, resultado: valor_izquierdo == valor_derecho)
            return
        }
        
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // EJECUTAR DIFERENTE
    func ejecutar_diferente(direccion_izquierda:Int, direccion_derecha:Int, direccion_resultado:Int) {
        let par_izquierda = memoria_virtual.traer_valor(direccion: direccion_izquierda)
        let par_derecha = memoria_virtual.traer_valor(direccion: direccion_derecha)
        
        if par_izquierda.1 == .Int && par_derecha.1 == .Int {
            let valor_izquierdo = par_izquierda.0 as! Int
            let valor_derecho = par_derecha.0 as! Int
            
            memoria_virtual.poner_valor(direccion: direccion_resultado, resultado: valor_izquierdo != valor_derecho)
            return
        } else if par_izquierda.1 == .Float && par_derecha.1 == .Float {
            let valor_izquierdo = par_izquierda.0 as! Float
            let valor_derecho = par_derecha.0 as! Float
            
            memoria_virtual.poner_valor(direccion: direccion_resultado, resultado: valor_izquierdo != valor_derecho)
            return
        } else if par_izquierda.1 == .String && par_derecha.1 == .String {
            let valor_izquierdo = par_izquierda.0 as! String
            let valor_derecho = par_derecha.0 as! String
            
            memoria_virtual.poner_valor(direccion: direccion_resultado, resultado: valor_izquierdo != valor_derecho)
            return
        } else if par_izquierda.1 == .Bool && par_derecha.1 == .Bool {
            let valor_izquierdo = par_izquierda.0 as! Bool
            let valor_derecho = par_derecha.0 as! Bool
            
            memoria_virtual.poner_valor(direccion: direccion_resultado, resultado: valor_izquierdo != valor_derecho)
            return
        }
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // EJECUTAR AND
    func ejecutar_AND(direccion_izquierda:Int, direccion_derecha:Int, direccion_resultado:Int) {
        let par_izquierda = memoria_virtual.traer_valor(direccion: direccion_izquierda)
        let par_derecha = memoria_virtual.traer_valor(direccion: direccion_derecha)
        
        let valor_izquierdo = par_izquierda.0 as! Bool
        let valor_derecho = par_derecha.0 as! Bool
        
        memoria_virtual.poner_valor(direccion: direccion_resultado, resultado: valor_izquierdo && valor_derecho)
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // EJECUTAR OR
    func ejecutar_OR(direccion_izquierda:Int, direccion_derecha:Int, direccion_resultado:Int) {
        let par_izquierda = memoria_virtual.traer_valor(direccion: direccion_izquierda)
        let par_derecha = memoria_virtual.traer_valor(direccion: direccion_derecha)
        
        let valor_izquierdo = par_izquierda.0 as! Bool
        let valor_derecho = par_derecha.0 as! Bool
        
        memoria_virtual.poner_valor(direccion: direccion_resultado, resultado: valor_izquierdo || valor_derecho)
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // EJECUTAR OUTPUT
    func ejecutar_OUTPUT(direccion: Int) {
        
        let valor_tupla = memoria_virtual.traer_valor(direccion: direccion)
        var valor = ""
        switch valor_tupla.1 {
        case .Int:
            valor = String(valor_tupla.0 as! Int) + "\n"
        case .Float:
            valor = String(valor_tupla.0 as! Float) + "\n"
        case .String:
            valor = String(valor_tupla.0 as! String) + "\n"
        case .Bool:
            valor = String(valor_tupla.0 as! Bool) + "\n"
        default:
            break
        }
        parser_acumular_resultado(valor)
       
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
 
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // EJECUTAR ERA
    func ejecutar_ERA(direccion_funcion: Int) {

        let nombre_funcion = traer_nombre_funcion(direccion: direccion_funcion)
        
        if nombre_funcion == "Error"{
            print("ERROR")
            return
        }
        
        let memoria_funcion = tabla_funciones[nombre_funcion]?.memoria.duplicar()
        memoria_virtual.pila_memoria.append(memoria_funcion!)
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // EJECUTAR GO SUB
    func ejecutar_SUB(numero_cuadruplo: Int) {
        let local = memoria_virtual.memoria_local
        
        memoria_virtual.memoria_local = memoria_virtual.pila_memoria.popLast()!
        memoria_virtual.pila_memoria.append(local)
        memoria_virtual.pila_cuadruplos.append(numero_cuadruplo)
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // EJECUTAR PARAM
    func ejecutar_PARAM(direccion:Int, direccion_popeada:Int) {

        let valor_tupla = memoria_virtual.traer_valor(direccion: direccion_popeada)
        
        if valor_tupla.1 == .Int {
            let valor = valor_tupla.0 as! Int
            memoria_virtual.poner_valor_parametro(direccion: direccion, resultado: valor)
        }
        else if valor_tupla.1 == .Float {
            let valor = valor_tupla.0 as! Float
            memoria_virtual.poner_valor_parametro(direccion: direccion, resultado: valor)
        }
        else if valor_tupla.1 == .String {
            let valor = valor_tupla.0 as! String
            memoria_virtual.poner_valor_parametro(direccion: direccion, resultado: valor)
        }
        else if valor_tupla.1 == .Bool {
            let valor = valor_tupla.0 as! Bool
            memoria_virtual.poner_valor_parametro(direccion: direccion, resultado: valor)
        }
        else {
            print("ERROR")
        }
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
}// END CLASS

