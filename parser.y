
%{
    void yyerror(char* s);
    int yylex();
    #include <stdio.h>
    FILE *output;
%}

%token IDENTIFIER INT_CONST CHAR_CONST FOR WHILE IF ELSEIF ELSE
%token VOID INT CHAR BREAK CONTINUE
%token MAIN RETURN
%token DOT COMMA RIGHTBEACK LEFTBRACK RIGHTBRACE LEFTBRACE RIGHTPAREN LEFTPAREN

%right XOR_ASSIGN OR_ASSIGN
%right AND_ASSIGN
%right MUL_ASSIGN DIV_ASSIGN
%right ADD_ASSIGN SUB_ASSIGN
%right ASSIGN

%left OR_OP
%left AND_OP
%left OR
%left XOR
%left AND
%left EQUAL NOTEQUAL
%left LESSOREQUAL LESS GREATEROREQUAL GREATER
%left ADD SUB
%left MUL DIV
%right NOT
%left INC_OP DEC_OP
%start program

%%
program : 
            declaration_list;

declaration_list : 
            declaration D;

D :
            declaration_list
            | ;

declaration :
            variable_declaration
            | function_declaration;

variable_declaration :
            type_specifier variable_declaration_list DOT;

variable_declaration_list :
            variable_declaration_identifier V;

V :
            COMMA variable_declaration_list
            | ;

variable_declaration_identifier :
            IDENTIFIER identifier_array_type
            | expression;

identifier_array_type :
            LEFTBRACK initilization_params
            | ;

initilization_params :
            INT_CONST RIGHTBEACK initilization
            | RIGHTBEACK string_initilization;

initilization :
            string_initilization
            | array_initialization
            | ;

type_specifier :
            INT
            | CHAR
            | VOID;

function_declaration :
            function_declaration_type function_declaration_param_statement;

function_declaration_type :
            type_specifier IDENTIFIER LEFTPAREN;

function_declaration_param_statement :
            params RIGHTPAREN statement;

params :
            parameters_list 
            | ;

parameters_list :
            type_specifier parameters_identifier_list;

parameters_identifier_list :
            param_identifier parameters_identifier_list_breakup;

parameters_identifier_list_breakup :
            COMMA parameters_list
            | ;

param_identifier : 
            IDENTIFIER param_identifier_breakup;

param_identifier_breakup :
            LEFTBRACK RIGHTBEACK
            | ;

statement :
            expression_statment | compound_statement
            | conditional_statements | iterative_statements
            | return_statement | break_statement
            | variable_declaration;

compound_statement : 
            LEFTBRACE statment_list RIGHTBRACE ;

statment_list : 
            statement statment_list
            | ;

expression_statment : 
            expression DOT
            | DOT ;

conditional_statements : 
            IF LEFTPAREN simple_expression RIGHTPAREN statement
            conditional_statements_breakup;

conditional_statements_breakup : 
            ELSE statement
            | ;

iterative_statements : 
            WHILE LEFTPAREN simple_expression RIGHTPAREN statement
            | FOR LEFTPAREN expression COMMA simple_expression COMMA expression RIGHTPAREN ;

return_statement : 
            RETURN return_statement_breakup;

return_statement_breakup : 
            DOT
            | expression DOT ;

break_statement : 
            BREAK DOT ;

string_initilization : 
            ASSIGN CHAR_CONST;

array_initialization : 
            ASSIGN LEFTBRACE array_int_declarations RIGHTBRACE ;

array_int_declarations : 
            INT_CONST array_int_declarations_breakup;

array_int_declarations_breakup : 
            COMMA array_int_declarations
            | ;

expression : 
            mutable expression_breakup
            | simple_expression ;

expression_breakup : 
            ASSIGN expression
            | ADD_ASSIGN expression
            | SUB_ASSIGN expression
            | MUL_ASSIGN expression
            | DIV_ASSIGN expression
            | INC_OP
            | DEC_OP ;

simple_expression : 
            and_expression simple_expression_breakup;

simple_expression_breakup : 
            OR_OP and_expression simple_expression_breakup 
            | ;

and_expression : 
            unary_relation_expression and_expression_breakup;

and_expression_breakup : 
            AND_OP unary_relation_expression and_expression_breakup
            | ;

unary_relation_expression : 
            NOT unary_relation_expression
            | regular_expression ;

regular_expression : 
            sum_expression regular_expression_breakup;

regular_expression_breakup : 
            relational_operators sum_expression
            | ;

relational_operators : 
            GREATEROREQUAL
            | LESSOREQUAL 
            | GREATER
            | LESS
            | EQUAL
            | NOTEQUAL;

sum_expression : 
            sum_expression sum_operators term
            | term ;

sum_operators : 
            ADD
            | SUB ;

term : 
            term MULOP factor
            | factor ;

MULOP : 
            MUL
            | DIV ;

factor : 
            immutable 
            | mutable ;

mutable : 
            IDENTIFIER
            | mutable mutable_breakup;

mutable_breakup : 
            LEFTBRACK expression RIGHTBEACK
            | DOT IDENTIFIER;

immutable : 
            LEFTPAREN expression RIGHTPAREN
            | call 
            | constant;

call : 
            IDENTIFIER LEFTPAREN arguments RIGHTPAREN ;

arguments : 
            arguments_list 
            | ;

arguments_list : 
            expression A;

A : 
            COMMA expression A
            | ;

constant :
            INT_CONST
            | CHAR_CONST;

%%

extern FILE *yyin;
extern int yylineno;

void yyerror(char *s){
    fprintf (output, "Error happend %s %d",s, yylineno);
}

/* Code Section */
int main (){
    FILE* input = fopen("./Test Cases/test2.txt", "r"); 
    yyin = input;
    output = fopen("Phase1_Tokens.txt", "w");
    fprintf(output,  "results are:\n");
    yyparse();
    fclose(output);
    fclose(input);
    return 0;
}