%option noyywrap 

/* Definition Section */
%{
    #include "parser.tab.h"
    #include <stdio.h>
    /* FILE *output; */
    int line_count = 1;
%}


NEWLINE \r?\n
ANYTHING_EXCEPT_NEWLINE [^\r\n]

ANYTHING ({ANYTHING_EXCEPT_NEWLINE}|{NEWLINE})
BLOCK_COMMENT \#\!([^!]|[\r\n]|(\!+([^!#]|[\r\n])))*\!+\#
SINGLE_LINE_COMMENT "#"[^!].*

/* Rule Section */
%%
{NEWLINE} {yylineno++;}
[ \f\v\r\t]+ {}

{BLOCK_COMMENT} | 
{SINGLE_LINE_COMMENT}  {printf(" /newl: %s", yytext);} 


"int" {
    printf(" /inti: %s", yytext);
    return INT;
}
"char" {
    return CHAR;
}
"if" {
    return IF;
}
"else" {
    return ELSE;
}
"elseif" {
    return ELSEIF;
}
"while" {
    return WHILE;
}
"for" {
    return FOR;
}
"return" {
    return RETURN ;
}
"void" {
    return VOID ;
}
"continue" {
    return CONTINUE;
}
"break" {
    return BREAK;
}

"." {
    printf(" /dot: %s", yytext);
    return ('D') ;
}
"(" {
    printf(" /leftp: %s", yytext);
    return ('S');
}
")" {
    printf(" /rightp: %s", yytext);
    return ('P');
}
"{" {
    printf(" /lrftb: %s", yytext);
    return ('W');
}
"}" {
    printf(" /rightb: %s", yytext);
    return ('Q');
}
"[" {
    return ('L');
}
"]" {
    return ('R');
}
"," {
    return ('C');
}

"=" {

    printf(" /assign: %s", yytext);
    return ASSIGN;
}
"<" {
    return LESS;
}
"<=" {
    return LESSOREQUAL;
}
"==" {
    return EQUAL;
}
"!=" {
    return NOTEQUAL;
}
">" {
    return GREATER;
}
">=" {
    return GREATEROREQUAL;
}
"|" {
    return OR;
}
"&" {
    return AND;
}
"^" {
    return XOR;
}
"||" {
    return OR_OP;
}
"&&" {
    return AND_OP;
}

"!" {
    return NOT;
}
"+" {
    printf(" /add: %s", yytext);
    return ADD;
}
"-" {
    return SUB;
}
"*" {
    printf(" /mult: %s", yytext);
    return MUL;
}
"/" {
    return DIV;
}
"++" {
    return INC_OP;
}
"--" {
    return DEC_OP;
}
"+=" {
    return ADD_ASSIGN;
}
"-=" {
    return SUB_ASSIGN;
}
"*=" {
    return MUL_ASSIGN;
}
"/=" {
    return DIV_ASSIGN;
}
"&=" {
    return AND_ASSIGN;
}
"|=" {
    return OR_ASSIGN;
}
"^=" {
    return XOR_ASSIGN;
}

\"([^"\\\r\n]|[\\]{ANYTHING})*\" {
    return CHAR_CONST;
}
[-|+]?([1-9][0-9]*|0) {
    printf(" /intconst: %s", yytext);
    return INT_CONST;
}
[a-zA-Z_][a-zA-Z0-9_]* {
    printf(" /id: %s", yytext);
    return IDENTIFIER;
}
[0-9]([a-zA-Z_]|[0-9])* {
    printf("Error: Invalid numeric constant or identifier.\n");
}

{ANYTHING} {
	if(yytext[0]=='#')
	{ 
    	printf("Error: Unmached comment at line no. %d\n",line_count);
    }
    else if(yytext[0]=='"')
    {
    	printf("Error: Incomplete character at line no. %d\n",line_count);
    }
    else
    {
    	printf("Error: Unrecognized character at lone no. %d.\n", line_count);
    }
    return 0;
}

%%

