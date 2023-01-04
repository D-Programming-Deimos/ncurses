/****************************************************************************
 * Copyright 2020 Thomas E. Dickey                                          *
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

/* $Id: menu.h,v 1.26 2020/12/12 00:38:02 tom Exp $ */

module deimos.menu;

extern(C):

version (AMIGA) {
alias TEXT = TEXT_ncurses;
}

public import deimos.curses;
public import deimos.eti;

// D porting note: this replaces MENU_WRAPPED_VAR and NCURSES_PUBLIC_VAR.
mixin template MENU_D_VAR(type,string name)
{
	mixin("
		extern /*MENU_IMPEXP*/ type " ~ NCURSES_PUBLIC_VAR(name) ~ "();
		@property auto " ~ name ~ "() { pragma(inline, true); return " ~ NCURSES_PUBLIC_VAR(name) ~ "(); }
	");
}

// D porting note: "export"/"extern" must be moved to the declaration, it cannot be added here.
alias MENU_EXPORT(type) = /*MENU_IMPEXP*/ type /*NCURSES_API*/;
alias MENU_EXPORT_VAR(type) = /*MENU_IMPEXP*/ type;

  alias Menu_Options  = int;
  alias Item_Options  = int;

/* Menu options: */
enum O_ONEVALUE      = (0x01);
enum O_SHOWDESC      = (0x02);
enum O_ROWMAJOR      = (0x04);
enum O_IGNORECASE    = (0x08);
enum O_SHOWMATCH     = (0x10);
enum O_NONCYCLIC     = (0x20);
enum O_MOUSE_MENU    = (0x40);

/* Item options: */
enum O_SELECTABLE    = (0x01);

static if (!NCURSES_OPAQUE_MENU) {
  struct TEXT
    {
      const(char) *str;
      ushort length;
    }
}                          /* !NCURSES_OPAQUE_MENU */

  // struct tagMENU;

  struct tagITEM
// #if !NCURSES_OPAQUE_MENU
    {
      TEXT name;		/* name of menu item                         */
      TEXT description;		/* description of item, optional in display  */
      tagMENU *imenu;	/* Pointer to parent menu                    */
      void *userptr;		/* Pointer to user defined per item data     */
      Item_Options opt;		/* Item options                              */
      short index;		/* Item number if connected to a menu        */
      short y;			/* y and x location of item in menu          */
      short x;
      bool value;		/* Selection value                           */

      tagITEM *left;	/* neighbor items                            */
      tagITEM *right;
      tagITEM *up;
      tagITEM *down;

    }
// #endif				/* !NCURSES_OPAQUE_MENU */
  alias ITEM = tagITEM;

  alias Menu_Hook  = void function (tagMENU *);

  struct tagMENU
// #if 1				/* not yet: !NCURSES_OPAQUE_MENU   */
    {
      short height;		/* Nr. of chars high               */
      short width;		/* Nr. of chars wide               */
      short rows;		/* Nr. of items high               */
      short cols;		/* Nr. of items wide               */
      short frows;		/* Nr. of formatted items high     */
      short fcols;		/* Nr. of formatted items wide     */
      short arows;		/* Nr. of items high (actual)      */
      short namelen;		/* Max. name length                */
      short desclen;		/* Max. description length         */
      short marklen;		/* Length of mark, if any          */
      short itemlen;		/* Length of one item              */
      short spc_desc;		/* Spacing for descriptor          */
      short spc_cols;		/* Spacing for columns             */
      short spc_rows;		/* Spacing for rows                */
      char *pattern;		/* Buffer to store match chars     */
      short pindex;		/* Index into pattern buffer       */
      WINDOW *win;		/* Window containing menu          */
      WINDOW *sub;		/* Subwindow for menu display      */
      WINDOW *userwin;		/* User's window                   */
      WINDOW *usersub;		/* User's subwindow                */
      ITEM **items;		/* array of items                  */
      short nitems;		/* Nr. of items in menu            */
      ITEM *curitem;		/* Current item                    */
      short toprow;		/* Top row of menu                 */
      chtype fore;		/* Selection attribute             */
      chtype back;		/* Nonselection attribute          */
      chtype grey;		/* Inactive attribute              */
      ubyte pad;        /* Pad character                   */

      Menu_Hook menuinit;	/* User hooks                      */
      Menu_Hook menuterm;
      Menu_Hook iteminit;
      Menu_Hook itemterm;

      void *userptr;		/* Pointer to menus user data      */
      char *mark;		/* Pointer to marker string        */

      Menu_Options opt;		/* Menu options                    */
      ushort status;    /* Internal state of menu          */
    }
// #endif				/* !NCURSES_OPAQUE_MENU */
  alias MENU = tagMENU;

/* Define keys */

enum REQ_LEFT_ITEM           = (KEY_MAX + 1);
enum REQ_RIGHT_ITEM          = (KEY_MAX + 2);
enum REQ_UP_ITEM             = (KEY_MAX + 3);
enum REQ_DOWN_ITEM           = (KEY_MAX + 4);
enum REQ_SCR_ULINE           = (KEY_MAX + 5);
enum REQ_SCR_DLINE           = (KEY_MAX + 6);
enum REQ_SCR_DPAGE           = (KEY_MAX + 7);
enum REQ_SCR_UPAGE           = (KEY_MAX + 8);
enum REQ_FIRST_ITEM          = (KEY_MAX + 9);
enum REQ_LAST_ITEM           = (KEY_MAX + 10);
enum REQ_NEXT_ITEM           = (KEY_MAX + 11);
enum REQ_PREV_ITEM           = (KEY_MAX + 12);
enum REQ_TOGGLE_ITEM         = (KEY_MAX + 13);
enum REQ_CLEAR_PATTERN       = (KEY_MAX + 14);
enum REQ_BACK_PATTERN        = (KEY_MAX + 15);
enum REQ_NEXT_MATCH          = (KEY_MAX + 16);
enum REQ_PREV_MATCH          = (KEY_MAX + 17);

enum MIN_MENU_COMMAND        = (KEY_MAX + 1);
enum MAX_MENU_COMMAND        = (KEY_MAX + 17);

/*
 * Some AT&T code expects MAX_COMMAND to be out-of-band not
 * just for menu commands but for forms ones as well.
 */
// #if defined(MAX_COMMAND)
// #  if (MAX_MENU_COMMAND > MAX_COMMAND)
// #    error Something is wrong -- MAX_MENU_COMMAND is greater than MAX_COMMAND
// #  elif (MAX_COMMAND != (KEY_MAX + 128))
// #    error Something is wrong -- MAX_COMMAND is already inconsistently defined.
// #  endif
// #else
  enum MAX_COMMAND = (KEY_MAX + 128);
// #endif

/* --------- prototypes for libmenu functions ----------------------------- */

  extern nothrow @nogc MENU_EXPORT!(ITEM **) menu_items(const(MENU) *);
  extern nothrow @nogc MENU_EXPORT!(ITEM *) current_item(const(MENU) *);
  extern nothrow @nogc MENU_EXPORT!(ITEM *) new_item(const(char) *, const(char) *);

  extern nothrow @nogc MENU_EXPORT!(MENU *) new_menu(ITEM **);

  extern nothrow @nogc MENU_EXPORT!(Item_Options) item_opts(const(ITEM) *);
  extern nothrow @nogc MENU_EXPORT!(Menu_Options) menu_opts(const(MENU) *);

  extern nothrow @nogc MENU_EXPORT!(Menu_Hook) item_init(const(MENU) *);
  extern nothrow @nogc MENU_EXPORT!(Menu_Hook) item_term(const(MENU) *);
  extern nothrow @nogc MENU_EXPORT!(Menu_Hook) menu_init(const(MENU) *);
  extern nothrow @nogc MENU_EXPORT!(Menu_Hook) menu_term(const(MENU) *);

  extern nothrow @nogc MENU_EXPORT!(WINDOW *) menu_sub(const(MENU) *);
  extern nothrow @nogc MENU_EXPORT!(WINDOW *) menu_win(const(MENU) *);

  extern nothrow @nogc MENU_EXPORT!(const(char) *) item_description(const(ITEM) *);
  extern nothrow @nogc MENU_EXPORT!(const(char) *) item_name(const(ITEM) *);
  extern nothrow @nogc MENU_EXPORT!(const(char) *) menu_mark(const(MENU) *);
  extern nothrow @nogc MENU_EXPORT!(const(char) *) menu_request_name(int);

  extern nothrow @nogc MENU_EXPORT!(char *) menu_pattern(const(MENU) *);

  extern nothrow @nogc MENU_EXPORT!(void *) menu_userptr(const(MENU) *);
  extern nothrow @nogc MENU_EXPORT!(void *) item_userptr(const(ITEM) *);

  extern nothrow @nogc MENU_EXPORT!(chtype) menu_back(const(MENU) *);
  extern nothrow @nogc MENU_EXPORT!(chtype) menu_fore(const(MENU) *);
  extern nothrow @nogc MENU_EXPORT!(chtype) menu_grey(const(MENU) *);

  extern nothrow @nogc MENU_EXPORT!(int) free_item(ITEM *);
  extern nothrow @nogc MENU_EXPORT!(int) free_menu(MENU *);
  extern nothrow @nogc MENU_EXPORT!(int) item_count(const(MENU) *);
  extern nothrow @nogc MENU_EXPORT!(int) item_index(const(ITEM) *);
  extern nothrow @nogc MENU_EXPORT!(int) item_opts_off(ITEM *, Item_Options);
  extern nothrow @nogc MENU_EXPORT!(int) item_opts_on(ITEM *, Item_Options);
  extern nothrow @nogc MENU_EXPORT!(int) menu_driver(MENU *, int);
  extern nothrow @nogc MENU_EXPORT!(int) menu_opts_off(MENU *, Menu_Options);
  extern nothrow @nogc MENU_EXPORT!(int) menu_opts_on(MENU *, Menu_Options);
  extern nothrow @nogc MENU_EXPORT!(int) menu_pad(const(MENU) *);
  extern nothrow @nogc MENU_EXPORT!(int) pos_menu_cursor(const(MENU) *);
  extern nothrow @nogc MENU_EXPORT!(int) post_menu(MENU *);
  extern nothrow @nogc MENU_EXPORT!(int) scale_menu(const(MENU) *, int *, int *);
  extern nothrow @nogc MENU_EXPORT!(int) set_current_item(MENU *menu, ITEM *item);
  extern nothrow @nogc MENU_EXPORT!(int) set_item_init(MENU *, Menu_Hook);
  extern nothrow @nogc MENU_EXPORT!(int) set_item_opts(ITEM *, Item_Options);
  extern nothrow @nogc MENU_EXPORT!(int) set_item_term(MENU *, Menu_Hook);
  extern nothrow @nogc MENU_EXPORT!(int) set_item_userptr(ITEM *, void *);
  extern nothrow @nogc MENU_EXPORT!(int) set_item_value(ITEM *, bool);
  extern nothrow @nogc MENU_EXPORT!(int) set_menu_back(MENU *, chtype);
  extern nothrow @nogc MENU_EXPORT!(int) set_menu_fore(MENU *, chtype);
  extern nothrow @nogc MENU_EXPORT!(int) set_menu_format(MENU *, int, int);
  extern nothrow @nogc MENU_EXPORT!(int) set_menu_grey(MENU *, chtype);
  extern nothrow @nogc MENU_EXPORT!(int) set_menu_init(MENU *, Menu_Hook);
  extern nothrow @nogc MENU_EXPORT!(int) set_menu_items(MENU *, ITEM **);
  extern nothrow @nogc MENU_EXPORT!(int) set_menu_mark(MENU *, const(char) *);
  extern nothrow @nogc MENU_EXPORT!(int) set_menu_opts(MENU *, Menu_Options);
  extern nothrow @nogc MENU_EXPORT!(int) set_menu_pad(MENU *, int);
  extern nothrow @nogc MENU_EXPORT!(int) set_menu_pattern(MENU *, const(char) *);
  extern nothrow @nogc MENU_EXPORT!(int) set_menu_sub(MENU *, WINDOW *);
  extern nothrow @nogc MENU_EXPORT!(int) set_menu_term(MENU *, Menu_Hook);
  extern nothrow @nogc MENU_EXPORT!(int) set_menu_userptr(MENU *, void *);
  extern nothrow @nogc MENU_EXPORT!(int) set_menu_win(MENU *, WINDOW *);
  extern nothrow @nogc MENU_EXPORT!(int) set_top_row(MENU *, int);
  extern nothrow @nogc MENU_EXPORT!(int) top_row(const(MENU) *);
  extern nothrow @nogc MENU_EXPORT!(int) unpost_menu(MENU *);
  extern nothrow @nogc MENU_EXPORT!(int) menu_request_by_name(const(char) *);
  extern nothrow @nogc MENU_EXPORT!(int) set_menu_spacing(MENU *, int, int, int);
  extern nothrow @nogc MENU_EXPORT!(int) menu_spacing(const(MENU) *, int *, int *, int *);

  extern nothrow @nogc MENU_EXPORT!(bool) item_value(const(ITEM) *);
  extern nothrow @nogc MENU_EXPORT!(bool) item_visible(const(ITEM) *);

  extern nothrow @nogc MENU_EXPORT!(void) menu_format(const(MENU) *, int *, int *);

static if (NCURSES_SP_FUNCS) {
  extern nothrow @nogc MENU_EXPORT!(MENU *) NCURSES_SP_NAME(new_menu) (SCREEN *, ITEM **);
}
