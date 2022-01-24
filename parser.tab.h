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
    IDENTIFIER = 258,
    INT_CONST = 259,
    CHAR_CONST = 260,
    FOR = 261,
    WHILE = 262,
    IF = 263,
    ELSEIF = 264,
    ELSE = 265,
    VOID = 266,
    INT = 267,
    CHAR = 268,
    BREAK = 269,
    CONTINUE = 270,
    MAIN = 271,
    RETURN = 272,
    DOT = 273,
    COMMA = 274,
    RIGHTBEACK = 275,
    LEFTBRACK = 276,
    RIGHTBRACE = 277,
    LEFTBRACE = 278,
    RIGHTPAREN = 279,
    LEFTPAREN = 280,
    XOR_ASSIGN = 281,
    OR_ASSIGN = 282,
    AND_ASSIGN = 283,
    MUL_ASSIGN = 284,
    DIV_ASSIGN = 285,
    ADD_ASSIGN = 286,
    SUB_ASSIGN = 287,
    ASSIGN = 288,
    OR_OP = 289,
    AND_OP = 290,
    OR = 291,
    XOR = 292,
    AND = 293,
    EQUAL = 294,
    NOTEQUAL = 295,
    LESSOREQUAL = 296,
    LESS = 297,
    GREATEROREQUAL = 298,
    GREATER = 299,
    ADD = 300,
    SUB = 301,
    MUL = 302,
    DIV = 303,
    NOT = 304,
    INC_OP = 305,
    DEC_OP = 306
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
