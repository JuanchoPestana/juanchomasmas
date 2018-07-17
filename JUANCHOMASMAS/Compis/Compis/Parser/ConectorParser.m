//
//  VariableTable.m
//  Compis
//
//  Created by Juancho Pestana on 3/9/18.
//  Copyright © 2018 Juancho Pestana. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ConectorParser.h"

///////////////////////////////////////////
///////////////////////////////////////////
// FUNCIONES
bool (^parser_buscar_funcion)(NSString *nombre);
bool (^parser_agregar_funcion)(NSString *nombre, NSString *tipo);
void (^parser_agregar_funcion_sin_tipo)(NSString *nombre);
void (^parser_agregar_tipo_retorno)(NSString *nombre, NSString *tipo);
// END
///////////////////////////////////////////
///////////////////////////////////////////



///////////////////////////////////////////
///////////////////////////////////////////
// VARIABLES, ARREGLOS Y PARAMETROS
bool (^parser_buscar_variable)(NSString *nombre);
bool (^parser_buscar_parametro)(NSString *nombre);
void (^parser_agregar_variable)(NSString *nombre, NSString *tipo, int parametro);
void (^parser_agregar_arreglo)(NSString *nombre, NSString *tipo, int tamano);
// END
///////////////////////////////////////////
///////////////////////////////////////////



///////////////////////////////////////////
///////////////////////////////////////////
// ARREGLOS
bool (^parser_verificar_si_arreglo)(void);
void (^parser_verificar_rango_expresion_arreglo)(void);
bool (^parser_agregar_gap_a_direccion_base)(void);
// END
///////////////////////////////////////////
///////////////////////////////////////////



///////////////////////////////////////////
///////////////////////////////////////////
// OPERACIONES
void (^parser_agregar_id_pila_operaciones)(NSString *nombre, NSString *tipo);
void (^parser_agregar_operador_pila_operaciones)(NSString *nombre);
bool (^parser_buscar_siguiente_operador_pila_operaciones)(NSString *tipoOp);
void (^parser_borrar_parentesis_pila_operaciones)(void);
// END
///////////////////////////////////////////
///////////////////////////////////////////



///////////////////////////////////////////
///////////////////////////////////////////
// CUADRUPLOS
void (^parser_generar_cuadruplo_GOTO)(int id);
void (^parser_generar_cuadruplo_GOTOF)(int id);
void (^parser_generar_cuadruplo_condicion_WHILE)(void);
void (^parser_rellenar_cuadruplo_end_ciclo)(void);
void (^parser_rellenar_condicion_end_cuadruplo)(void);
void (^parser_generar_cuadruplo_OUTPUT)(NSString *id);
void (^parser_generar_cuadruplo_ERA)(NSString *id);
bool (^parser_generar_cuadruplo_PARAMETRO)(NSString * id);
void (^parser_generar_cuadruplo_GOSUB)(NSString * id);
bool (^parser_generar_cuadruplo_RETURN)(void);
bool (^parser_generar_cuadruplo_VOIDRETURN)(void);
void (^parser_generar_cuadruplo_ENDFUNCTION)(void);
void (^parser_generar_cuadruplo_ENDPROGRAM)(void);
// END
///////////////////////////////////////////
///////////////////////////////////////////



///////////////////////////////////////////
///////////////////////////////////////////
// OUTPUT RESULTADOS
void (^parser_acumular_resultado)(NSString *valor);
void (^parser_acumular_errores)(NSString *errores);
// END
///////////////////////////////////////////
///////////////////////////////////////////



///////////////////////////////////////////
///////////////////////////////////////////
// END PROGRAM
void (^parser_terminar_programa)(void);
// END
///////////////////////////////////////////
///////////////////////////////////////////
