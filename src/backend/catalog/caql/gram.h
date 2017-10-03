/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

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

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     AND = 258,
     BY = 259,
     COUNT = 260,
     DELETE = 261,
     FOR = 262,
     FROM = 263,
     INSERT = 264,
     INTO = 265,
     IS = 266,
     ORDER = 267,
     SELECT = 268,
     UPDATE = 269,
     WHERE = 270,
     IDENT = 271,
     FCONST = 272,
     SCONST = 273,
     ICONST = 274,
     PARAM = 275,
     OP_EQUAL = 276,
     OP_LT = 277,
     OP_LE = 278,
     OP_GE = 279,
     OP_GT = 280
   };
#endif
/* Tokens.  */
#define AND 258
#define BY 259
#define COUNT 260
#define DELETE 261
#define FOR 262
#define FROM 263
#define INSERT 264
#define INTO 265
#define IS 266
#define ORDER 267
#define SELECT 268
#define UPDATE 269
#define WHERE 270
#define IDENT 271
#define FCONST 272
#define SCONST 273
#define ICONST 274
#define PARAM 275
#define OP_EQUAL 276
#define OP_LT 277
#define OP_LE 278
#define OP_GE 279
#define OP_GT 280




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 59 "gram.y"
{
	int					ival;
	char				chr;
	char			   *str;
	const char		   *keyword;
	Node			   *node;
	List			   *list;
}
/* Line 1529 of yacc.c.  */
#line 108 "gram.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif



#if ! defined YYLTYPE && ! defined YYLTYPE_IS_DECLARED
typedef struct YYLTYPE
{
  int first_line;
  int first_column;
  int last_line;
  int last_column;
} YYLTYPE;
# define yyltype YYLTYPE /* obsolescent; will be withdrawn */
# define YYLTYPE_IS_DECLARED 1
# define YYLTYPE_IS_TRIVIAL 1
#endif


