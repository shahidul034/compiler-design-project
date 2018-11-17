/* author: shakib1507034 */

%{
	#include<stdio.h>
	#include <string.h>
	#include "main.tab.h"
	#include<stdlib.h>
	int _user_function=0,keyword=0,_identifiers=0,_arithmatic_operator=0,_unary_operator=0,_logical_operator=0,_relational_operator=0,_assignment_operator=0,_library_function=0,_datatype=0,_loop=0,cndstatement=0,_integer=0,floatnum=0,_string=0,scmnt=0,mcmnt=0,newl=0;

%}

Datatype "int"|"float"
identifiers "prince"[a-zA-Z]([a-zA-Z0-9])*
arithmatic_operator "jog"|"biyog"|"goon"|"bag"|"exp"
unary_operator "~++"|"~--"|"~~"|"~!"|"~+"|"~-"
logical_operator [&][&]|[|][|]|[!][!]
relational_operator "<<"|">>"|"<<="|">>="|"=="|"!="
assignment_operator [=]|"+="|"-="|"/="
import "import "[a-zA-Z]([a-zA-Z0-9])*
library_function "TAKEIN<"|"SHOWOUT>"
user_function "function"
conditional_statement "IF"|"ELSE"|"ELIF"|"WHILE"
integer (-|\+)?[0-9]+
float [+-]?[0-9]+[.][0-9]+|[+-]?[.][0-9]+|[1-9]+e[+-][0-9]+
single_line_comment [/][/].*
multiple_line_comment [ ]*[/][m][/][a-zA-Z0-9!@#*(){}_+-,.:\|?><\n\t ]*[/][m][/]

/*RE and Action*/

%%
"inout"   {return inpit;}
"import"  {return importtt;}

{single_line_comment} {
printf("single line comment\n");
scmnt++;
}
{multiple_line_comment} {
mcmnt++;
printf("multiple_line_comment");
}

"~++"    {_unary_operator++;return inc;}
"{"	 {
keyword++ ;

return LB; }
"}"	  { 
keyword++ ;
return RB; }
"COLON"   {keyword++ ;return COLON;}
"BREAK"    {  keyword++ ;  return BREAK;     }
"CASE"      { keyword++ ;return CASE;      }
"select"      { keyword++ ;return SWITCH;	}
"DEFAULT"     {  keyword++ ;return DEFAULT; 	}
"WHILE"  {keyword++ ;return WHILE;}
"int"	{ keyword++ ;_datatype++;return INT; }
"float"	{ keyword++ ;_datatype++;return FLOAT; }
"char"	{ keyword++ ;_datatype++;return CHAR; }
":"     {keyword++ ;return COL;}
[0-9]+	{ 
		yylval.number = atoi(yytext);
		return NUM;
	}
"FOR"   {keyword++ ;return FOR;}	
"LP"	{keyword++ ; return LP; }
"RP"	{keyword++ ; return RP; }

"cm"	{ keyword++ ;return CM; }
"$$"	{ newl++;keyword++ ;return SM; }
"jog"	{ keyword++ ;_arithmatic_operator++;
//printf("jog\n");
return PLUS; 
}
"biyog"	{ keyword++ ;_arithmatic_operator++;
//printf("biyog\n");
return MINUS; }
"goon"	{ keyword++ ;_arithmatic_operator++;
//printf("goon\n");
return MULT; }
"bag"	{ keyword++ ;_arithmatic_operator++;
//printf("bag\n");
return DIV; }
"="	{ _relational_operator++;keyword++;return ASSIGN;  }
">>"	{_relational_operator++; keyword++ ;return GT; }
"<<"	{ _relational_operator++;keyword++ ;return LT; }

[a-z]+  {
_identifiers++;
	 yylval.string=strdup(yytext);return VAR;
	}

"IF"		{ cndstatement++;keyword++ ;return IF;		}
"ELSE"		{ cndstatement++;keyword++ ;return ELSE;		}

"function @func_name"	{ keyword++ ;return VOIDMAIN; }

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
	printf("\nIdentfiers=%d\narithmatic_operator=%d\nunary_operator=%d\n_logical_operator=%d\nrelational_operator=%d\nassignment_operator=%d\nlibrary_function=%d\ndatatype=%d\nloop=%d\nconditional_statement=%d\ninteger=%d\nfloatnum=%d\nNewLine=%d\nmcmnt=%d\n_user_function=%d\nKeyword=%d\nSingle line comment=%d\n",_identifiers,_arithmatic_operator,_unary_operator,_logical_operator,_relational_operator,_assignment_operator,_library_function,_datatype,_loop,cndstatement,_integer,floatnum,newl,mcmnt,_user_function,keyword,scmnt);

}

