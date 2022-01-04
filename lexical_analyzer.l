%option noyywrap 

/* Definition Section */
%{
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
    fprintf(output, "TOKEN_INT\n");
}
"char" {
    fprintf(output, "TOKEN_CHAR\n");
}
"if" {
    fprintf(output, "TOKEN_IF\n");
}
"else" {
    fprintf(output, "TOKEN_ELSE\n");
}
"elseif" {
    fprintf(output, "TOKEN_ELSEIF\n");
}
"while" {
    fprintf(output, "TOKEN_WHILE\n");
}
"for" {
    fprintf(output, "TOKEN_FOR\n");
}
"return" {
    fprintf(output, "TOKEN_RETURN\n");
}
"void" {
    fprintf(output, "TOKEN_VOID\n");
}
"main" {
    fprintf(output, "TOKEN_MAIN\n");
}
"continue" {
    fprintf(output, "TOKEN_CONTINUE\n");
}
"break" {
    fprintf(output, "TOKEN_BREAK\n");
}

"." {
    fprintf(output, "TOKEN_DOT\n");
}
"(" {
    fprintf(output, "TOKEN_LEFTPAREN\n");
}
")" {
    fprintf(output, "TOKEN_RIGHTPAREN\n");
}
"{" {
    fprintf(output, "TOKEN_LBRACE\n");
}
"}" {
    fprintf(output, "TOKEN_RBRACE\n");
}
"[" {
    fprintf(output, "TOKEN_LBRACK\n");
}
"]" {
    fprintf(output, "TOKEN_RBRACK\n");
}
"," {
    fprintf(output, "TOKEN_COMMA\n");
}

"=" {
    fprintf(output, "TOKEN_ASSIGN\n");
}
"<" {
    fprintf(output, "TOKEN_LESS\n");
}
"<=" {
    fprintf(output, "TOKEN_LESSOREQUAL\n");
}
"==" {
    fprintf(output, "TOKEN_EQUAL\n");
}
"!=" {
    fprintf(output, "TOKEN_NOTEQUAL\n");
}
">" {
    fprintf(output, "TOKEN_GREATER\n");
}
">=" {
    fprintf(output, "TOKEN_GREATEROREQUAL\n");
}
"|" {
    fprintf(output, "TOKEN_OR\n");
}
"&" {
    fprintf(output, "TOKEN_AND\n");
}
"^" {
    fprintf(output, "TOKEN_XOR\n");
}
"||" {
    fprintf(output, "TOKEN_OR_OP\n");
}
"&&" {
    fprintf(output, "TOKEN_AND_OP\n");
}

"!" {
    fprintf(output, "TOKEN_NOT\n");
}
"+" {
    fprintf(output, "TOKEN_ADD\n");
}
"-" {
    fprintf(output, "TOKEN_SUB\n");
}
"*" {
    fprintf(output, "TOKEN_MUL\n");
}
"/" {
    fprintf(output, "TOKEN_DIV\n");
}
"++" {
    fprintf(output, "TOKEN_INC_OP\n");
}
"--" {
    fprintf(output, "TOKEN_DEC_OP\n");
}
"+=" {
    fprintf(output, "TOKEN_ADD_ASSIGN\n");
}
"-=" {
    fprintf(output, "TOKEN_SUB_ASSIGN\n");
}
"*=" {
    fprintf(output, "TOKEN_MUL_ASSIGN\n");
}
"/=" {
    fprintf(output, "TOKEN_DIV_ASSIGN\n");
}
"&=" {
    fprintf(output, "TOKEN_AND_ASSIGN\n");
}
"|=" {
    fprintf(output, "TOKEN_OR_ASSIGN\n");
}
"^=" {
    fprintf(output, "TOKEN_XOR_ASSIGN\n");
}

\"([^"\\\r\n]|[\\]{ANYTHING})*\" {
    fprintf(output, "TOKEN_CHAR_CONST\n");
}
[-|+]?([1-9][0-9]*|0) {
    fprintf(output, "TOKEN_INT_CONST\n");
}
[a-zA-Z_][a-zA-Z0-9_]* {
    fprintf(output, "TOKEN_IDENTIFIER\n");
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
    FILE* input = fopen("./Test Cases/test1.txt", "r"); 
    yyin = input;
    output = fopen("Phase1_Tokens.txt", "w");
    fprintf(output,  "The resulted tokens are:\n");
    yylex();
    fclose(output);
    fclose(input);
    return 0;
}