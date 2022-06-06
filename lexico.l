/* Lydia Delgado Uriarte */
%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <fstream>
#include <iostream>

using namespace std; 
void saveValues(string token, string texto);
void createHTML();
%}

%option c++
%option outfile="lexico.cpp"
%option case-insensitive
%option noyywrap

/* SECCION TOKENS */

DIGITO [0-9]
LETRA [a-zA-ZñÑ]
ESPACIO [" "]
INI_COMENTARIO ["/*"]
FIN_COMENTARIO ["*/"]
GUIONES "_"
CHAR_PUNTO "."
CHAR_COMA ","
CHAR_PUNTOYCOMA ";"
CHAR_DOSPUNTOS ":"

VARIABLE {LETRA}({LETRA}|{DIGITO}|{GUIONES})*

REAL "-"{DIGITO}+"."+{DIGITO}+|{DIGITO}+"."+{DIGITO}+
ENTERO {DIGITO}+|"-"{DIGITO}+


/* Operadores lógicos y operadores aritméticos básicos */
SUMA "+"
MULT "*"
RESTA "-"
DIVISION "/"
POTENCIA "^"
IGUAL ["="]
MAYOR ">"
MENOR "<"
MAYOR_IGUAL ">="
MENOR_IGUAL "<="
COMPARACION_IGUAL "=="
EXCLAMACION "!"
DIFERENTEA "!="
COMENTARIO "//".+|"#".+
FUNCION {VARIABLE}"("+.*+")"


/* Caracteres que abren y cierran */
LLAVE_ABRE ["{"]
LLAVE_CIERRA ["}"]
PARENTESIS_ABRE ["("]
PARENTESIS_CIERRA [")"]

DELIMITADOR [\t\r\f" "]

/*Keywords */
KEYWORDS "if"|"IF"|"while"|"WHILE"|"for"|"FOR"|"int"|"INT"|"else"|"ELSE"|"class"|"CLASS"|"break"|"BREAK"|"continue"|"CONTINUE"|"true"|"TRUE"|"false"|"FALSE"|"float"|"FLOAT"
/*Bloque de código que imprime */

/*{VARIABLE} {saveValues("Variable %s\n",yytext);}*/
%%

{REAL} {saveValues ("NumeroReal",yytext);}
{RESTA} {saveValues("Resta", yytext);}
{KEYWORDS} {saveValues("Keyword", yytext);}
{ENTERO} {saveValues("NumeroEntero", yytext);}
{VARIABLE} {saveValues("Variable",yytext);}
{SUMA} {saveValues("Suma", yytext);}
{MULT} {saveValues ("Multiplicacion",yytext);}
{DIVISION} {saveValues("Division", yytext);}
{POTENCIA} {saveValues("Potencia",yytext);}
{CHAR_PUNTO} {saveValues("Punto", yytext);}
{CHAR_COMA} {saveValues ("Coma",yytext);}
{CHAR_PUNTOYCOMA} {saveValues("PuntoyComa", yytext);}
{CHAR_DOSPUNTOS} {saveValues("DosPuntos",yytext);}
{FUNCION} {saveValues("Funcion",yytext);}
{COMENTARIO} {saveValues("Comentario", yytext);}
{IGUAL} {saveValues("Igual", yytext);}
{MAYOR} {saveValues("Mayor", yytext);}
{MENOR} {saveValues ("Menor",yytext);}
{MAYOR_IGUAL} {saveValues("Mayorigual", yytext);}
{MENOR_IGUAL} {saveValues("Menorigual",yytext);}
{COMPARACION_IGUAL} {saveValues ("ComparacionIgual",yytext);}
{EXCLAMACION} {saveValues("Exclamacion", yytext);}
{DIFERENTEA} {saveValues("Diferente",yytext);}
{PARENTESIS_ABRE} {saveValues("ParentesisAbre", yytext);}
{PARENTESIS_CIERRA} {saveValues("ParentesisCierra", yytext);}

{DELIMITADOR} {}
.             {printf("ERROR LEXICO");}

%%

