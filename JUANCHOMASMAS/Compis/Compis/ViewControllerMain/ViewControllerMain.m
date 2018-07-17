//
//  ViewControllerMain.m
//  Compis
//
//  Created by Juancho Pestana on 4/30/18.
//  Copyright © 2018 Juancho Pestana. All rights reserved.
//

#import "ViewControllerMain.h"

@interface ViewControllerMain ()
@property bool error_parser;
@end

@implementation ViewControllerMain
@synthesize error_parser;

- (void)viewDidLoad {
    [super viewDidLoad];
    
}// END VIEWDIDLOAD

///////////////////////////////////////////
///////////////////////////////////////////
// RECURSION
- (IBAction)recursion:(id)sender {
    
    NSString *codigo = @"programa:\n\nvar Int k;\nvar Int i;\n\nfuncion void uno(Int n){\nvar Int j;\nj = n * 2;\nif(j < n + 40){\nuno(n+1);\n}\noutput(i);\n}\n\nfuncion Int dos(Int z) {\nz = z * i + k;\nreturn (z*2);\n}\n\nmain {\ni = 3;\nk = i * i - 1 + 2;\nuno(k);\ni = dos(i+k);\noutput(i);\n}";
    self.input_text_view.text = codigo;
    
}
// END
///////////////////////////////////////////
///////////////////////////////////////////



///////////////////////////////////////////
///////////////////////////////////////////
// FIBONACCI
- (IBAction)fibonacci:(id)sender {
    
    NSString *codigo = @"programa: \n\nmain {\nvar Int n;\nvar Int i;\nvar Int x;\nvar Int y;\nvar Int z;\nn = 40;\nz = 0;\nx = 0;\ny = 1;\ni = 0;\n\nwhile(i <= n) {\nif(i == 1) {\noutput(x);\nelif (i == 2){\noutput(y);\n}\nelse{\nz = x + y;\nx = y;\ny = z;\noutput(z);\n}\n}\ni = i + 1;\n}\n}\n";
    self.input_text_view.text = codigo;
}
// END
///////////////////////////////////////////
///////////////////////////////////////////



///////////////////////////////////////////
///////////////////////////////////////////
// FACTORIAL
- (IBAction)factorial:(id)sender {
    
    NSString *codigo = @"programa:\n\nfuncion Int factorial(Int n){\nvar Int fact;\nvar Int i;\nfact = 1;\ni = 1;\nwhile(i <= n) {\nfact = fact * i;\ni = i + 1;\n}\nreturn fact;\n}\n\nmain {\nvar Int fact;\nfact = factorial(20);\noutput(fact);\n}";
    self.input_text_view.text = codigo;
}
// END
///////////////////////////////////////////
///////////////////////////////////////////



///////////////////////////////////////////
///////////////////////////////////////////
// MULTIPLICAR ARREGLO
- (IBAction)multi_arreglo:(id)sender {
    
    NSString *codigo = @"programa:\nvar Int arrA[5];\nvar Int arrB[5];\nvar Int arrC[5];\n\nvar Int cont;\nvar Int temp1;\nvar Int temp2;\nvar Int temp3;\n\nmain {\ncont = 0;\n\narrA[0] = 30;\narrA[1] = 50;\narrA[2] = 7;\narrA[3] = 9;\narrA[4] = 11;\narrA[5] = 13;\n\narrB[0] = 3;\narrB[1] = 4;\narrB[2] = 7;\narrB[3] = 9;\narrB[4] = 2;\narrB[5] = 13;\n\nwhile(cont <= 5){\ntemp1 = arrA[cont];\ntemp2 = arrB[cont];\ntemp3 = temp1 * temp2;\narrC[cont] = temp3;\ncont = cont + 1;\n}\ncont = 0;\nwhile(cont <= 5){\noutput(arrC[cont]);\ncont = cont + 1;\n}\n}";
    self.input_text_view.text = codigo;
}
// END
///////////////////////////////////////////
///////////////////////////////////////////



///////////////////////////////////////////
///////////////////////////////////////////
// BUSCAR ARREGLO
- (IBAction)buscar_arreglo:(id)sender {
    
    NSString *codigo = @"programa:\n\nvar Int arrA[5];\nvar Int alfa;\nvar Int cont;\nvar Int boog;\nvar Int temp;\nvar Int prueba;\nvar Int buscar;\n\nmain {\nbuscar = 11;\nboog = 0;\ncont = 0;\ntemp = 0;\nprueba = 0;\n\narrA[0] = 3;\narrA[1] = 50;\narrA[2] = 7;\narrA[3] = 900;\narrA[4] = 11;\narrA[5] = 130;\n\nwhile(cont <= 5){\noutput(arrA[cont]);\ncont = cont + 1;\n}\n\ncont = 0;\nwhile(cont <= 5){\nalfa = arrA[cont];\n\nif(alfa == buscar){\nprueba = 100;\nelif (1>2) {\nboog = 1;\n}\nelse {\nboog = 1;\n}\n}\ncont = cont + 1;\n}\n\nif\(prueba == 100){\noutput(\"SI ESTA\");\nelif (prueba == 111) {\nboog = 1;\n}\nelse {\noutput(\"NO ESTA\");\n}\n}\n}";
    self.input_text_view.text = codigo;
}
// END
///////////////////////////////////////////
///////////////////////////////////////////



///////////////////////////////////////////
///////////////////////////////////////////
// ORDENAR ARREGLO
- (IBAction)ordenar_arreglo:(id)sender {
    
    NSString *codigo = @"programa:\n\nvar Int arrA[5];\nvar Int alfa;\nvar Int cont;\nvar Int cont2;\nvar Int boog;\nvar Int temp;\n\nmain {\n\nboog = 0;\ncont = 0;\ncont2 = 0;\ntemp = 0;\narrA[0] = 3;\narrA[1] = 50;\narrA[2] = 7;\narrA[3] = 900;\narrA[4] = 11;\narrA[5] = 130;\n\nwhile(cont <= 5){\noutput(arrA[cont]);\ncont = cont + 1;\n}\n\ncont = 0;\nwhile(cont <= 5){\ncont2 = 0;\nwhile(cont2 <= 5){\n\nif(arrA[cont2] > arrA[cont2 + 1]){\ntemp = arrA[cont2];\narrA[cont2] = arrA[cont2 + 1];\narrA[cont2 + 1] = temp;\nelif (1>0){\nboog =1;\n}\nelse {\nboog = 1;\n}\n}\ncont2 = cont2 + 1;\n}\ncont = cont + 1;\n}\noutput(\"###########\");\ncont = 0;\nwhile(cont <= 5){\noutput(arrA[cont]);\ncont = cont + 1;\n}\n}";
    self.input_text_view.text = codigo;
}
// END
///////////////////////////////////////////
///////////////////////////////////////////







- (IBAction)ejecutar:(id)sender {
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // STRINGS PARA HACER OUTPUT DE RESULTADO CORRECTO O ERRORES
    NSMutableString *string_errores = [[NSMutableString alloc]init];
    [string_errores appendString:@""];
    NSMutableString *string_resultado = [[NSMutableString alloc]init];
    [string_resultado appendString:@""];
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // VARIABLE DE PARSER, INICIALIZAR ERROR EN FALSO Y REINICIAR EL OBJETO MAIN
    YY_BUFFER_STATE buf;
    error_parser = false;
    [Main.main_global reiniciar];
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // LIMPIAR LAS COMILLAS PARA EVITAR PROBLEMAS EN EJECUCION
    self.input_text_view.text = [self.input_text_view.text stringByReplacingOccurrencesOfString:@"”" withString:@"\""];
    self.input_text_view.text = [self.input_text_view.text stringByReplacingOccurrencesOfString:@"“" withString:@"\""];
    buf = yy_scan_string([self.input_text_view.text cStringUsingEncoding:NSUTF8StringEncoding]);
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // BUSCAR FUNCION EN TABLA DE FUNCIONES PARA VER SI ESTA DUPLICADA
    parser_buscar_funcion = ^(NSString *nombre) {
        return [Main.main_global verificar_funcion_existe:nombre];
    };
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // AGREGAR FUNCION A TABLA DE FUNCIONES
    parser_agregar_funcion = ^(NSString *nombre, NSString *tipo) {
        return [Main.main_global agregar_funcion:nombre tipo:tipo];
    };
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // AGREGAR FUNCION A TABLA DE FUNCIONES SIN TIPO
    parser_agregar_funcion_sin_tipo = ^(NSString *nombre) {
        [Main.main_global agregar_funcion_2:nombre];
    };
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // AGREGAR EL TIPO DE RETORNO DE LA FUNCION 
    parser_agregar_tipo_retorno = ^(NSString *nombre, NSString *tipo) {
        [Main.main_global agregar_tipo_retorno_funcion:nombre tipo: tipo];
    };
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // BUSCAR VARIABLE EN TABLA DE VARIABLES PARA VER SI NO ESTA DUPLICADA
    parser_buscar_variable = ^(NSString *nombre) {
        return [Main.main_global verificar_variable_existe:nombre];
    };
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // AGREGAR VARIABLE A TABLA DE FUNCIONES (parametro sirve para determinar si es un parametro o una variable normal)
    parser_agregar_variable = ^(NSString *nombre, NSString *tipo, int parametro) {
        [Main.main_global agregar_variable:nombre tipo: tipo parametro: parametro];
    };
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // AGREGAR ARREGLO A TABLA DE VARIABLES
    parser_agregar_arreglo = ^(NSString *nombre, NSString *tipo, int tamano) {
        [Main.main_global agregar_arreglo:nombre tipo:tipo tamano:tamano];
    };
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // BUSCAR SI EXISTE PARAMETRO EN TABLA DE VARIABLES
    parser_buscar_parametro = ^(NSString *valor) {
        return [Main.main_global verificar_parametro_existe:valor];
    };
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // AGREGAR ID A PILA DE OPERACIONES
    parser_agregar_id_pila_operaciones = ^(NSString *nombre, NSString *tipo) {
        [Main.main_global push_direccion_id:nombre tipo:tipo];
    };
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // TRAER EL SIGUIENTE OPERADOR DE LA PILA DE OPERACIONES Y COMPARARLO CON EL ACTUAL PARA VER SI SON TIPOS COMPATIBLES
    parser_buscar_siguiente_operador_pila_operaciones = ^(NSString *tipo) {
        if (self.error_parser) {
            return YES;
        }
        
        NSString *siguiente_operador = [Main.main_global traer_siguiente_operador];
        bool siguiente_es_suma_resta = [siguiente_operador isEqual: @"+"] || [siguiente_operador  isEqual: @"-"];
        bool siguiente_es_multiplicacion_division = [siguiente_operador  isEqual: @"*"] || [siguiente_operador isEqual: @"/"];
        bool siguiente_es_relacional = [siguiente_operador isEqual: @">"] || [siguiente_operador  isEqual: @">="] || [siguiente_operador  isEqual: @"<"] || [siguiente_operador  isEqual: @"<="] || [siguiente_operador  isEqual: @"=="] || [siguiente_operador  isEqual: @"!="];
        bool siguiente_es_logico = [siguiente_operador isEqual: @"&&"] || [siguiente_operador isEqual: @"||"];
        bool siguiente_es_asignacion = [siguiente_operador isEqual: @"="];

        
        if ([tipo isEqual: @"suma_resta"] && siguiente_es_suma_resta) {
            return [Main.main_global generar_cuadruplo];
        }
        else if ([tipo isEqual: @"multiplicacion_division"] && siguiente_es_multiplicacion_division) {
            return [Main.main_global generar_cuadruplo];
        }
        else if ([tipo isEqual: @"relacional"] && siguiente_es_relacional) {
            return [Main.main_global generar_cuadruplo];
        }
        else if ([tipo isEqual: @"logico"] && siguiente_es_logico) {
            return [Main.main_global generar_cuadruplo];
        }
        else if ([tipo isEqual: @"asignacion"] && siguiente_es_asignacion) {
            return [Main.main_global generar_cuadruplo_asignacion];
        }
        
        return YES;
    };
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // AGREGAR OPERADOR A PILA DE OPERACIONES
    parser_agregar_operador_pila_operaciones = ^(NSString *val) {
        [Main.main_global push_operador:val];
    };
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // BORRAR FONDO FALSO DE PILA DE OPERACIONES
    parser_borrar_parentesis_pila_operaciones = ^() {
        [Main.main_global pop_parentesis];
    };
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // GENERAR CUADRUPLO GOTO EN VERDADERO
    parser_generar_cuadruplo_GOTO = ^(int codigo) {
        [Main.main_global generar_cuadruplo_GOTO:codigo];
    };
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // GENERAR CUADRUPLO GOTO EN FALSO
    parser_generar_cuadruplo_GOTOF = ^(int codigo) {
        [Main.main_global generar_cuadruplo_GOTOF:codigo];
    };
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // GENERAR CUADRUPLO DE CONDICION EN WHILE
    parser_generar_cuadruplo_condicion_WHILE = ^() {
        [Main.main_global generar_cuadruplo_condicion_WHILE];
    };
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // GENERAR CUADRUPLO END CICLO
    parser_rellenar_cuadruplo_end_ciclo = ^() {
        [Main.main_global rellenar_cuadruplo_end_ciclo];
    };
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // RELLENAR CONDICION DE CUADRUPLO PENDIENTE
    parser_rellenar_condicion_end_cuadruplo = ^() {
        [Main.main_global rellenar_condicion_end_cuadruplo];
    };
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // GENERAR CUADRUPLO OUTPUT
    parser_generar_cuadruplo_OUTPUT = ^(NSString *nombre) {
        [Main.main_global generar_cuadruplo_OUTPUT:nombre];
    };
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // GENERAR CUADRUPLO ERA PARA FUNCIONES
    parser_generar_cuadruplo_ERA = ^(NSString *nombre) {
        [Main.main_global generar_cuadruplo_ERA:nombre];
    };
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // GENERAR CUADRUPLO DE PARAMETRO PARA FUNCION
    parser_generar_cuadruplo_PARAMETRO = ^(NSString *nombre) {
        return [Main.main_global generar_cuadruplo_parametro];
    };
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // GENERAR CUADRUPLO DE GOSUB PARA FUNCION
    parser_generar_cuadruplo_GOSUB = ^(NSString *nombre) {
        if (!self.error_parser) {
            [Main.main_global generar_cuadruplo_GOSUB];
        }
    };
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // GENERAR CUADRUPLO DE END FUNCTION
    parser_generar_cuadruplo_ENDFUNCTION = ^() {
        [Main.main_global generar_cuadruplo_end_of_function];
    };
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // GENERAR CUADRUPLO RETURN
    parser_generar_cuadruplo_RETURN = ^() {
        return [Main.main_global generar_cuadruplo_retorno];
    };
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // GENERAR CUADRUPLO DE VOID
    parser_generar_cuadruplo_VOIDRETURN = ^() {
        return [Main.main_global generar_cuadruplo_retorno_VOID];
    };
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // MANDAR ARREGLO A PILA DE ARREGLOS PENDIENTES
    parser_verificar_si_arreglo = ^(){
        return [Main.main_global verificar_si_arreglo];
    };
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // VERIFICAR RANGO EXPRESION ARREGLO
    parser_verificar_rango_expresion_arreglo = ^(){
        return [Main.main_global verificar_rango_expresion_arreglo];
    };
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // AGREGAR GAP A DIRECCION BASE
    parser_agregar_gap_a_direccion_base = ^(){
        return [Main.main_global agregar_gap_a_direccion_base];
    };
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    

    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // GENERAR CUARUPLO DE END PROGRAM
    parser_generar_cuadruplo_ENDPROGRAM = ^() {
        if (!self.error_parser) {
            [Main.main_global generar_cuadruplo_end_of_program];
        } else {
            parser_terminar_programa();
        }
    };
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // ACUMULAR LOS RESULTADOS CORRECTOS PARA MOSTRAR EN OUTPUT
    parser_acumular_resultado = ^(NSString *texto) {
        if (!self.error_parser) {
            [string_resultado appendString:texto];
        }
    };
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // ACUMULAR ERRORES PARA MOSTRAR EN OUTPUT
    parser_acumular_errores = ^(NSString *errores) {
        self.error_parser = true;
        [string_errores appendString:errores];
        
    };
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    // TEMINAR EL PROGRAMA
    parser_terminar_programa = ^() {
        
        if (!self.error_parser) {
            self.output_text_view.text = string_resultado;
        } else {
            self.output_text_view.text = string_errores;
        }
        
    };
    // END
    ///////////////////////////////////////////
    ///////////////////////////////////////////
    
    
    yyparse();
    yy_delete_buffer(buf);
    
    
}// END EJECUTAR
@end
