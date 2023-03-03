/****************************************************************************
 * Copyright 2020 Thomas E. Dickey                                          *
 * Copyright 1998-2009,2017 Free Software Foundation, Inc.                  *
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
 *  Author: Zeyd M. Ben-Halim <zmbenhal@netcom.com> 1995                    *
 *     and: Eric S. Raymond <esr@snark.thyrsus.com>                         *
 *     and: Juergen Pfeifer                         1996-1999,2008          *
 ****************************************************************************/

/* $Id: panel.h,v 1.14 2020/07/04 20:38:43 tom Exp $ */

/* panel.h -- interface file for panels library */

module deimos.panel;

extern (C):

public import deimos.curses;

struct panel
// #if !NCURSES_OPAQUE_PANEL
{
  WINDOW *win;
  panel *below;
  panel *above;
  NCURSES_CONST!void *user;
}
// #endif /* !NCURSES_OPAQUE_PANEL */
alias PANEL = panel;

// D porting note: this replaces PANEL_WRAPPED_VAR and NCURSES_PUBLIC_VAR.
mixin template PANEL_D_VAR(type,string name)
{
	mixin("
		extern /*PANEL_IMPEXP*/ type " ~ NCURSES_PUBLIC_VAR(name) ~ "();
		@property auto " ~ name ~ "() { pragma(inline, true); return " ~ NCURSES_PUBLIC_VAR(name) ~ "(); }
	");
}

// D porting note: "export"/"extern" must be moved to the declaration, it cannot be added here.
alias PANEL_EXPORT(type) = /*PANEL_IMPEXP*/ type /*NCURSES_API*/;
alias PANEL_EXPORT_VAR(type) = /*PANEL_IMPEXP*/ type;

extern nothrow @nogc PANEL_EXPORT!(WINDOW*) panel_window (const(PANEL) *);
extern nothrow @nogc PANEL_EXPORT!(void)    update_panels ();
extern nothrow @nogc PANEL_EXPORT!(int)     hide_panel (PANEL *);
extern nothrow @nogc PANEL_EXPORT!(int)     show_panel (PANEL *);
extern nothrow @nogc PANEL_EXPORT!(int)     del_panel (PANEL *);
extern nothrow @nogc PANEL_EXPORT!(int)     top_panel (PANEL *);
extern nothrow @nogc PANEL_EXPORT!(int)     bottom_panel (PANEL *);
extern nothrow @nogc PANEL_EXPORT!(PANEL*)  new_panel (WINDOW *);
extern nothrow @nogc PANEL_EXPORT!(PANEL*)  panel_above (const(PANEL) *);
extern nothrow @nogc PANEL_EXPORT!(PANEL*)  panel_below (const(PANEL) *);
extern nothrow @nogc PANEL_EXPORT!(int)     set_panel_userptr (PANEL *, NCURSES_CONST!void *);
extern nothrow @nogc PANEL_EXPORT!(NCURSES_CONST!void*) panel_userptr (const(PANEL) *);
extern nothrow @nogc PANEL_EXPORT!(int)     move_panel (PANEL *, int, int);
extern nothrow @nogc PANEL_EXPORT!(int)     replace_panel (PANEL *,WINDOW *);
extern nothrow @nogc PANEL_EXPORT!(int)     panel_hidden (const(PANEL) *);

static if (NCURSES_SP_FUNCS) {
extern nothrow @nogc PANEL_EXPORT!(PANEL *) ground_panel(SCREEN *);
extern nothrow @nogc PANEL_EXPORT!(PANEL *) ceiling_panel(SCREEN *);

extern nothrow @nogc PANEL_EXPORT!(void)    NCURSES_SP_NAME(update_panels) (SCREEN*);
}

/* end of panel.h */
