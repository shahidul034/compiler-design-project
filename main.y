/* author: shakib1507034 */

%{
	#include<stdio.h>
	//int sym[26],store[26];
	int cnt=1;
	typedef struct entry {
    char *str;
    int n;
	}dict;
	dict store[1000],sym[1000];
	void inskorlam (dict *p, char *s, int n);
	
	int cnt2=1; 
	void inskorlam2 (dict *p, char *s, int n);
	
%}
%union 
{
        int number;
        char *string;
}
/* BISON Declarations */

%token <number> NUM
%token <string> VAR 
%token <string> IF ELSE VOIDMAIN INT FLOAT CHAR LP RP LB RB CM SM PLUS MINUS MULT DIV ASSIGN
%type <string> statement
%type <number> expression
%nonassoc IFX
%nonassoc ELSE
%left LT GT
%left PLUS MINUS
%left MULT DIV
/* Simple grammar rules */

%%

program: VOIDMAIN LP RP LB cstatement RB { printf("\nsuccessful compilation\n"); }
	 ;

cstatement: /* empty */

	| cstatement statement
	
	| cdeclaration
	;

cdeclaration:	TYPE ID1 SM	{ printf("\nvalid declaration\n"); }
			;
			
TYPE : INT

     | FLOAT

     | CHAR
     ;

ID1  : ID1 CM VAR	{
						if(number_for_key($3) == 1)
						{
							printf("%s is already declared\n", $3 );
						}
						else
						{
							inskorlam(&store[cnt],$3, cnt);
							cnt++;
							
						}
			}

     |VAR	{
				if(number_for_key($1) == 1)
				{
					printf("%s is already declared\n", $1  );
				}
				else
				{
					inskorlam (&store[cnt],$1, cnt);
							cnt++;
				}
			}
     ;

statement: SM

	| expression SM 			{ printf("\nvalue of expression: %d\n", ($1)); }

        | VAR ASSIGN expression SM 		{ 
							inskorlam2(&sym[$3], $1, $3);
							
							 
							printf("\nValue of the variable: %d\t\n",$3);
						}

	| IF LP expression RP LB expression SM RB %prec IFX {
								if($3)
								{
									printf("\nvalue of expression in IF: %d\n",($6));
								}
								else
								{
									printf("\ncondition value zero in IF block\n");
								}
							}

	| IF LP expression RP LB expression SM RB ELSE LB expression SM RB {
								 	if($3)
									{
										printf("\nvalue of expression in IF: %d\n",$6);
									}
									else
									{
										printf("\nvalue of expression in ELSE: %d\n",$11);
									}
								   }
	;

expression: NUM				{ $$ = $1; 	}

	| VAR				{ $$ = number_for_key2($1); }

	| expression PLUS expression	{ $$ = $1 + $3; }

	| expression MINUS expression	{ $$ = $1 - $3; }

	| expression MULT expression	{ $$ = $1 * $3; }

	| expression DIV expression	{ 	if($3) 
				  		{
				     			$$ = $1 / $3;
				  		}
				  		else
				  		{
							$$ = 0;
							printf("\ndivision by zero\t");
				  		} 	
				    	}

	| expression LT expression	{ $$ = $1 < $3; }

	| expression GT expression	{ $$ = $1 > $3; }

	| LP expression RP		{ $$ = $2;	}
	;
%%
//////////////////////////
void inskorlam (dict *p, char *s, int n)
{
  p->str = s;
  p->n = n;
}

int
number_for_key(char *key)
{
    int i = 1;
    char *name = store[i].str;
    while (name) {
        if (strcmp(name, key) == 0)
            return store[i].n;
        name = store[++i].str;
    }
    return 0;
}
/////////////////////////
void inskorlam2 (dict *p, char *s, int n)
{
  p->str = s;
  p->n = n;
}

int
number_for_key2(char *key)
{
    int i = 1;
    char *name = sym[i].str;
    while (name) {
        if (strcmp(name, key) == 0)
            return sym[i].n;
        name = sym[++i].str;
    }
    return 0;
}

///////////////////////////


int yywrap()
{
return 1;
}


yyerror(char *s){
	printf( "%s\n", s);
}

