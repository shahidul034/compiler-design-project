/* author: shakib1507034 */

%{
	#include<stdio.h>
	#include <string.h>
	#include "main.tab.h"
	#include<stdlib.h>
	

%}

/*RE and Action*/

%%
"{"	 { 
//printf("LB");
return LB; }
"}"	  { 
//printf("RB");
return RB; }
"COLON"   {return COLON;}
"BREAK"    {    return BREAK;     }
"CASE"      { return CASE;      }
"select"      { return SWITCH;	}
"DEFAULT"     {  return DEFAULT; 	}
"WHILE"  {return WHILE;}
"int"	{ return INT; }
"float"	{ return FLOAT; }
"char"	{ return CHAR; }
":"     {return COL;}
[0-9]+	{ 
		yylval.number = atoi(yytext);
		return NUM;
	}
"FOR"   {return FOR;}	
"LP"	{ return LP; }
"RP"	{ return RP; }

"cm"	{ return CM; }
"$$"	{ return SM; }
"jog"	{ return PLUS; }
"biyog"	{ return MINUS; }
"goon"	{ return MULT; }
"bag"	{ return DIV; }
"="	{ return ASSIGN;  }
">>"	{ return GT; }
"<<"	{ return LT; }

[a-z]+  {
	 yylval.string=strdup(yytext);return VAR;
	}

"IF"		{ return IF;		}
"ELSE"		{ return ELSE;		}

"function @func_name"	{ return VOIDMAIN; }

[ \t\n]*	

.	{
	//printf("error: %s\n",*yytext);
		yyerror("Unknown Character.\n");
	}
%%

/* user subroutines */

int main()
{
	yyin = freopen("a.txt","r",stdin);
	yyout = freopen("out.txt","w",stdout);
	yyparse();

}

