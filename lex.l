%{
	#include "parser.tab.h"
	#include <string.h>
	extern char* yytext;
%}

espacio      [ \t\r\v\f]
salto_de_linea        \n

%%



[0-9]+		{yylval.ival = atoi(yytext); return NUMERO;}

"/*"((\*+[^/*])|([^*]))*\**"*/" 	{;}
"//".* {;}
;	{return PUNTO_Y_COMA;}
"imprime" {return IMPRIME ;}
"(" { return ABRE_PARENTESIS; }
")" { return CIERRA_PARENTESIS; }
\"(\\.̣|[^"])*\"  { yylval.strVal = yytext;return  CADENA;}
"+"	{return MAS;}
"-"	{return MENOS;}
"*"	{return POR;}
"/"	{return ENTRE;}
"^"	{return AL;}

{salto_de_linea}                        {yylineno++;}
{espacio}                                    {;}
.				printf("%s es caracter desconocido\n",yytext);
%%



int yywrap(void){
	return 1;
}

