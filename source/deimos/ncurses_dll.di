/****************************************************************************
 * Copyright 2018,2020 Thomas E. Dickey                                     *
 * Copyright 2009,2014 Free Software Foundation, Inc.                       *
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
/* $Id: ncurses_dll.h.in,v 1.17 2020/09/05 17:58:47 juergen Exp $ */

module deimos.ncurses_dll;

/*
 * For reentrant code, we map the various global variables into SCREEN by
 * using functions to access them.
 */
auto  NCURSES_PUBLIC_VAR(name)(name name) { pragma(inline, true); return "_nc_" ~ name; }

// D porting note: this replaces NCURSES_WRAPPED_VAR and NCURSES_PUBLIC_VAR.
mixin template NCURSES_D_VAR(type,string name)
{
	mixin("
		extern __gshared /*NCURSES_IMPEXP*/ type " ~ NCURSES_PUBLIC_VAR(name) ~ "();
		@property ref auto " ~ name ~ "() { pragma(inline, true); return " ~ NCURSES_PUBLIC_VAR(name) ~ "(); }
	");
}

// D porting note: "export"/"extern" must be moved to the declaration, it cannot be added here.
alias NCURSES_EXPORT(type) = /*NCURSES_IMPEXP*/ type /*NCURSES_API*/;
alias NCURSES_EXPORT_VAR(type) = /*extern*/ /*NCURSES_IMPEXP*/ type;
