%option noyywrap 

/* Definition Section */
%{
    #include <parser.tab.h>
    #include <stdio.h>
    FILE *output;
    int line_count = 1;
%}


NEWLINE \r?\n
ANYTHING_EXCEPT_NEWLINE [^\r\n]

ANYTHING ({ANYTHING_EXCEPT_NEWLINE}|{NEWLINE})
BLOCK_COMMENT \#\!([^!]|[\r\n]|(\!+([^!#]|[\r\n])))*\!+\#
SINGLE_LINE_COMMENT "#"[^!].*

/* Rule Section */
%%
{NEWLINE} {line_count++;}
[ \f\v\r\t]+ {}

{BLOCK_COMMENT} | 
{SINGLE_LINE_COMMENT}  {} 

"int" {
    return(INT);
}
"char" {
    return(CHAR);
}
"if" {
    return(IF);
}
"else" {
    return(ELSE);
}
"elseif" {
    return(ELSEIF);
}
"while" {
    return(WHILE);
}
"for" {
    return(FOR);
}
"return" {
    return(RETURN);
}
"void" {
    return(VOID);
}
"main" {
    return(MAIN);
}
"continue" {
    return(CONTINUE);
}
"break" {
    return(BREAK);
}

"." {
    return('.');
"(" {
    return('(');
}
")" {
    return(')');
}
"{" {
    return('{');
}
"}" {
    return('}');
}
"[" {
    return('[');
}
"]" {
    return(']');
}
"," {
    return(',');
}

"=" {
    return(ASSIGN);
}
"<" {
    return(LESS);
}
"<=" {
    return(LESSOREQUAL);
}
"==" {
    return(EQUAL);
}
"!=" {
    return(NOTEQUAL);
}
">" {
    return(GREATER);
}
">=" {
    return(GREATEROREQUAL);
}
"|" {
    return(OR);
}
"&" {
    return(AND);
}
"^" {
    return(XOR);
}
"||" {
    return(OR_OP);
}
"&&" {
    return(AND_OP);
}

"!" {
    return(NOT);
}
"+" {
    return(ADD);
}
"-" {
    return(SUB);
}
"*" {
    return(MUL);
}
"/" {
    return(DIV);
}
"++" {
    return(INC_OP);
}
"--" {
    return(DEC_OP);
}
"+=" {
    return(ADD_ASSIGN);
}
"-=" {
    return(SUB_ASSIGN);
}
"*=" {
    return(MUL_ASSIGN);
}
"/=" {
    return(DIV_ASSIGN);
}
"&=" {
    return(AND_ASSIGN);
}
"|=" {
    return(OR_ASSIGN);
}
"^=" {
    return(XOR_ASSIGN);
}

\"([^"\\\r\n]|[\\]{ANYTHING})*\" {
    return(CHAR_CONST);
}
[-|+]?([1-9][0-9]*|0) {
    return(INT_CONST);
}
[a-zA-Z_][a-zA-Z0-9_]* {
    return(IDENTIFIER);
}
[0-9]([a-zA-Z_]|[0-9])* {
    fprintf(output, "Error: Invalid numeric constant or identifier.\n");
}

{ANYTHING} {
	if(yytext[0]=='#')
	{ 
    	fprintf(output,"Error: Unmached comment at line no. %d\n",line_count);
    }
    else if(yytext[0]=='"')
    {
    	fprintf(output,"Error: Incomplete character at line no. %d\n",line_count);
    }
    else
    {
    	fprintf(output,"Error: Unrecognized character at lone no. %d.\n", line_count);
    }
    return 0;
}

%%

/* Code Section */
int main (){
    FILE* input = fopen("./Test Cases/test7.txt", "r"); 
    yyin = input;
    output = fopen("Phase1_Tokens.txt", "w");
    fprintf(output,  "The resulted tokens are:\n");
    yylex();
    fclose(output);
    fclose(input);
    return 0;
}