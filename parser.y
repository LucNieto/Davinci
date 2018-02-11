%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
	int yylex (void);
	void yyerror(char const *);
	char* strval;
	int num;
	extern char* yytext;
	extern int yylineno;
	int parser();
void ensangrador();
void genera_lenguaje_maquina();
%}

%define parse.lac full
%define parse.error verbose

%union {
  char* strVal;
  int ival;
  float fval;
}

%token <strVal> CADENA
%token <ival> NUMERO
%token <fval> DOBLE
%type <ival> operacion

%token IMPRIME ABRE_PARENTESIS  CIERRA_PARENTESIS  PUNTO_Y_COMA MAS MENOS POR ENTRE AL

%start input

%%
input:
  | input line
  ;

  line:
  IMPRIME ABRE_PARENTESIS CADENA CIERRA_PARENTESIS PUNTO_Y_COMA {
  							FILE *fptr;
							fptr = fopen("emp.c", "w");
							fprintf(fptr, "#include <stdio.h>\n");
							fprintf(fptr, "int main(){\n");
							fprintf(fptr, "\tprintf(%s",$3);
							fprintf(fptr, "\t\t\nreturn 0;\n}");
							fclose(fptr);
							ensangrador();
							genera_lenguaje_maquina();

 							}
	 |IMPRIME ABRE_PARENTESIS operacion CIERRA_PARENTESIS PUNTO_Y_COMA { 
	   							FILE *fptr;
							fptr = fopen("emp.c", "w");
							fprintf(fptr, "#include <stdio.h>\n");
							fprintf(fptr, "int main(){\n");
							fprintf(fptr, "\tprintf(\"%%d \\n \",%d );",$3);
							fprintf(fptr, "\t\t\nreturn 0;\n}");
							fclose(fptr);
							ensangrador();
							genera_lenguaje_maquina();
							}
;

operacion: NUMERO {$$ = $1;}
|NUMERO MAS NUMERO {$$ = $1 + $3;}
|NUMERO MENOS NUMERO {$$ = $1 - $3;}
|NUMERO POR NUMERO {$$ = $1 * $3;}
|NUMERO ENTRE NUMERO {$$ = $1 / $3;}
;
%%

void yyerror(char const *x){
	printf("Error %s in line %d\n", x, yylineno);
	exit(1);
}

void ensangrador(){
	char command[50];
	strcpy( command, "\ngcc -o ensamblador.s -S emp.c " );
   	system(command);
}

void genera_lenguaje_maquina(){
	char command[50];
	strcpy( command, "\ngcc -o ejecutable ensamblador.s " );
   	system(command);  	
}