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
    page << "<div class='grid-item'>Numero Entero &nbsp<span class=\"circle NumeroEnteroCircle\"></span></div>";
    page << "<div class='grid-item'>Numero Real &nbsp<span class=\"circle NumeroRealCircle\"></span></div>";
    page << "<div class='grid-item'>Resta &nbsp&nbsp<span class=\"circle RestaCircle\"></span></div>" ; 
    page << "<div class='grid-item'>Keyword &nbsp<span class=\"circle KeywordCircle\"></span></div>" ; 
    page << "<div class='grid-item'>Suma &nbsp<span class=\"circle SumaCircle\"></span></div>" ; 
    page << "<div class='grid-item'>Variable &nbsp<span class=\"circle VariableCircle\"></span></div>" ; 
    page << "<div class='grid-item'>Multiplicacion &nbsp<span class=\"circle MultiplicacionCircle\"></span></div>" ; 
    page << "<div class='grid-item'>Potencia &nbsp<span class=\"circle PotenciaCircle\"></span></div>" ; 
    page << "<div class='grid-item'>Coma &nbsp&nbsp<span class=\"circle ComaCircle\"></span></div>";
    page << "<div class='grid-item'>Punto y Coma &nbsp<span class=\"circle PuntoyComaCircle\"></span></div>" ; 
    page << "<div class='grid-item'>Dos Puntos &nbsp<span class=\"circle DosPuntosCircle\"></span></div>" ; 
    page << "<div class='grid-item'>Funcion &nbsp<span class=\"circle FuncionCircle\"></span></div>" ; 
    page << "<div class='grid-item'>Comentario &nbsp<span class=\"circle ComentarioCircle\"></span></div>";  
    page << "<div class='grid-item'>Igual &nbsp<span class=\"circle IgualCircle\"></span></div>" ; 
    page << "<div class='grid-item'>Mayor &nbsp<span class=\"circle MayorCircle\"></span></div>" ; 
    page << "<div class='grid-item'>Menor &nbsp<span class=\"circle MenorCircle\"></span></div>";  
    page << "<div class='grid-item'>Mayor Igual &nbsp<span class=\"circle MayorigualCircle\"></span></div>" ; 
    page << "<div class='grid-item'>Comparacion Igual &nbsp<span class=\"circle ComparacionIgualCircle\"></span></div>" ; 
    page << "<div class='grid-item'>Exclamacion &nbsp<span class=\"circle ExclamacionCircle\"></span></div>";  
    page << "<div class='grid-item'>Diferente &nbsp<span class=\"circle DiferenteCircle\"></span></div>" ; 
    page << "<div class='grid-item'>Parentesis Abre&nbsp<span class=\"circle ParentesisAbreCircle\"></span></div>" ; 
    page << "<div class='grid-item'>Parentesis Cierra &nbsp<span class=\"circle ParentesisCierraCircle\"></span></div>";  
    page << "</div>";
    page << "</div>";
    
    page << "<div class='grid-container-token'>";
    page << "<div class='grid-item-token'> Author: Lydia Delgado Uriarte";
    page << "<div class='grid-item-token'>";
    page << val ;
    page << "</div>";
    page.close();
};