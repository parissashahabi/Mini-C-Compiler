%{
	#include <stdio.h>
	#include <string.h>
	#include "parser.tab.h"

	#define ANSI_COLOR_RED		"\x1b[31m"
	#define ANSI_COLOR_GREEN	"\x1b[32m"
	#define ANSI_COLOR_YELLOW	"\x1b[33m"
	#define ANSI_COLOR_BLUE		"\x1b[34m"
	#define ANSI_COLOR_MAGENTA	"\x1b[35m"
	#define ANSI_COLOR_CYAN		"\x1b[36m"
	#define ANSI_COLOR_RESET	"\x1b[0m"

%}

NEWLINE \r?\n
ANYTHING_EXCEPT_NEWLINE [^\r\n]

ANYTHING ({ANYTHING_EXCEPT_NEWLINE}|{NEWLINE})
BLOCK_COMMENT \#\!([^!]|[\r\n]|(\!+([^!#]|[\r\n])))*\!+\#
SINGLE_LINE_COMMENT "#"[^!].*

%%
\n 	{yylineno++;}

{BLOCK_COMMENT} | 
{SINGLE_LINE_COMMENT}  {} 
[ \n\t] ;
";"				{ return(';'); }
","				{ return(','); }
("{")			{ return('{'); }
("}")			{ return('}'); }
"("				{ return('('); }
")"				{ return(')'); }
("["|"<:")		{ return('['); }
("]"|":>") 		{ return(']'); }
":"				{ return(':'); }
"."				{ return('.'); }



"else"			{ return ELSE;}
"while"			{ return WHILE;}
"for"			{ return FOR;}
"if"			{ return IF;}
"elseif"		{ return ELSEIF;}

"int"			{ return INT;}
"char"			{ return CHAR;}
"return"		{ return RETURN;}
"void"			{ return VOID;}
"main"          { return MAIN;}
"break"			{ return BREAK;}
"continue"      { return CONTINUE;}

"++"			{ return increment_operator; }
"--"			{ return decrement_operator; }
"<="			{ return lessthan_assignment_operator; }
"<"				{ return lessthan_operator; }
">="			{ return greaterthan_assignment_operator; }
">"				{ return greaterthan_operator; }
"=="			{ return equality_operator; }
"!="			{ return inequality_operator; }
"&&"			{ return AND_operator; }
"||"			{ return OR_operator; }
"^"				{ return caret_operator; }
"*="			{ return multiplication_assignment_operator; }
"/="			{ return division_assignment_operator; }
"+="			{ return addition_assignment_operator; }
"-="			{ return subtraction_assignment_operator; }
"&="			{ return AND_assignment_operator; }
"^="			{ return XOR_assignment_operator; }
"|="			{ return OR_assignment_operator; }
"&"				{ return amp_operator; }
"!"				{ return exclamation_operator; }
"-"				{ return subtract_operator; }
"+"				{ return add_operator; }
"*"				{ return multiplication_operator; }
"/"				{ return division_operator; }
"|"				{ return pipe_operator; }
\=				{ return assignment_operator;}

\"([^"\\\r\n]|[\\]{ANYTHING})*\" 			{return string_constant;}
[-|+]?([1-9][0-9]*|0) 	{ return integer_constant;}
[a-zA-Z_][a-zA-Z0-9_]*  {  return identifier;}

{ANYTHING} {
	if(yytext[0]=='#')
	{ 
    	printf("Error: Unmached comment at line no. %d\n",yylineno);
    }
    else if(yytext[0]=='"')
    {
    	printf("Error: Incomplete character at line no. %d\n",yylineno);
    }
    else
    {
    	printf("Error: Unrecognized character at lone no. %d.\n", yylineno);
    }
    return 0;
}

%%