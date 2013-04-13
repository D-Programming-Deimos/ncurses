/****************************************************************************
 * Copyright (c) 1998-2004,2009 Free Software Foundation, Inc.              *
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

/* $Id: form.h,v 0.21 2009/11/07 19:31:11 tom Exp $ */

module deimos.ncurses.form;


import std.c.stdarg;
public import deimos.ncurses.ncurses;
public import deimos.ncurses.eti;

extern(C)
{

alias void* FIELD_CELL;
alias int Form_Options;
alias int Field_Options;


    /**********
    *  _PAGE  *
    **********/

struct _PAGE
{
    short pmin;       /* index of first field on page         */
    short pmax;       /* index of last field on page          */
    short smin;       /* index of top leftmost field on page      */
    short smax;       /* index of bottom rightmost field on page  */
}

    /**********
    *  FIELD  *
    **********/

struct  FIELD
{
    ushort          status;     /* flags            */
    short           rows;       /* size in rows         */
    short           cols;       /* size in cols         */
    short           frow;       /* first row            */
    short           fcol;       /* first col            */
    int             drows;      /* dynamic rows         */
    int             dcols;      /* dynamic cols         */
    int             maxgrow;    /* maximum field growth     */
    int             nrow;       /* off-screen rows      */
    short           nbuf;       /* additional buffers       */
    short           just;       /* justification        */
    short           page;       /* page on form         */
    short           index;      /* into form -> field       */
    int             pad;        /* pad character        */
    chtype          fore;       /* foreground attribute     */
    chtype          back;       /* background attribute     */
    Field_Options   opts;       /* options          */
    FIELD*          snext;      /* sorted order pointer     */
    FIELD*          sprev;      /* sorted order pointer     */
    FIELD*          link;       /* linked field chain       */
    FORM*           form;       /* containing form      */
    FORM*           type;       /* field type           */
    void*           arg;        /* argument for type        */
    FIELD_CELL*     buf;        /* field buffers        */
    void*           usrptr;     /* user pointer         */
    /*
     * The wide-character configuration requires extra information.  Because
     * there are existing applications that manipulate the members of FIELD
     * directly, we cannot make the struct opaque.  Offsets of members up to
     * this point are the same in the narrow- and wide-character configuration.
     * But note that the type of buf depends on the configuration, and is made
     * opaque for that reason.
     */
}

    /*********
    *  FORM  *
    *********/

struct FORM
{
    ushort          status;     /* flags            */
    short           rows;       /* size in rows         */
    short           cols;       /* size in cols         */
    int             currow;     /* current row in field window  */
    int             curcol;     /* current col in field window  */
    int             toprow;     /* in scrollable field window   */
    int             begincol;   /* in horiz. scrollable field   */
    short           maxfield;   /* number of fields     */
    short           maxpage;    /* number of pages      */
    short           curpage;    /* index into page      */
    Form_Options    opts;       /* options          */
    WINDOW*         win;        /* window           */
    WINDOW*         sub;        /* subwindow            */
    WINDOW*         w;      /* window for current field */
    FIELD**         field;      /* field [maxfield]     */
    FIELD*          current;    /* current field        */
    _PAGE*          page;       /* page [maxpage]       */
    void*           usrptr;     /* user pointer         */
    //TODO check...
    void            function(FORM* form) forminit;
    void            function(FORM* form) formterm;
    void            function(FORM* form) fieldinit;
    void            function(FORM* form) fieldterm;
}


    /**************
    *  FIELDTYPE  *
    **************/

struct FIELDTYPE
{
  ushort        status;                             /* flags            */
  long          reference;                                /* reference count      */
  FIELDTYPE*    left;                               /* ptr to operand for |     */
  FIELDTYPE*    right;                              /* ptr to operand for |     */

  void* function(va_list*)          makearg;          /* make fieldtype arg */
  void* function(const void*)       copyarg;          /* copy fieldtype arg */
  void  function(void*)             freearg;          /* free fieldtype arg */

  bool  function(FIELD*, const void*) fcheck;         /* field validation */
  bool  function(int, const void*)  ccheck;           /* character validation */

  bool  function(FIELD*, const void*) next;                   /* enumerate next value */
  bool  function(FIELD*, const void*) prev;                   /* enumerate prev value */
}

    /***************************
    *  miscellaneous #defines  *
    ***************************/

immutable enum
{
    /* field justification */
    NO_JUSTIFICATION    = 0,
    JUSTIFY_LEFT        = 1,
    JUSTIFY_CENTER      = 2,
    JUSTIFY_RIGHT       = 3
}

immutable enum :OPTIONS
{
    /* field options */
    O_VISIBLE           = 0x0001,
    O_ACTIVE            = 0x0002,
    O_PUBLIC            = 0x0004,
    O_EDIT              = 0x0008,
    O_WRAP              = 0x0010,
    O_BLANK             = 0x0020,
    O_AUTOSKIP          = 0x0040,
    O_NULLOK            = 0x0080,
    O_PASSOK            = 0x0100,
    O_STATIC            = 0x0200,

    /* form options */
    O_NL_OVERLOAD       = 0x0001,
    O_BS_OVERLOAD       = 0x0002
}

immutable enum
{
    /* form driver commands */
    REQ_NEXT_PAGE    =  (KEY_MAX + 1),  /* move to next page        */
    REQ_PREV_PAGE    =  (KEY_MAX + 2),  /* move to previous page    */
    REQ_FIRST_PAGE   =  (KEY_MAX + 3),  /* move to first page       */
    REQ_LAST_PAGE    =  (KEY_MAX + 4),  /* move to last page        */

    REQ_NEXT_FIELD   =  (KEY_MAX + 5),  /* move to next field       */
    REQ_PREV_FIELD   =  (KEY_MAX + 6),  /* move to previous field   */
    REQ_FIRST_FIELD  =  (KEY_MAX + 7),  /* move to first field      */
    REQ_LAST_FIELD   =  (KEY_MAX + 8),  /* move to last field       */
    REQ_SNEXT_FIELD  =  (KEY_MAX + 9),  /* move to sorted next field    */
    REQ_SPREV_FIELD  =  (KEY_MAX + 10), /* move to sorted prev field    */
    REQ_SFIRST_FIELD =  (KEY_MAX + 11), /* move to sorted first field   */
    REQ_SLAST_FIELD  =  (KEY_MAX + 12), /* move to sorted last field    */
    REQ_LEFT_FIELD   =  (KEY_MAX + 13), /* move to left to field    */
    REQ_RIGHT_FIELD  =  (KEY_MAX + 14), /* move to right to field   */
    REQ_UP_FIELD     =  (KEY_MAX + 15), /* move to up to field      */
    REQ_DOWN_FIELD   =  (KEY_MAX + 16), /* move to down to field    */

    REQ_NEXT_CHAR    =  (KEY_MAX + 17), /* move to next char in field   */
    REQ_PREV_CHAR    =  (KEY_MAX + 18), /* move to prev char in field   */
    REQ_NEXT_LINE    =  (KEY_MAX + 19), /* move to next line in field   */
    REQ_PREV_LINE    =  (KEY_MAX + 20), /* move to prev line in field   */
    REQ_NEXT_WORD    =  (KEY_MAX + 21), /* move to next word in field   */
    REQ_PREV_WORD    =  (KEY_MAX + 22), /* move to prev word in field   */
    REQ_BEG_FIELD    =  (KEY_MAX + 23), /* move to first char in field  */
    REQ_END_FIELD    =  (KEY_MAX + 24), /* move after last char in fld  */
    REQ_BEG_LINE     =  (KEY_MAX + 25), /* move to beginning of line    */
    REQ_END_LINE     =  (KEY_MAX + 26), /* move after last char in line */
    REQ_LEFT_CHAR    =  (KEY_MAX + 27), /* move left in field       */
    REQ_RIGHT_CHAR   =  (KEY_MAX + 28), /* move right in field      */
    REQ_UP_CHAR      =  (KEY_MAX + 29), /* move up in field     */
    REQ_DOWN_CHAR    =  (KEY_MAX + 30), /* move down in field       */

    REQ_NEW_LINE     =  (KEY_MAX + 31), /* insert/overlay new line  */
    REQ_INS_CHAR     =  (KEY_MAX + 32), /* insert blank char at cursor  */
    REQ_INS_LINE     =  (KEY_MAX + 33), /* insert blank line at cursor  */
    REQ_DEL_CHAR     =  (KEY_MAX + 34), /* delete char at cursor    */
    REQ_DEL_PREV     =  (KEY_MAX + 35), /* delete char before cursor    */
    REQ_DEL_LINE     =  (KEY_MAX + 36), /* delete line at cursor    */
    REQ_DEL_WORD     =  (KEY_MAX + 37), /* delete word at cursor    */
    REQ_CLR_EOL      =  (KEY_MAX + 38), /* clear to end of line     */
    REQ_CLR_EOF      =  (KEY_MAX + 39), /* clear to end of field    */
    REQ_CLR_FIELD    =  (KEY_MAX + 40), /* clear entire field       */
    REQ_OVL_MODE     =  (KEY_MAX + 41), /* begin overlay mode       */
    REQ_INS_MODE     =  (KEY_MAX + 42), /* begin insert mode        */
    REQ_SCR_FLINE    =  (KEY_MAX + 43), /* scroll field forward a line  */
    REQ_SCR_BLINE    =  (KEY_MAX + 44), /* scroll field backward a line */
    REQ_SCR_FPAGE    =  (KEY_MAX + 45), /* scroll field forward a page  */
    REQ_SCR_BPAGE    =  (KEY_MAX + 46), /* scroll field backward a page */
    REQ_SCR_FHPAGE   =  (KEY_MAX + 47), /* scroll field forward  half page */
    REQ_SCR_BHPAGE   =  (KEY_MAX + 48), /* scroll field backward half page */
    REQ_SCR_FCHAR    =  (KEY_MAX + 49), /* horizontal scroll char   */
    REQ_SCR_BCHAR    =  (KEY_MAX + 50), /* horizontal scroll char   */
    REQ_SCR_HFLINE   =  (KEY_MAX + 51), /* horizontal scroll line   */
    REQ_SCR_HBLINE   =  (KEY_MAX + 52), /* horizontal scroll line   */
    REQ_SCR_HFHALF   =  (KEY_MAX + 53), /* horizontal scroll half line  */
    REQ_SCR_HBHALF   =  (KEY_MAX + 54), /* horizontal scroll half line  */

    REQ_VALIDATION   =  (KEY_MAX + 55), /* validate field       */
    REQ_NEXT_CHOICE  =  (KEY_MAX + 56), /* display next field choice    */
    REQ_PREV_CHOICE  =  (KEY_MAX + 57), /* display prev field choice    */

    MIN_FORM_COMMAND =  (KEY_MAX + 1),  /* used by form_driver      */
    MAX_FORM_COMMAND =  (KEY_MAX + 57)  /* used by form_driver      */
}

immutable MAX_COMMAND = (KEY_MAX + 128);

    /*************************
    *  standard field types  *
    *************************/
FIELDTYPE* TYPE_ALNUM;
FIELDTYPE* TYPE_ALPHA;
FIELDTYPE* TYPE_ENUM;
FIELDTYPE* TYPE_INTEGER;
FIELDTYPE* TYPE_NUMERIC;
FIELDTYPE* TYPE_REGEXP;

    /************************************
    *  built-in additional field types  *
    *  They are not defined in SVr4     *
    ************************************/
FIELDTYPE* TYPE_IPV4;   /* Internet IP Version 4 address */

    /***********************
    *  FIELDTYPE routines  *
    ***********************/
FIELDTYPE* new_fieldtype(
    bool function(FIELD*, void*) field_check,
    bool function(int, void*) char_check);
FIELDTYPE* link_fieldtype(FIELDTYPE* type1, FIELDTYPE* type2);

int free_fieldtype(FIELDTYPE* fieldtype);
int set_fieldtype_arg(
   FIELDTYPE* fieldtype,
   void* function(va_list*) make_arg,
   void* function(void*) copy_arg,
   void  function(void*) free_arg);
int set_fieldtype_choice(
   FIELDTYPE* fieldtype,
   bool function(FIELD*, void*) next_choice,
   bool function(FIELD*, void*) prev_choice);

    /*******************
    *  FIELD routines  *
    *******************/
FIELD* new_field(int height, int width, int toprow, int leftcol, int offscreen, int nbuffers);
FIELD* dup_field(FIELD* field, int toprow, int leftcol);
FIELD* link_field(FIELD* field, int toprow, int leftcol);

int free_field(FIELD* field);
int field_info(const FIELD* field, int* rows, int* cols, int* frow, int* fcol, int* nrow, int* nbuf);
int dynamic_field_info(const FIELD* field, int* rows, int* cols, int* max);
int set_max_field(FIELD* field, int max);
int move_field(FIELD* field, int frow, int fcol);
int set_field_type(FIELD* field, FIELDTYPE* type, ...);
int set_new_page(FIELD* field, bool new_page_flag);
int set_field_just(FIELD* field, int justification);
int field_just(const FIELD* field);
int set_field_fore(FIELD* field, chtype attr);
int set_field_back(FIELD* field, chtype attr);
int set_field_pad(FIELD* field, int pad);
int field_pad(const FIELD* field);
int set_field_buffer(FIELD* field, int buf, immutable(char*) value);
int set_field_status(FIELD* field, bool status);
int set_field_userptr(FIELD* field, void* userptr);
int set_field_opts(FIELD* field, Field_Options opts);
int field_opts_on(FIELD* field, Field_Options opts);
int field_opts_off(FIELD* field, Field_Options opts);

chtype field_fore(const FIELD* field);
chtype field_back(const FIELD* field);

bool new_page(const FIELD* field);
bool field_status(const FIELD* field);

void* field_arg(const FIELD* field);

void* field_userptr(const FIELD* field);

FIELDTYPE* field_type(const FIELD* field);

char* field_buffer(const FIELD* field, int buffer);

Field_Options field_opts(const FIELD* field);

    /******************
    *  FORM routines  *
    ******************/

FORM* new_form(FIELD** fields);

FIELD** form_fields(const FORM* form);
FIELD* current_field(const FORM* form);

WINDOW* form_win(const FORM* form);
WINDOW* form_sub(const FORM* form);

FORM* form_init(const FORM* form);
FORM* form_term(const FORM* form);
FORM* field_init(const FORM* form);
FORM* field_term(const FORM* form);

int free_form(FORM* form);
int set_form_fields(FORM* form, FIELD** fields);
int field_count(const FORM* form);
int set_form_win(FORM* form, WINDOW* win);
int set_form_sub(FORM* form, WINDOW* sub);
int set_current_field(FORM* form, FIELD* field);
int field_index(const FIELD* field);
int set_form_page(FORM* form, int n);
int form_page(const FORM* form);
int scale_form(const FORM* form, int* rows, int* columns);

int set_form_init(FORM* form, FORM* func);
int set_form_term(FORM* form, FORM* func);
int set_field_init(FORM* form, FORM* func);
int set_field_term(FORM* form, FORM* func);
int post_form(FORM* form);
int unpost_form(FORM* form);
int pos_form_cursor(FORM* form);
int form_driver(FORM* form, int c);
int set_form_userptr(FORM* form, void* userptr);
int set_form_opts(FORM* form, Form_Options opts);
int form_opts_on(FORM* form, Form_Options opts);
int form_opts_off(FORM* form, Form_Options opts);
int form_request_by_name(immutable char* name);

char* form_request_name(int request);

void* form_userptr(const FORM* form);

Form_Options form_opts(const FORM* form);

bool data_ahead(const FORM* form);
bool data_behind(const FORM* form);
}//end extern (C)
