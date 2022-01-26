%{
	#include <stdio.h>
	#include <string.h>
	#include "parser.tab.h"

	#define ANSI_COLOR_YELLOW	"\x1b[33m"
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

[-|+]?([1-9][0-9]*|0) 	{ 
        yylval = atoi(yytext);
        /*printf("%d \n", yylval);*/
        if(yylval<=32767 && yylval>=-32767)
        {
            return integer_constant;
        }
        else{
            return off_limit_integer_constant;
        }
 }

[a-zA-Z_][a-zA-Z0-9_]*  {  return identifier;}

[0-9]([a-zA-Z_]|[0-9])* {
    printf(ANSI_COLOR_YELLOW "Error: Invalid numeric constant or identifier at line no. %d\n" ANSI_COLOR_RESET, yylineno) ;
}

{ANYTHING} {
	if(yytext[0]=='#')
	{ 
    	printf(ANSI_COLOR_YELLOW "Error: Unmached comment at line no. %d\n" ANSI_COLOR_RESET,yylineno);
    }
    else if(yytext[0]=='"')
    {
    	printf(ANSI_COLOR_YELLOW "Error: Incomplete character at line no. %d\n" ANSI_COLOR_RESET,yylineno);
    }
    else
    {
    	printf(ANSI_COLOR_YELLOW "Error: Unrecognized character at line no. %d.\n" ANSI_COLOR_RESET, yylineno);
    }
    return 0;
}

%%