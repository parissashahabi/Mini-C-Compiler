
%{
    void yyerror(char* s);
    int yylex();
    #include <stdio.h>
    FILE *output;
    int flag=0;
%}



%nonassoc IF ELSEIF CONTINUE
%token INT CHAR
%token RETURN MAIN
%token VOID
%token WHILE FOR
%token BREAK

%token IDENTIFIER
%token INT_CONST CHAR_CONST


%nonassoc ELSE

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
            type_specifier variable_declaration_list 'D';

variable_declaration_list :
            variable_declaration_identifier V;

V :
            'C' variable_declaration_list
            | ;

variable_declaration_identifier :
            IDENTIFIER vdi;

vdi : 
            identifier_array_type 
            | ASSIGN expression ; 

identifier_array_type :
            'L' initilization_params
            | ;

initilization_params :
            INT_CONST 'R' initilization
            | 'R' string_initilization;

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
            type_specifier IDENTIFIER 'S';

function_declaration_param_statement :
            params 'P' statement;

params :
            parameters_list 
            | ;

parameters_list :
            type_specifier parameters_identifier_list;

parameters_identifier_list :
            param_identifier parameters_identifier_list_breakup;

parameters_identifier_list_breakup :
            'C' parameters_list
            | ;

param_identifier : 
            IDENTIFIER param_identifier_breakup;

param_identifier_breakup :
            'L' 'R'
            | ;

statement :
            expression_statment | compound_statement
            | conditional_statements | iterative_statements
            | return_statement | break_statement
            | variable_declaration;

compound_statement : 
            'W' statment_list 'Q' ;

statment_list : 
            statement statment_list
            | ;

expression_statment : 
            expression 'D'
            | 'D' ;

conditional_statements : 
            IF 'S' simple_expression 'P' statement conditional_statements_breakup;

conditional_statements_breakup : 
            ELSE statement
            | ;

iterative_statements : 
            WHILE 'S' simple_expression 'P' statement
            | FOR 'S' expression 'C' simple_expression 'C' expression 'P' ;

return_statement : 
            RETURN return_statement_breakup;

return_statement_breakup : 
            'D'
            | expression 'D' ;

break_statement : 
            BREAK 'D' ;

string_initilization : 
            ASSIGN CHAR_CONST;

array_initialization : 
            ASSIGN 'W' array_int_declarations 'Q' ;

array_int_declarations : 
            INT_CONST array_int_declarations_breakup;

array_int_declarations_breakup : 
            'C' array_int_declarations
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
            'L' expression 'R'
            | 'D' IDENTIFIER;

immutable : 
            'S' expression 'P'
            | call 
            | constant;

call : 
            IDENTIFIER 'S' arguments 'P' ;

arguments : 
            arguments_list 
            | ;

arguments_list : 
            expression A;

A : 
            'C' expression A
            | ;

constant :
            INT_CONST
            | CHAR_CONST;

%%

extern FILE *yyin;
extern int yylineno;
extern char *yytext;

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

void yyerror(char *s){

    fprintf (output, "Error happend %s %d %s",s, yylineno, yytext);
}