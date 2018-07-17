//
//  VariableTable.h
//  Compis
//
//  Created by Juancho Pestana on 3/9/18.
//  Copyright © 2018 Juancho Pestana. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef ConectorParser_h
#define ConectorParser_h


///////////////////////////////////////////
///////////////////////////////////////////
// FUNCIONES
extern bool (^parser_buscar_funcion)(NSString *nombre);
extern bool (^parser_agregar_funcion)(NSString *nombre, NSString *tipo);
extern void (^parser_agregar_funcion_sin_tipo)(NSString *nombre);
extern void (^parser_agregar_tipo_retorno)(NSString *nombre, NSString *tipo);
// END
///////////////////////////////////////////
///////////////////////////////////////////



///////////////////////////////////////////
///////////////////////////////////////////
// VARIABLES, ARREGLOS Y PARAMETROS
extern bool (^parser_buscar_variable)(NSString *nombre);
extern bool (^parser_buscar_parametro)(NSString *nombre);
extern void (^parser_agregar_variable)(NSString *nombre, NSString *tipo, int parametro);
extern void (^parser_agregar_arreglo)(NSString *nombre, NSString *tipo, int tamano);
// END
///////////////////////////////////////////
///////////////////////////////////////////



///////////////////////////////////////////
///////////////////////////////////////////
// ARREGLOS
extern bool (^parser_verificar_si_arreglo)(void);
extern void (^parser_verificar_rango_expresion_arreglo)(void);
extern bool (^parser_agregar_gap_a_direccion_base)(void);
// END
///////////////////////////////////////////
///////////////////////////////////////////



///////////////////////////////////////////
///////////////////////////////////////////
// OPERACIONES
extern void (^parser_agregar_id_pila_operaciones)(NSString *nombre, NSString *tipo);
extern void (^parser_agregar_operador_pila_operaciones)(NSString *nombre);
extern bool (^parser_buscar_siguiente_operador_pila_operaciones)(NSString *tipoOp);
extern void (^parser_borrar_parentesis_pila_operaciones)(void);
// END
///////////////////////////////////////////
///////////////////////////////////////////



///////////////////////////////////////////
///////////////////////////////////////////
// CUADRUPLOS
extern void (^parser_generar_cuadruplo_GOTO)(int id);
extern void (^parser_generar_cuadruplo_GOTOF)(int id);
extern void (^parser_generar_cuadruplo_condicion_WHILE)(void);
extern void (^parser_rellenar_cuadruplo_end_ciclo)(void);
extern void (^parser_rellenar_condicion_end_cuadruplo)(void);
extern void (^parser_generar_cuadruplo_OUTPUT)(NSString *id);
extern void (^parser_generar_cuadruplo_ERA)(NSString *id);
extern bool (^parser_generar_cuadruplo_PARAMETRO)(NSString * id);
extern void (^parser_generar_cuadruplo_GOSUB)(NSString * id);
extern bool (^parser_generar_cuadruplo_RETURN)(void);
extern bool (^parser_generar_cuadruplo_VOIDRETURN)(void);
extern void (^parser_generar_cuadruplo_ENDFUNCTION)(void);
extern void (^parser_generar_cuadruplo_ENDPROGRAM)(void);
// END
///////////////////////////////////////////
///////////////////////////////////////////



///////////////////////////////////////////
///////////////////////////////////////////
// OUTPUT RESULTADOS
extern void (^parser_acumular_resultado)(NSString *valor);
extern void (^parser_acumular_errores)(NSString *errores);
// END
///////////////////////////////////////////
///////////////////////////////////////////



///////////////////////////////////////////
///////////////////////////////////////////
// END PROGRAM
extern void (^parser_terminar_programa)(void);
// END
///////////////////////////////////////////
///////////////////////////////////////////



///////////////////////////////////////////
///////////////////////////////////////////
// PARSER
#ifndef FLEXINT_H
typedef struct yy_buffer_state *YY_BUFFER_STATE;
YY_BUFFER_STATE  yy_scan_string(const char *s);
int yyparse(void);
void yy_delete_buffer(YY_BUFFER_STATE buf);
// END
///////////////////////////////////////////
///////////////////////////////////////////

#endif
#endif /* ConectorParser_h */
