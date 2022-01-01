%option noyywrap 

/* Definition Section */
%{
    #include <stdio.h>
%}

/* Rule Section */
%%


"int" {
    printf("TOKEN_INT\n");
}
"char" {
    printf("TOKEN_CHAR\n");
}
"if" {
    printf("TOKEN_IF\n");
}
"else" {
    printf("TOKEN_ELSE\n");
}
"elseif" {
    printf("TOKEN_ELSEIF\n");
}
"while" {
    printf("TOKEN_WHILE\n");
}
"for" {
    printf("TOKEN_FOR\n");
}
"return" {
    printf("TOKEN_RETURN\n");
}
"void" {
    printf("TOKEN_VIOD\n");
}
"main" {
    printf("TOKEN_MAIN\n");
}
"continue" {
    printf("TOKEN_CONTINUE\n");
}
"break" {
    printf("TOKEN_BREAK\n");
}

"." {
    printf("TOKEN_DOT\n");
}
"(" {
    printf("TOKEN_LEFTPAREN\n");
}
")" {
    printf("TOKEN_RIGHTPAREN\n");
}
"{" {
    printf("TOKEN_LBRACE\n");
}
"}" {
    printf("TOKEN_RBRACE\n");
}
"[" {
    printf("TOKEN_LBRACK\n");
}
"]" {
    printf("TOKEN_RBRACK\n");
}
"," {
    printf("TOKEN_?\n");
}

"=" {
    printf("TOKEN_ASSIGN\n");
}
"<" {
    printf("TOKEN_LESS\n");
}
"<=" {
    printf("TOKEN_?\n");
}
"==" {
    printf("TOKEN_EQUAL\n");
}
"!=" {
    printf("TOKEN_NOTEQUAL\n");
}
">" {
    printf("TOKEN_MORE\n");
}
">=" {
    printf("TOKEN_?\n");
}
"|" {
    printf("TOKEN_?\n");
}
"&" {
    printf("TOKEN_?\n");
}
"||" {
    printf("TOKEN_OR\n");
}
"&&" {
    printf("TOKEN_AND\n");
}
"^" {
    printf("TOKEN_?\n");
}
"!" {
    printf("TOKEN_?\n");
}
"+" {
    printf("TOKEN_ADD\n");
}
"-" {
    printf("TOKEN_SUB\n");
}
"*" {
    printf("TOKEN_MUL\n");
}
"/" {
    printf("TOKEN_DIV\n");
}
"#" {
    printf("TOKEN_SLCOMMENT\n");
}
"#!" {
    printf("TOKEN_MLCOMMENTSTART\n");
}
"!#" {
    printf("TOKEN_MLCOMMENTEND\n");
}

[a-zA-Z_][a-zA-Z0-9_]* {
    printf("TOKEN_IDENTIFIER\n");
}
("-"|"")[0-9]+ {
    printf("TOKEN_INT_CONST\n");
}
\"([^\\\"]|\\.)*\" {
    printf("TOKEN_CHAR_CONST\n");
}



%%

/* Code Section */
int main (){
    FILE* f = fopen("test_case1.txt", "r"); 
    yyin = f;
   

    yylex();
    return 0;
}
/* extern FILE *yyin, *yyout;
yyin = fopen("testcasetxt", "r"); 
 yyout = fopen("Phase1_Tokenstxt", "w"); */