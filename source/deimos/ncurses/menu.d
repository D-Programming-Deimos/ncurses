/****************************************************************************
 * Copyright (c) 1998-2007,2009 Free Software Foundation, Inc.              *
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
/* $Id: menu.h,v 1.20 2009/04/05 00:28:07 tom Exp $ */
module deimos.ncurses.menu;

public import deimos.ncurses.curses,
	      deimos.ncurses.eti;

extern(C)
{

alias int Menu_Options;
alias int Item_Options;


immutable enum :OPTIONS
{
    /* Menu options: */
    O_ONEVALUE      = 0x01,
    O_SHOWDESC      = 0x02,
    O_ROWMAJOR      = 0x04,
    O_IGNORECASE    = 0x08,
    O_SHOWMATCH     = 0x10,
    O_NONCYCLIC     = 0x20,
    /* Item options: */
    O_SELECTABLE    = 0x01,
}

struct TEXT
{
  immutable(char*)  str;
  ushort            length;
}

struct ITEM
{
  TEXT           name;        /* name of menu item                         */
  TEXT           description; /* description of item, optional in display  */
  MENU*          imenu;      /* Pointer to parent menu                    */
  void*          userptr;    /* Pointer to user defined per item data     */
  Item_Options   opt;         /* Item options                              */
  short          index;       /* Item number if connected to a menu        */
  short          y;           /* y and x location of item in menu          */
  short          x;
  bool           value;       /* Selection value                           */

  ITEM* left;       /* neighbor items                            */
  ITEM* right;
  ITEM* up;
  ITEM* down;
}

struct MENU
{
  short          height;                /* Nr. of chars high               */
  short          width;                 /* Nr. of chars wide               */
  short          rows;                  /* Nr. of items high               */
  short          cols;                  /* Nr. of items wide               */
  short          frows;                 /* Nr. of formatted items high     */
  short          fcols;                 /* Nr. of formatted items wide     */
  short          arows;                 /* Nr. of items high (actual)      */
  short          namelen;               /* Max. name length                */
  short          desclen;               /* Max. description length         */
  short          marklen;               /* Length of mark, if any          */
  short          itemlen;               /* Length of one item              */
  short          spc_desc;              /* Spacing for descriptor          */
  short          spc_cols;              /* Spacing for columns             */
  short          spc_rows;              /* Spacing for rows                */
  char*          pattern;               /* Buffer to store match chars     */
  short          pindex;                /* Index into pattern buffer       */
  WINDOW*        win;                   /* Window containing menu          */
  WINDOW*        sub;                   /* Subwindow for menu display      */
  WINDOW*        userwin;               /* User's window                   */
  WINDOW*        usersub;               /* User's subwindow                */
  ITEM**         items;                /* array of items                  */
  short          nitems;                /* Nr. of items in menu            */
  ITEM*          curitem;               /* Current item                    */
  short          toprow;                /* Top row of menu                 */
  chtype         fore;                  /* Selection attribute             */
  chtype         back;                  /* Nonselection attribute          */
  chtype         grey;                  /* Inactive attribute              */
  ubyte          pad;                   /* Pad character                   */

  MENU*          menuinit;              /* User hooks                      */
  MENU*          menuterm;              /* User hooks                      */
  MENU*          iteminit;              /* User hooks                      */
  MENU*          itemterm;              /* User hooks                      */

  void*          userptr;               /* Pointer to menus user data      */
  char*          mark;                  /* Pointer to marker string        */

  Menu_Options   opt;                   /* Menu options                    */
  ushort         status;                /* Internal state of menu          */
}

/* Define keys */
immutable enum
{
    REQ_LEFT_ITEM         =  (KEY_MAX + 1),
    REQ_RIGHT_ITEM        =  (KEY_MAX + 2),
    REQ_UP_ITEM           =  (KEY_MAX + 3),
    REQ_DOWN_ITEM         =  (KEY_MAX + 4),
    REQ_SCR_ULINE         =  (KEY_MAX + 5),
    REQ_SCR_DLINE         =  (KEY_MAX + 6),
    REQ_SCR_DPAGE         =  (KEY_MAX + 7),
    REQ_SCR_UPAGE         =  (KEY_MAX + 8),
    REQ_FIRST_ITEM        =  (KEY_MAX + 9),
    REQ_LAST_ITEM         =  (KEY_MAX + 10),
    REQ_NEXT_ITEM         =  (KEY_MAX + 11),
    REQ_PREV_ITEM         =  (KEY_MAX + 12),
    REQ_TOGGLE_ITEM       =  (KEY_MAX + 13),
    REQ_CLEAR_PATTERN     =  (KEY_MAX + 14),
    REQ_BACK_PATTERN      =  (KEY_MAX + 15),
    REQ_NEXT_MATCH        =  (KEY_MAX + 16),
    REQ_PREV_MATCH        =  (KEY_MAX + 17),

    MIN_MENU_COMMAND      =  (KEY_MAX + 1),
    MAX_MENU_COMMAND      =  (KEY_MAX + 17)
}

/*
 * Some AT&T code expects MAX_COMMAND to be out-of-band not
 * just for menu commands but for forms ones as well.
 */

/* --------- prototypes for libmenu functions ----------------------------- */

ITEM** menu_items(const MENU* menuVar);
ITEM* current_item(const MENU* menuVar);
ITEM* new_item(immutable char* name, immutable char* description);

MENU* new_menu(ITEM** items);

OPTIONS item_opts(const ITEM* item);
OPTIONS menu_opts(const MENU* menuVar);
//TODO check I think it needs to return a MENU, this was fine whan MENU was a void..
//Holy crap, using a function pointer to get around the fact that MENU isn't defined...
//void* function(MENU*) item_init(const MENU* menuVar);
//void* function(MENU*) item_term(const MENU* menuVar);
//void* function(MENU*) menu_init(const MENU* menuVar);
//void* function(MENU*) menu_term(const MENU* menuVar);
MENU* item_init(const MENU* menuVar);
MENU* item_term(const MENU* menuVar);
MENU* menu_init(const MENU* menuVar);
MENU* menu_term(const MENU* menuVar);

WINDOW* menu_sub(const MENU* menuVar);
WINDOW* menu_win(const MENU* menuVar);

immutable(char*) item_description(const ITEM* item);
immutable(char*) item_name(const ITEM* item);
immutable(char*) menu_mark(const MENU* menuVar);
immutable(char*) menu_request_name(int request);

immutable(char*) menu_pattern(const MENU* menuVar);

void* menu_userptr(const MENU* menuVar);
void* item_userptr(const ITEM* item);

chtype menu_back(const MENU* menuVar);
chtype menu_fore(const MENU* menuVar);
chtype menu_grey(const MENU* menuVar);

int free_item(ITEM* item);
int free_menu(MENU* menuVar);
int item_count(const MENU* menuVar);
int item_index(const ITEM* item);
int item_opts_off(ITEM* item, Item_Options opts);
int item_opts_on(ITEM* item, Item_Options opts);
int menu_driver(MENU* menuVar, int c);
int menu_opts_off(MENU* menuVar, Menu_Options opts);
int menu_opts_on(MENU* menuVar, Menu_Options opts);
int menu_pad(const MENU* menuVar);
int pos_menu_cursor(const MENU* menuVar);
int post_menu(MENU* menuVar);
int scale_menu(const MENU* menuVar, int* rows, int* columns);
int set_current_item(MENU* menuVar, ITEM* item);
int set_item_init(MENU* menuVar, MENU* func);
int set_item_opts(ITEM* item, Item_Options opts);
int set_item_term(MENU* menuVar, MENU* func);
int set_item_userptr(ITEM* item, void* userptr);
int set_item_value(ITEM* item, bool value);
int set_menu_back(MENU* menuVar, chtype attr);
int set_menu_fore(MENU* menuVar, chtype attr);
int set_menu_format(MENU* menuVar, int rows, int cols);
int set_menu_grey(MENU* menuVar, chtype attr);
int set_menu_init(MENU* menuVar, MENU* func);
int set_menu_items(MENU* menuVar, ITEM** items);
int set_menu_mark(MENU* menuVar, immutable char* mark);
int set_menu_opts(MENU* menuVar, OPTIONS opts);
int set_menu_pad(MENU* menuVar, int pad);
int set_menu_pattern(MENU* menuVar, immutable char* pattern);
int set_menu_sub(MENU* menuVar, WINDOW* sub);
int set_menu_term(MENU* menuVar, MENU* func);
int set_menu_userptr(MENU* menuVar, void* userptr);
int set_menu_win(MENU* menuVar, WINDOW* win);
int set_top_row(MENU* menuVar, int row);
int top_row(const MENU* menuVar);
int unpost_menu(MENU* menuVar);
int menu_request_by_name(immutable char* name);
int set_menu_spacing(MENU* menuVar, int spc_description, int spc_rows, int spc_columns);
int menu_spacing(MENU* menuVar, int* spc_description, int* spc_rows, int* spc_columns);


bool item_value(const ITEM* item);
bool item_visible(const ITEM* item);

void menu_format(const MENU* menuVar, int* rows, int* cols);
}//end extern (C)
