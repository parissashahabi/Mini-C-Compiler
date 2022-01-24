
%{
    #include <stdio.h>
%}

%token IDENTIFIER INT_CONST CHAR_CONST FOR WHILE IF ELSEIF ELSE
%token VOID INT CHAR BREAK
%token MAIN RETURN

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
            type_specifier variable_declaration_list ​ '.';

variable_declaration_list :
            variable_declaration_identifier V;

V :
            ','​ variable_declaration_list
            | ;

variable_declaration_identifier :
            identifier { ins(); } identifier_array_type
            | expression { ins(); };

identifier_array_type :
            '['​ initilization_params
            | ;

initilization_params :
            integer_constant ​ ']'​ initilization
            | ​ ']'​ string_initilization;

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
            type_specifier identifier ​ '(' { ins();};

function_declaration_param_statement :
            params ​ ')'​ statement;

params :
            parameters_list | ;

parameters_list :
            type_specifier parameters_identifier_list;

parameters_identifier_list :
            param_identifier parameters_identifier_list_breakup;

parameters_identifier_list_breakup :
            ','​ parameters_list
            | ;

param_identifier : 
            identifier { ins(); } param_identifier_breakup;

param_identifier_breakup : ​ 
            '['​ ​ ']'
            | ;

statement :
            expression_statment | compound_statement
            | conditional_statements | iterative_statements
            | return_statement | break_statement
            | variable_declaration;

compound_statement : 
            '{'​ statment_list ​ '}'​ ;

statment_list : 
            statement statment_list
            | ;

expression_statment : 
            expression ​ '.'
            | ​ '.'​ ;

conditional_statements : 
            IF ​ '('​ simple_expression ​ ')'​ statement
            conditional_statements_breakup;

conditional_statements_breakup : 
            ELSE statement
            | ;

iterative_statements : 
            WHILE ​ '('​ simple_expression ​ ')'​ statement
            | FOR ​ '('​ expression ​ ','​ simple_expression ​ ','​ expression ​ ')'
            | DO statement WHILE ​ '('​ simple_expression ​ ')'​ ​ '.'​ ;

return_statement : 
            RETURN return_statement_breakup;

return_statement_breakup : 
            '.'
            | expression ​ '.'​ ;

break_statement : 
            BREAK ​ '.'​ ;

string_initilization : 
            assignment_operator string_constant { insV(); };

array_initialization : 
            assignment_operator ​ '{'​ array_int_declarations ​ '}'​ ;

array_int_declarations : 
            integer_constant array_int_declarations_breakup;

array_int_declarations_breakup : 
            ','​ array_int_declarations
            | ;

expression : 
            mutable​ expression_breakup
            | simple_expression ;

expression_breakup : 
            assignment_operator expression
            | addition_assignment_operator expression
            | subtraction_assignment_operator expression
            | multiplication_assignment_operator expression
            | division_assignment_operator expression
            | modulo_assignment_operator expression
            | increment_operator
            | decrement_operator ;

simple_expression : 
            and_expression simple_expression_breakup;

simple_expression_breakup : 
            OR_operator and_expression simple_expression_breakup 
            | ;

and_expression : 
            unary_relation_expression and_expression_breakup;

and_expression_breakup : 
            AND_operator unary_relation_expression and_expression_breakup
            | ;

unary_relation_expression : 
            exclamation_operator unary_relation_expression
            | regular_expression ;

regular_expression : 
            sum_expression regular_expression_breakup;

regular_expression_breakup : 
            relational_operators sum_expression
            | ;

relational_operators : 
            greaterthan_assignment_operator 
            | lessthan_assignment_operator 
            | greaterthan_operator
            | lessthan_operator 
            | equality_operator 
            | inequality_operator;

sum_expression : 
            sum_expression sum_operators term
            | term ;

sum_operators : 
            add_operator
            | subtract_operator ;

term : 
            term MULOP factor
            | factor ;

MULOP : 
            multiplication_operator 
            | division_operator 
            |modulo_operator ;

factor : 
            immutable 
            | ​ mutable​ ;

mutable : 
            identifier
            | mutable​ mutable_breakup;

mutable_breakup : 
            '['​ expression ​ ']'
            | '.'​ identifier;

immutable : 
            '('​ expression ​ ')'
            | call 
            | constant;

call : 
            identifier ​ '('​ arguments ​ ')'​ ;

arguments : 
            arguments_list 
            | ;

arguments_list : 
            expression A;

A : 
            ','​ expression A
            | ;

constant :
            integer_constant { insV(); }
            | string_constant { insV(); }
            | character_constant { insV(); };

%%

void yyerror(char *s){
    printf ("Error happend %s",s)
}

int main(void){
    yyparse();
}