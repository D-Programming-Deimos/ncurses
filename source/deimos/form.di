/****************************************************************************
 * Copyright 2018-2019-2020,2021 Thomas E. Dickey                           *
 * Copyright 1998-2016,2017 Free Software Foundation, Inc.                  *
 *                                                                          *
 * Permission is hereby granted, free of charge, to any person obtaining a  *
 * copy of this software and associated documentation files (the            *
 * "Software"), to deal in the Software without restriction, including      *
 * without limitation the rights to use, copy, modify, merge, publish,      *
 * distribute, distribute with modifications, sublicense, and/or sell       *
 * copies of the Software, and to permit persons to whom the Software is    *
 * furnished to do so, subject to the following conditions:                 *
 *                                                                          *
 * The above copyright notice and this permission notice shall be included  *
 * in all copies or substantial portions of the Software.                   *
 *                                                                          *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS  *
 * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF               *
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.   *
 * IN NO EVENT SHALL THE ABOVE COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,   *
 * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR    *
 * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR    *
 * THE USE OR OTHER DEALINGS IN THE SOFTWARE.                               *
 *                                                                          *
 * Except as contained in this notice, the name(s) of the above copyright   *
 * holders shall not be used in advertising or otherwise to promote the     *
 * sale, use or other dealings in this Software without prior written       *
 * authorization.                                                           *
 ****************************************************************************/

/****************************************************************************
 *   Author:  Juergen Pfeifer, 1995,1997                                    *
 ****************************************************************************/

/* $Id: form.h,v 0.32 2021/06/17 21:26:02 tom Exp $ */

module deimos.form;

extern (C):

import core.stdc.config;
import core.stdc.stdarg;
import core.stdc.stddef;

/* *INDENT-OFF*/

public import deimos.curses;
public import deimos.eti;

// D porting note: this replaces FORM_WRAPPED_VAR and NCURSES_PUBLIC_VAR.
mixin template FORM_D_VAR(type,string name)
{
	mixin("
		extern /*FORM_IMPEXP*/ type " ~ NCURSES_PUBLIC_VAR(name) ~ "();
		@property auto " ~ name ~ "() { pragma(inline, true); return " ~ NCURSES_PUBLIC_VAR(name) ~ "(); }
	");
}

// D porting note: "export"/"extern" must be moved to the declaration, it cannot be added here.
alias FORM_EXPORT(type) = /*FORM_IMPEXP*/ type /*NCURSES_API*/;
alias FORM_EXPORT_VAR(type) = /*FORM_IMPEXP*/ type;

// #ifndef FORM_PRIV_H
alias FIELD_CELL = void *;
// #endif

// #ifndef NCURSES_FIELD_INTERNALS
mixin template NCURSES_FIELD_INTERNALS() {} /* nothing */
// #endif

alias Form_Options  = int;
alias Field_Options  = int;

	/**********
	*  _PAGE  *
	**********/

struct pagenode
// #if !NCURSES_OPAQUE_FORM
{
  short pmin;		/* index of first field on page			*/
  short pmax;		/* index of last field on page			*/
  short smin;		/* index of top leftmost field on page		*/
  short smax;		/* index of bottom rightmost field on page	*/
}
// #endif /* !NCURSES_OPAQUE_FORM */
alias _PAGE = pagenode;

	/**********
	*  FIELD  *
	**********/

struct fieldnode
// #if 1			/* not yet: !NCURSES_OPAQUE_FORM */
{
  ushort        status;         /* flags                        */
  short			rows;		/* size in rows			*/
  short			cols;		/* size in cols			*/
  short			frow;		/* first row			*/
  short			fcol;		/* first col			*/
  int			drows;		/* dynamic rows			*/
  int			dcols;		/* dynamic cols			*/
  int			maxgrow;	/* maximum field growth		*/
  int			nrow;		/* off-screen rows		*/
  short			nbuf;		/* additional buffers		*/
  short			just;		/* justification		*/
  short			page;		/* page on form			*/
  short			index;		/* into form -> field		*/
  int			pad;		/* pad character		*/
  chtype		fore;		/* foreground attribute		*/
  chtype		back;		/* background attribute		*/
  Field_Options		opts;		/* options			*/
  fieldnode *	snext;		/* sorted order pointer		*/
  fieldnode *	sprev;		/* sorted order pointer		*/
  fieldnode *	link;		/* linked field chain		*/
  formnode *	form;		/* containing form		*/
  typenode *	type;		/* field type			*/
  void *		arg;		/* argument for type		*/
  FIELD_CELL *		buf;		/* field buffers		*/
  void *		usrptr;		/* user pointer			*/
  /*
   * The wide-character configuration requires extra information.  Because
   * there are existing applications that manipulate the members of FIELD
   * directly, we cannot make the struct opaque, except by changing the ABI.
   * Offsets of members up to this point are the same in the narrow- and
   * wide-character configuration.  But note that the type of buf depends on
   * the configuration, and is made opaque for that reason.
   */
  mixin NCURSES_FIELD_INTERNALS;
}
// #endif /* NCURSES_OPAQUE_FORM */
alias FIELD = fieldnode;


	/*********
	*  FORM  *
	*********/

struct formnode
// #if 1			/* not yet: !NCURSES_OPAQUE_FORM */
{
  ushort        status;         /* flags                        */
  short			rows;		/* size in rows			*/
  short			cols;		/* size in cols			*/
  int			currow;		/* current row in field window	*/
  int			curcol;		/* current col in field window	*/
  int			toprow;		/* in scrollable field window	*/
  int			begincol;	/* in horiz. scrollable field	*/
  short			maxfield;	/* number of fields		*/
  short			maxpage;	/* number of pages		*/
  short			curpage;	/* index into page		*/
  Form_Options		opts;		/* options			*/
  WINDOW *		win;		/* window			*/
  WINDOW *		sub;		/* subwindow			*/
  WINDOW *		w;		/* window for current field	*/
  FIELD **		field;		/* field [maxfield]		*/
  FIELD *		current;	/* current field		*/
  _PAGE *		page;		/* page [maxpage]		*/
  void *		usrptr;		/* user pointer			*/

  void			function(formnode *) forminit;
  void			function(formnode *) formterm;
  void			function(formnode *) fieldinit;
  void			function(formnode *) fieldterm;

}
// #endif /* !NCURSES_OPAQUE_FORM */
alias FORM = formnode;


	/**************
	*  FIELDTYPE  *
	**************/

struct typenode
// #if !NCURSES_OPAQUE_FORM
{
  ushort        status;                 /* flags                    */
  c_long                  ref_;                    /* reference count          */
  typenode *     left;                   /* ptr to operand for |     */
  typenode *     right;                  /* ptr to operand for |     */

  void* function(va_list *) makearg;                  /* make fieldtype arg       */
  void* function(const(void) *) copyarg;               /* copy fieldtype arg       */
  void  function(void *) freearg;                     /* free fieldtype arg       */

static if (NCURSES_INTEROP_FUNCS) {
  union {
    bool function(FIELD *,const(void) *) ofcheck;      /* field validation         */
    bool function(FORM*,FIELD *,const(void)*) gfcheck; /* generic field validation */
  } /*fieldcheck;*/
  union {
    bool function(int,const(void) *) occheck;          /* character validation     */
    bool function(int,FORM*,
                    FIELD*,const(void)*) gccheck;        /* generic char validation  */
  } /*charcheck;*/
  union {
    bool function(FIELD *,const(void) *) onext;        /* enumerate next value     */
    bool function(FORM*,FIELD*,const(void)*) gnext;    /* generic enumerate next   */
  } /*enum_next;*/
  union {
    bool function(FIELD *,const(void) *) oprev;        /* enumerate prev value     */
    bool function(FORM*,FIELD*,const(void)*) gprev;    /* generic enumerate prev   */
  } /*enum_prev;*/
  void* function(void*) genericarg;                   /* Alternate Arg method     */
} else {
  bool  function(FIELD *,const(void) *) fcheck;        /* field validation     */
  bool  function(int,const(void) *) ccheck;            /* character validation */

  bool  function(FIELD *,const(void) *) next;          /* enumerate next value */
  bool  function(FIELD *,const(void) *) prev;          /* enumerate prev value */
}
}
// #endif /* !NCURSES_OPAQUE_FORM */
alias FIELDTYPE = typenode;

alias Form_Hook = void function(FORM *);

	/***************************
	*  miscellaneous #defines  *
	***************************/

/* field justification */
enum NO_JUSTIFICATION        = (0);
enum JUSTIFY_LEFT            = (1);
enum JUSTIFY_CENTER          = (2);
enum JUSTIFY_RIGHT           = (3);

/* field options */
enum O_VISIBLE               = (0x0001U);
enum O_ACTIVE                = (0x0002U);
enum O_PUBLIC                = (0x0004U);
enum O_EDIT                  = (0x0008U);
enum O_WRAP                  = (0x0010U);
enum O_BLANK                 = (0x0020U);
enum O_AUTOSKIP              = (0x0040U);
enum O_NULLOK                = (0x0080U);
enum O_PASSOK                = (0x0100U);
enum O_STATIC                = (0x0200U);
enum O_DYNAMIC_JUSTIFY       = (0x0400U);       /* ncurses extension    */
enum O_NO_LEFT_STRIP         = (0x0800U);       /* ncurses extension    */
enum O_EDGE_INSERT_STAY      = (0x1000U);       /* ncurses extension    */
enum O_INPUT_LIMIT           = (0x2000U);       /* ncurses extension    */

/* form options */
enum O_NL_OVERLOAD           = (0x0001U);
enum O_BS_OVERLOAD           = (0x0002U);

/* form driver commands */
enum REQ_NEXT_PAGE    = (KEY_MAX + 1);  /* move to next page            */
enum REQ_PREV_PAGE    = (KEY_MAX + 2);  /* move to previous page        */
enum REQ_FIRST_PAGE   = (KEY_MAX + 3);  /* move to first page           */
enum REQ_LAST_PAGE    = (KEY_MAX + 4);  /* move to last page            */

enum REQ_NEXT_FIELD   = (KEY_MAX + 5);  /* move to next field           */
enum REQ_PREV_FIELD   = (KEY_MAX + 6);  /* move to previous field       */
enum REQ_FIRST_FIELD  = (KEY_MAX + 7);  /* move to first field          */
enum REQ_LAST_FIELD   = (KEY_MAX + 8);  /* move to last field           */
enum REQ_SNEXT_FIELD  = (KEY_MAX + 9);  /* move to sorted next field    */
enum REQ_SPREV_FIELD  = (KEY_MAX + 10); /* move to sorted prev field    */
enum REQ_SFIRST_FIELD = (KEY_MAX + 11); /* move to sorted first field   */
enum REQ_SLAST_FIELD  = (KEY_MAX + 12); /* move to sorted last field    */
enum REQ_LEFT_FIELD   = (KEY_MAX + 13); /* move to left to field        */
enum REQ_RIGHT_FIELD  = (KEY_MAX + 14); /* move to right to field       */
enum REQ_UP_FIELD     = (KEY_MAX + 15); /* move to up to field          */
enum REQ_DOWN_FIELD   = (KEY_MAX + 16); /* move to down to field        */

enum REQ_NEXT_CHAR    = (KEY_MAX + 17); /* move to next char in field   */
enum REQ_PREV_CHAR    = (KEY_MAX + 18); /* move to prev char in field   */
enum REQ_NEXT_LINE    = (KEY_MAX + 19); /* move to next line in field   */
enum REQ_PREV_LINE    = (KEY_MAX + 20); /* move to prev line in field   */
enum REQ_NEXT_WORD    = (KEY_MAX + 21); /* move to next word in field   */
enum REQ_PREV_WORD    = (KEY_MAX + 22); /* move to prev word in field   */
enum REQ_BEG_FIELD    = (KEY_MAX + 23); /* move to first char in field  */
enum REQ_END_FIELD    = (KEY_MAX + 24); /* move after last char in fld  */
enum REQ_BEG_LINE     = (KEY_MAX + 25); /* move to beginning of line    */
enum REQ_END_LINE     = (KEY_MAX + 26); /* move after last char in line */
enum REQ_LEFT_CHAR    = (KEY_MAX + 27); /* move left in field           */
enum REQ_RIGHT_CHAR   = (KEY_MAX + 28); /* move right in field          */
enum REQ_UP_CHAR      = (KEY_MAX + 29); /* move up in field             */
enum REQ_DOWN_CHAR    = (KEY_MAX + 30); /* move down in field           */

enum REQ_NEW_LINE     = (KEY_MAX + 31); /* insert/overlay new line      */
enum REQ_INS_CHAR     = (KEY_MAX + 32); /* insert blank char at cursor  */
enum REQ_INS_LINE     = (KEY_MAX + 33); /* insert blank line at cursor  */
enum REQ_DEL_CHAR     = (KEY_MAX + 34); /* delete char at cursor        */
enum REQ_DEL_PREV     = (KEY_MAX + 35); /* delete char before cursor    */
enum REQ_DEL_LINE     = (KEY_MAX + 36); /* delete line at cursor        */
enum REQ_DEL_WORD     = (KEY_MAX + 37); /* delete word at cursor        */
enum REQ_CLR_EOL      = (KEY_MAX + 38); /* clear to end of line         */
enum REQ_CLR_EOF      = (KEY_MAX + 39); /* clear to end of field        */
enum REQ_CLR_FIELD    = (KEY_MAX + 40); /* clear entire field           */
enum REQ_OVL_MODE     = (KEY_MAX + 41); /* begin overlay mode           */
enum REQ_INS_MODE     = (KEY_MAX + 42); /* begin insert mode            */
enum REQ_SCR_FLINE    = (KEY_MAX + 43); /* scroll field forward a line  */
enum REQ_SCR_BLINE    = (KEY_MAX + 44); /* scroll field backward a line */
enum REQ_SCR_FPAGE    = (KEY_MAX + 45); /* scroll field forward a page  */
enum REQ_SCR_BPAGE    = (KEY_MAX + 46); /* scroll field backward a page */
enum REQ_SCR_FHPAGE   = (KEY_MAX + 47); /* scroll field forward  half page */
enum REQ_SCR_BHPAGE   = (KEY_MAX + 48); /* scroll field backward half page */
enum REQ_SCR_FCHAR    = (KEY_MAX + 49); /* horizontal scroll char       */
enum REQ_SCR_BCHAR    = (KEY_MAX + 50); /* horizontal scroll char       */
enum REQ_SCR_HFLINE   = (KEY_MAX + 51); /* horizontal scroll line       */
enum REQ_SCR_HBLINE   = (KEY_MAX + 52); /* horizontal scroll line       */
enum REQ_SCR_HFHALF   = (KEY_MAX + 53); /* horizontal scroll half line  */
enum REQ_SCR_HBHALF   = (KEY_MAX + 54); /* horizontal scroll half line  */

enum REQ_VALIDATION   = (KEY_MAX + 55); /* validate field               */
enum REQ_NEXT_CHOICE  = (KEY_MAX + 56); /* display next field choice    */
enum REQ_PREV_CHOICE  = (KEY_MAX + 57); /* display prev field choice    */

enum MIN_FORM_COMMAND = (KEY_MAX + 1);  /* used by form_driver          */
enum MAX_FORM_COMMAND = (KEY_MAX + 57); /* used by form_driver          */

// #if defined(MAX_COMMAND)
// #  if (MAX_FORM_COMMAND > MAX_COMMAND)
// #    error Something is wrong -- MAX_FORM_COMMAND is greater than MAX_COMMAND
// #  elif (MAX_COMMAND != (KEY_MAX + 128))
// #    error Something is wrong -- MAX_COMMAND is already inconsistently defined.
// #  endif
// #else
  enum MAX_COMMAND = (KEY_MAX + 128);
// #endif

	/*************************
	*  standard field types  *
	*************************/
extern __gshared FORM_EXPORT_VAR!(FIELDTYPE *) TYPE_ALPHA;
extern __gshared FORM_EXPORT_VAR!(FIELDTYPE *) TYPE_ALNUM;
extern __gshared FORM_EXPORT_VAR!(FIELDTYPE *) TYPE_ENUM;
extern __gshared FORM_EXPORT_VAR!(FIELDTYPE *) TYPE_INTEGER;
extern __gshared FORM_EXPORT_VAR!(FIELDTYPE *) TYPE_NUMERIC;
extern __gshared FORM_EXPORT_VAR!(FIELDTYPE *) TYPE_REGEXP;

	/************************************
	*  built-in additional field types  *
	*  They are not defined in SVr4     *
	************************************/
extern __gshared FORM_EXPORT_VAR!(FIELDTYPE *) TYPE_IPV4;      /* Internet IP Version 4 address */

	/***********************
	*  FIELDTYPE routines  *
        ***********************/
extern nothrow @nogc FORM_EXPORT!(FIELDTYPE *) new_fieldtype (
                    const bool function(FIELD *,const(void) *) field_check,
                    const bool function(int,const(void) *) char_check);
extern nothrow @nogc FORM_EXPORT!(FIELDTYPE *) link_fieldtype(
                    FIELDTYPE *, FIELDTYPE *);

extern nothrow @nogc FORM_EXPORT!(int)        free_fieldtype (FIELDTYPE *);
extern nothrow @nogc FORM_EXPORT!(int)        set_fieldtype_arg (FIELDTYPE *,
                    const void * function(va_list *) make_arg,
                    const void * function(const(void) *),
                    const void function(void *) free_arg);
extern nothrow @nogc FORM_EXPORT!(int)         set_fieldtype_choice (FIELDTYPE *,
                    const bool function(FIELD *,const(void) *) next_choice,
                    const bool function(FIELD *,const(void) *) prev_choice);

	/*******************
	*  FIELD routines  *
	*******************/
extern nothrow @nogc FORM_EXPORT!(FIELD *)	new_field (int,int,int,int,int,int);
extern nothrow @nogc FORM_EXPORT!(FIELD *)	dup_field (FIELD *,int,int);
extern nothrow @nogc FORM_EXPORT!(FIELD *)	link_field (FIELD *,int,int);

extern nothrow @nogc FORM_EXPORT!(int)	free_field (FIELD *);
extern nothrow @nogc FORM_EXPORT!(int)	field_info (const FIELD *,int *,int *,int *,int *,int *,int *);
extern nothrow @nogc FORM_EXPORT!(int)	dynamic_field_info (const FIELD *,int *,int *,int *);
extern nothrow @nogc FORM_EXPORT!(int)	set_max_field ( FIELD *,int);
extern nothrow @nogc FORM_EXPORT!(int)	move_field (FIELD *,int,int);
extern nothrow @nogc FORM_EXPORT!(int)	set_field_type (FIELD *,FIELDTYPE *,...);
extern nothrow @nogc FORM_EXPORT!(int)	set_new_page (FIELD *,bool);
extern nothrow @nogc FORM_EXPORT!(int)	set_field_just (FIELD *,int);
extern nothrow @nogc FORM_EXPORT!(int)	field_just (const FIELD *);
extern nothrow @nogc FORM_EXPORT!(int)	set_field_fore (FIELD *,chtype);
extern nothrow @nogc FORM_EXPORT!(int)	set_field_back (FIELD *,chtype);
extern nothrow @nogc FORM_EXPORT!(int)	set_field_pad (FIELD *,int);
extern nothrow @nogc FORM_EXPORT!(int)	field_pad (const FIELD *);
extern nothrow @nogc FORM_EXPORT!(int)	set_field_buffer (FIELD *,int,const char *);
extern nothrow @nogc FORM_EXPORT!(int)	set_field_status (FIELD *,bool);
extern nothrow @nogc FORM_EXPORT!(int)	set_field_userptr (FIELD *, void *);
extern nothrow @nogc FORM_EXPORT!(int)	set_field_opts (FIELD *,Field_Options);
extern nothrow @nogc FORM_EXPORT!(int)	field_opts_on (FIELD *,Field_Options);
extern nothrow @nogc FORM_EXPORT!(int)	field_opts_off (FIELD *,Field_Options);

extern nothrow @nogc FORM_EXPORT!(chtype)	field_fore (const FIELD *);
extern nothrow @nogc FORM_EXPORT!(chtype)	field_back (const FIELD *);

extern nothrow @nogc FORM_EXPORT!(bool)	new_page (const FIELD *);
extern nothrow @nogc FORM_EXPORT!(bool)	field_status (const FIELD *);

extern nothrow @nogc FORM_EXPORT!(void *)	field_arg (const FIELD *);

extern nothrow @nogc FORM_EXPORT!(void *)	field_userptr (const FIELD *);

extern nothrow @nogc FORM_EXPORT!(FIELDTYPE *)	field_type (const FIELD *);

extern nothrow @nogc FORM_EXPORT!(char *)	field_buffer (const FIELD *,int);

extern nothrow @nogc FORM_EXPORT!(Field_Options)	field_opts (const FIELD *);

	/******************
	*  FORM routines  *
	******************/

extern nothrow @nogc FORM_EXPORT!(FORM *)	new_form (FIELD **);

extern nothrow @nogc FORM_EXPORT!(FIELD **)	form_fields (const FORM *);
extern nothrow @nogc FORM_EXPORT!(FIELD *)	current_field (const FORM *);

extern nothrow @nogc FORM_EXPORT!(WINDOW *)	form_win (const FORM *);
extern nothrow @nogc FORM_EXPORT!(WINDOW *)	form_sub (const FORM *);

extern nothrow @nogc FORM_EXPORT!(Form_Hook)	form_init (const FORM *);
extern nothrow @nogc FORM_EXPORT!(Form_Hook)	form_term (const FORM *);
extern nothrow @nogc FORM_EXPORT!(Form_Hook)	field_init (const FORM *);
extern nothrow @nogc FORM_EXPORT!(Form_Hook)	field_term (const FORM *);

extern nothrow @nogc FORM_EXPORT!(int)	free_form (FORM *);
extern nothrow @nogc FORM_EXPORT!(int)	set_form_fields (FORM *,FIELD **);
extern nothrow @nogc FORM_EXPORT!(int)	field_count (const FORM *);
extern nothrow @nogc FORM_EXPORT!(int)	set_form_win (FORM *,WINDOW *);
extern nothrow @nogc FORM_EXPORT!(int)	set_form_sub (FORM *,WINDOW *);
extern nothrow @nogc FORM_EXPORT!(int)	set_current_field (FORM *,FIELD *);
extern nothrow @nogc FORM_EXPORT!(int)	unfocus_current_field (FORM *);
extern nothrow @nogc FORM_EXPORT!(int)	field_index (const FIELD *);
extern nothrow @nogc FORM_EXPORT!(int)	set_form_page (FORM *,int);
extern nothrow @nogc FORM_EXPORT!(int)	form_page (const FORM *);
extern nothrow @nogc FORM_EXPORT!(int)	scale_form (const FORM *,int *,int *);
extern nothrow @nogc FORM_EXPORT!(int)	set_form_init (FORM *,Form_Hook);
extern nothrow @nogc FORM_EXPORT!(int)	set_form_term (FORM *,Form_Hook);
extern nothrow @nogc FORM_EXPORT!(int)	set_field_init (FORM *,Form_Hook);
extern nothrow @nogc FORM_EXPORT!(int)	set_field_term (FORM *,Form_Hook);
extern nothrow @nogc FORM_EXPORT!(int)	post_form (FORM *);
extern nothrow @nogc FORM_EXPORT!(int)	unpost_form (FORM *);
extern nothrow @nogc FORM_EXPORT!(int)	pos_form_cursor (FORM *);
extern nothrow @nogc FORM_EXPORT!(int)	form_driver (FORM *,int);
static if (NCURSES_WIDECHAR) {
extern nothrow @nogc FORM_EXPORT!(int)        form_driver_w (FORM *,int,wchar_t);
}
extern nothrow @nogc FORM_EXPORT!(int)	set_form_userptr (FORM *,void *);
extern nothrow @nogc FORM_EXPORT!(int)	set_form_opts (FORM *,Form_Options);
extern nothrow @nogc FORM_EXPORT!(int)	form_opts_on (FORM *,Form_Options);
extern nothrow @nogc FORM_EXPORT!(int)	form_opts_off (FORM *,Form_Options);
extern nothrow @nogc FORM_EXPORT!(int)	form_request_by_name (const char *);

extern nothrow @nogc FORM_EXPORT!(const char *)	form_request_name (int);

extern nothrow @nogc FORM_EXPORT!(void *)	form_userptr (const FORM *);

extern nothrow @nogc FORM_EXPORT!(Form_Options)	form_opts (const FORM *);

extern nothrow @nogc FORM_EXPORT!(bool)	data_ahead (const FORM *);
extern nothrow @nogc FORM_EXPORT!(bool)	data_behind (const FORM *);

static if (NCURSES_SP_FUNCS) {
extern nothrow @nogc FORM_EXPORT!(FORM *)	NCURSES_SP_NAME(new_form) (SCREEN*, FIELD **);
}

/* *INDENT-ON*/
