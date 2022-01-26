%{
	void yyerror(char* s);
	int yylex();

	#include "stdio.h"
	#include "stdlib.h"
	
	int flag=0;
	int isMainUsed=0;

	FILE *output;

	#define ANSI_COLOR_RED		"\x1b[31m"
	#define ANSI_COLOR_GREEN	"\x1b[32m"
	#define ANSI_COLOR_RESET	"\x1b[0m"

%}

%nonassoc IF
%token INT CHAR
%token RETURN MAIN
%token VOID
%token WHILE FOR 
%token BREAK CONTINUE
%expect 4

%token identifier
%token integer_constant string_constant off_limit_integer_constant
%token UNMACHED_COMMENT_ERROR INCOMPLETE_CHARACTER_ERROR UNRECOGNIZED_CHARACTER_ERROR

%nonassoc ELSEIF 
%nonassoc ELSE 
  
%right XOR_assignment_operator OR_assignment_operator
%right AND_assignment_operator
%right multiplication_assignment_operator division_assignment_operator
%right addition_assignment_operator subtraction_assignment_operator
%right assignment_operator

%left OR_operator
%left AND_operator
%left pipe_operator
%left caret_operator
%left amp_operator
%left equality_operator inequality_operator
%left lessthan_assignment_operator lessthan_operator greaterthan_assignment_operator greaterthan_operator
%left add_operator subtract_operator
%left multiplication_operator division_operator

%right exclamation_operator
%left increment_operator decrement_operator 


%start program

%%
program
			: declaration_list;

declaration_list
			: declaration D;

D
			: declaration_list
			| ;

declaration
			: variable_declaration 
			| function_declaration
            | main_function_declaration;

variable_declaration
			: type_specifier variable_declaration_list '.';

variable_declaration_list
			: variable_declaration_identifier V;

V
			: ',' variable_declaration_list 
			| ;

variable_declaration_identifier 
			: identifier vdi;

vdi 
            : assignment_operator expression 
            | ; 

type_specifier 
			: INT | CHAR
			| VOID ;

main_function_declaration
            : main_function_declaration_type main_function_declaration_param_statement;

main_function_declaration_type
            :type_specifier MAIN '(' {isMainUsed=1;};

main_function_declaration_param_statement
            :')' statement;

function_declaration
			: function_declaration_type function_declaration_param_statement {if (isMainUsed==1){yyerror("error");}};

function_declaration_type
			: type_specifier identifier '(' ;

function_declaration_param_statement
			: params ')' statement;

params 
			: parameters_list;

parameters_list 
			: /*type_specifier*/parameters_identifier_list;

parameters_identifier_list 
			: identifier
            | identifier ',' identifier
            | identifier ',' identifier ',' identifier;

statement 
			: expression_statment | compound_statement 
			| conditional_statements | iterative_statements 
			| return_statement | break_statement | continue_statement
			| variable_declaration;

compound_statement 
			: '{' statment_list '}' ;

statment_list 
			: statement statment_list 
			| ;

expression_statment 
			: expression '.' 
			| '.' ;

conditional_statements 
			: IF '(' simple_expression ')' statement conditional_statements_breakup;

conditional_statements_breakup
            : ELSEIF '(' simple_expression ')' statement conditional_statements_breakup
			| ELSE statement
			| ;

iterative_statements 
			: WHILE '(' simple_expression ')' statement 
			| FOR '(' INT expression ',' simple_expression ',' expression ')';

return_statement 
			: RETURN return_statement_breakup;

return_statement_breakup
			: '.' 
			| expression '.' ;

break_statement 
			: BREAK '.' ;

continue_statement
            : CONTINUE '.';

expression 
			: identifier expression_breakup
			| simple_expression ;

expression_breakup
			: assignment_operator expression 
			| addition_assignment_operator expression 
			| subtraction_assignment_operator expression 
			| multiplication_assignment_operator expression 
			| division_assignment_operator expression 
			| increment_operator 
			| decrement_operator ;

simple_expression 
			: and_expression simple_expression_breakup;

simple_expression_breakup 
			: OR_operator and_expression simple_expression_breakup | ;

and_expression 
			: unary_relation_expression and_expression_breakup;

and_expression_breakup
			: AND_operator unary_relation_expression and_expression_breakup
			| ;

unary_relation_expression 
			: exclamation_operator unary_relation_expression 
			| regular_expression ;

regular_expression 
			: sum_expression regular_expression_breakup;

regular_expression_breakup
			: relational_operators sum_expression 
			| ;

relational_operators 
			: greaterthan_assignment_operator | lessthan_assignment_operator | greaterthan_operator 
			| lessthan_operator | equality_operator | inequality_operator ;

sum_expression 
			: sum_expression sum_operators term 
			| term ;

sum_operators 
			: add_operator 
			| subtract_operator ;

term
			: term MULOP factor 
			| factor ;

MULOP 
			: multiplication_operator | division_operator ;

factor 
			: immutable | identifier ;

immutable 
			: '(' expression ')' 
			| call | constant;

call
			: identifier '(' arguments ')';

arguments 
			: arguments_list | ;

arguments_list 
			: expression A;

A
			: ',' expression A 
			| ;

constant 
			: integer_constant
            | off_limit_integer_constant {yyerror("The limit of integers was rejected");}
			| string_constant;

%%

extern FILE *yyin;
extern int yylineno;
extern char *yytext;

int main()
{
	FILE* input = fopen("./Test Cases/test2.txt", "r");
	yyin = input;
    output = fopen("Phase2_Result.txt", "w");

	yyparse();

	if(flag == 0)
	{
		fprintf(output, "Status: Parsing Complete - Valid\n");
		printf(ANSI_COLOR_GREEN "Status: Parsing Complete - Valid" ANSI_COLOR_RESET "\n");
	}

	fclose(output);
    fclose(input);
}

void yyerror(char *s)
{	
	fprintf(output, "%s happened at line no. %d\nlast recognized token was: %s\n", s, yylineno, yytext);
	printf("%s happened at line no. %d\nlast recognized token was: %s\n", s, yylineno, yytext);
	flag=1;
	fprintf(output, "Status: Parsing Failed - Invalid\n");
	printf(ANSI_COLOR_RED "Status: Parsing Failed - Invalid\n" ANSI_COLOR_RESET);
}


int yywrap()
{
	return 1;
}