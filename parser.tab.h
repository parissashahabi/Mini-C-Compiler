/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_PARSER_TAB_H_INCLUDED
# define YY_YY_PARSER_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    IF = 258,
    INT = 259,
    CHAR = 260,
    RETURN = 261,
    MAIN = 262,
    VOID = 263,
    WHILE = 264,
    FOR = 265,
    BREAK = 266,
    CONTINUE = 267,
    identifier = 268,
    integer_constant = 269,
    string_constant = 270,
    offlimited_integer_constant = 271,
    ELSEIF = 272,
    ELSE = 273,
    XOR_assignment_operator = 274,
    OR_assignment_operator = 275,
    AND_assignment_operator = 276,
    multiplication_assignment_operator = 277,
    division_assignment_operator = 278,
    addition_assignment_operator = 279,
    subtraction_assignment_operator = 280,
    assignment_operator = 281,
    OR_operator = 282,
    AND_operator = 283,
    pipe_operator = 284,
    caret_operator = 285,
    amp_operator = 286,
    equality_operator = 287,
    inequality_operator = 288,
    lessthan_assignment_operator = 289,
    lessthan_operator = 290,
    greaterthan_assignment_operator = 291,
    greaterthan_operator = 292,
    add_operator = 293,
    subtract_operator = 294,
    multiplication_operator = 295,
    division_operator = 296,
    exclamation_operator = 297,
    increment_operator = 298,
    decrement_operator = 299
  };
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_PARSER_TAB_H_INCLUDED  */
