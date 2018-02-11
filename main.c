#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "parser.tab.h"
//llamado a las funciones del parser, yylex regresa el numero de token y el valor que contiene
//yyline regresa el numero de la línea

extern int yylineno;
extern char* yytext;
extern int yylex();
extern int yyparse();
extern FILE* yyin;

int main(void){
		yyin = stdin;
	do { 
	yyparse();
	} while(!feof(yyin));
	//printf("%s\n",value );
	return 0;
}

