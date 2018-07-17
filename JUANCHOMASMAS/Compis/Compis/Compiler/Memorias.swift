//
//  Memorias.swift
//  Compis
//
//  Created by Juancho Pestana on 4/10/18.
//  Copyright © 2018 Juancho Pestana. All rights reserved.
//

import Foundation

class MemoriaGlobal: Memoria {
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // INT
    override var direccion_Inicial_INT: Int{
        get {
            return 110000
        }
        set(newValue) {
            self.direccion_Inicial_INT = newValue
        }
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // FLOAT
    override var direccion_Inicial_FLOAT: Int{
        get {
            return 111000
        }
        set(newValue) {
            self.direccion_Inicial_FLOAT = newValue
        }
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // STRING
    override var direccion_Inicial_STRING: Int{
        get {
            return 112000
        }
        set(newValue) {
            self.direccion_Inicial_INT = newValue
        }
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // BOOL
    override var direccion_Inicial_BOOL: Int{
        get {
            return 113000
        }
        set(newValue) {
            self.direccion_Inicial_INT = newValue
        }
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
}// END MEMORIA GLOBAL


class MemoriaLocal: Memoria {
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // INT
    override var direccion_Inicial_INT: Int{
        get {
            return 120000
        }
        set(newValue) {
            self.direccion_Inicial_INT = newValue
        }
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // FLOAT
    override var direccion_Inicial_FLOAT: Int{
        get {
            return 121000
        }
        set(newValue) {
            self.direccion_Inicial_FLOAT = newValue
        }
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // STRING
    override var direccion_Inicial_STRING: Int{
        get {
            return 122000
        }
        set(newValue) {
            self.direccion_Inicial_INT = newValue
        }
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // BOOL
    override var direccion_Inicial_BOOL: Int{
        get {
            return 123000
        }
        set(newValue) {
            self.direccion_Inicial_INT = newValue
        }
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
}// END MEMORIA LOCAL

class MemoriaConstante: Memoria {
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // INT
    override var direccion_Inicial_INT: Int{
        get {
            return 130000
        }
        set(newValue) {
            self.direccion_Inicial_INT = newValue
        }
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // FLOAT
    override var direccion_Inicial_FLOAT: Int{
        get {
            return 131000
        }
        set(newValue) {
            self.direccion_Inicial_FLOAT = newValue
        }
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // STRING
    override var direccion_Inicial_STRING: Int{
        get {
            return 132000
        }
        set(newValue) {
            self.direccion_Inicial_INT = newValue
        }
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // BOOL
    override var direccion_Inicial_BOOL: Int{
        get {
            return 133000
        }
        set(newValue) {
            self.direccion_Inicial_INT = newValue
        }
    }
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
}// END MEMORIA CONSTANTE
