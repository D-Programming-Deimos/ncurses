/****************************************************************************
 * Copyright (c) 1998-2006,2009 Free Software Foundation, Inc.              *
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
/* $Id: panel.h,v 1.11 2009/04/11 19:50:40 tom Exp $ */
/* panel.h -- interface file for panels library */

module deimos.ncurses.panel;

public import deimos.ncurses.curses;

extern (C)
{

struct PANEL
{
  WINDOW*       win;
  PANEL*        below;
  PANEL*        above;
  const void*   user;
}

WINDOW* panel_window(const PANEL* pan);
void update_panels();
int hide_panel(PANEL* pan);
int show_panel(PANEL* pan);
int del_panel(PANEL* pan);
int top_panel(PANEL* pan);
int bottom_panel(PANEL* pan);
PANEL* new_panel(WINDOW* win);
PANEL* panel_above(const PANEL* pan);
PANEL* panel_below(const PANEL* pan);
int set_panel_userptr(PANEL* pan, const void* ptr);
void* panel_userptr(const PANEL* pan);
int move_panel(PANEL* pan, int starty, int startx);
int replace_panel(PANEL* pan, WINDOW* window);
int panel_hidden(const PANEL* pan);

}
/* end of panel.h */
