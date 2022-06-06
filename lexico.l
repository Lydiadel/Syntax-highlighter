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

string val="";
void saveValues(string token, string texto){
    val += "\n<p class = \"" + token + "\">" + texto + "</p>";
    val += "\t<p class = \"" + token + "\">" +  + "</p>";
    createHTML();
};

void createHTML(){
    ofstream page("page.html");

    page << "<head>\n\t<link rel=\"stylesheet\" href=\"static/design.css\">\n</head>\n<body>\n" ;
    page << "<h1>Syntax Highlighter</h1>\n";
    page << "<div class='grid-container'>";
    page << "<div class='grid-item'>Numero Entero <span class=\"circle NumeroEnteroCircle\"></span></div>";
    page << "<div class='grid-item'>Numero Real <span class=\"circle NumeroRealCircle\"></span></div>";
    page << "<div class='grid-item'>Resta <span class=\"circle RestaCircle\"></span></div>" ; 
    page << "<div class='grid-item'>Keyword <span class=\"circle KeywordCircle\"></span></div>" ; 
    page << "<div class='grid-item'>Suma <span class=\"circle SumaCircle\"></span></div>" ; 
    page << "<div class='grid-item'>Variable <span class=\"circle VariableCircle\"></span></div>" ; 
    page << "<div class='grid-item'>Multiplicacion <span class=\"circle MultiplicacionCircle\"></span></div>" ; 
    page << "<div class='grid-item'>Potencia <span class=\"circle PotenciaCircle\"></span></div>" ; 
    page << "<div class='grid-item'>Punto <span class=\"circle PuntoCircle\"></span></div>"; 
    page << "</div>";
    page << "<h1> Hello world </h1>\n\n";
    page << val ;
    page << "</body>";
    page.close();
};