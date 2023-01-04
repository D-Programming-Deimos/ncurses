/****************************************************************************
 * Copyright 2018-2020,2021 Thomas E. Dickey                                *
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
 *  Author: Zeyd M. Ben-Halim <zmbenhal@netcom.com> 1992,1995               *
 *     and: Eric S. Raymond <esr@snark.thyrsus.com>                         *
 *     and: Thomas E. Dickey                        1996-on                 *
 ****************************************************************************/

/* $Id: curses.h.in,v 1.277 2021/09/24 16:07:37 tom Exp $ */
module deimos.curses;

import std.conv : octal;

extern (C):

/*
 The symbols beginning NCURSES_ or USE_ are configuration choices.
 A few of the former can be overridden by applications at compile-time.
 Most of the others correspond to configure-script options (or checks
 by the configure-script for features of the system on which it is built).

 These symbols can be overridden by applications at compile-time:
 NCURSES_NOMACROS suppresses macro definitions in favor of functions
 NCURSES_WATTR_MACROS suppresses wattr_* macro definitions
 NCURSES_WIDECHAR is an alternative for declaring wide-character functions.

 These symbols are used only when building ncurses:
 NCURSES_ATTR_T
 NCURSES_FIELD_INTERNALS
 NCURSES_INTERNALS

 These symbols are set by the configure script:
 NCURSES_ENABLE_STDBOOL_H
 NCURSES_EXPANDED
 NCURSES_EXT_COLORS
 NCURSES_EXT_FUNCS
 NCURSES_EXT_PUTWIN
 NCURSES_NO_PADDING
 NCURSES_OSPEED_COMPAT
 NCURSES_PATHSEP
 NCURSES_REENTRANT
 */

enum CURSES = 1;
enum CURSES_H = 1;

/* These are defined only in curses.h, and are used for conditional compiles */
enum NCURSES_VERSION_MAJOR = 6;
enum NCURSES_VERSION_MINOR = 3;
enum NCURSES_VERSION_PATCH = 20211021;

/* This is defined in more than one ncurses header, for identification */
enum NCURSES_VERSION = "6.3";

/*
 * Identify the mouse encoding version.
 */
enum NCURSES_MOUSE_VERSION = 2;

/*
 * Definitions to facilitate DLL's.
 */
public import deimos.ncurses_dll;

/*
 * Extra headers.
 */
static if (1) {
import core.stdc.stdint;
}

/*
 * NCURSES_ATTR_T is used to quiet compiler warnings when building ncurses
 * configured using --disable-macros.
 */
alias NCURSES_ATTR_T = int;

/*
 * Expands to 'const' if ncurses is configured using --enable-const.  Note that
 * doing so makes it incompatible with other implementations of X/Open Curses.
 */
// #undef  NCURSES_CONST
alias NCURSES_CONST(T) = const(T);

/*
 * The standard type used for color values, and for color-pairs.  The latter
 * allows the curses library to enumerate the combinations of foreground and
 * background colors used by an application, and is normally the product of the
 * total foreground and background colors.
 *
 * X/Open uses "short" for both of these types, ultimately because they are
 * numbers from the SVr4 terminal database, which uses 16-bit signed values.
 */
alias NCURSES_COLOR_T = short;

alias NCURSES_PAIRS_T = short;

/*
 * Definitions used to make WINDOW and similar structs opaque.
 */
version (NCURSES_INTERNALS) {} else {
enum NCURSES_OPAQUE       = 0;
enum NCURSES_OPAQUE_FORM  = 0;
enum NCURSES_OPAQUE_MENU  = 0;
enum NCURSES_OPAQUE_PANEL = 0;
}

/*
 * Definition used to optionally suppress wattr* macros to help with the
 * transition from ncurses5 to ncurses6 by allowing the header files to
 * be shared across development packages for ncursesw in both ABIs.
 */
static if (!is(typeof(NCURSES_WATTR_MACROS))) {
enum NCURSES_WATTR_MACROS = 0;
}

/*
 * The reentrant code relies on the opaque setting, but adds features.
 */
// static if (!is(typeof(NCURSES_REENTRANT))) {
// enum NCURSES_REENTRANT = 0;
// }

/*
 * In certain environments, we must work around linker problems for data
 */
// #undef NCURSES_BROKEN_LINKER
version (none) {
enum NCURSES_BROKEN_LINKER = 1;
}

/*
 * Control whether bindings for interop support are added.
 */
// #undef  NCURSES_INTEROP_FUNCS
enum NCURSES_INTEROP_FUNCS = 1;

/*
 * The internal type used for window dimensions.
 */
// #undef  NCURSES_SIZE_T
alias NCURSES_SIZE_T = short;

/*
 * Control whether tparm() supports varargs or fixed-parameter list.
 */
// #undef NCURSES_TPARM_VARARGS
enum NCURSES_TPARM_VARARGS = 1;

/*
 * Control type used for tparm's arguments.  While X/Open equates c_long and
 * char* values, this is not always workable for 64-bit platforms.
 */
// #undef NCURSES_TPARM_ARG
alias NCURSES_TPARM_ARG = intptr_t;

/*
 * Control whether ncurses uses wcwidth() for checking width of line-drawing
 * characters.
 */
// #undef NCURSES_WCWIDTH_GRAPHICS
enum NCURSES_WCWIDTH_GRAPHICS = 1;

/*
 * NCURSES_CH_T is used in building the library, but not used otherwise in
 * this header file, since that would make the normal/wide-character versions
 * of the header incompatible.
 */
private mixin template mixin_NCURSES_CH_T() {
alias NCURSES_CH_T = cchar_t;
}

/* types */
alias chtype = uint;
alias mmask_t = uint;

/*
 * We need FILE, etc.  Include this before checking any feature symbols.
 */
import core.stdc.stdio;

/*
 * With XPG4, you must define _XOPEN_SOURCE_EXTENDED, it is redundant (or
 * conflicting) when _XOPEN_SOURCE is 500 or greater.  If NCURSES_WIDECHAR is
 * not already defined, e.g., if the platform relies upon nonstandard feature
 * test macros, define it at this point if the standard feature test macros
 * indicate that it should be defined.
 */
enum NCURSES_WIDECHAR = 1; // D port note: we always set this to 1

import core.stdc.stdarg;        /* we need va_list */
static if (NCURSES_WIDECHAR) {
import core.stdc.stddef;        /* we want wchar_t */
}

/* X/Open and SVr4 specify that curses implements 'bool'.  However, C++ may also
 * implement it.  If so, we must use the C++ compiler's type to avoid conflict
 * with other interfaces.
 *
 * A further complication is that <stdbool.h> may declare 'bool' to be a
 * different type, such as an enum which is not necessarily compatible with
 * C++.  If we have <stdbool.h>, make 'bool' a macro, so users may #undef it.
 * Otherwise, let it remain a typedef to avoid conflicts with other #define's.
 * In either case, make a typedef for NCURSES_BOOL which can be used if needed
 * from either C or C++.
 */

enum TRUE    = 1;

enum FALSE   = 0;

alias NCURSES_BOOL = bool;

auto  NCURSES_OK_ADDR(p)(p p) { pragma(inline, true); return (null != cast(const(void) *)((p))); }

/*
 * X/Open attributes.  In the ncurses implementation, they are identical to the
 * A_ attributes.
 */
enum WA_ATTRIBUTES  = A_ATTRIBUTES;
enum WA_NORMAL      = A_NORMAL;
enum WA_STANDOUT    = A_STANDOUT;
enum WA_UNDERLINE   = A_UNDERLINE;
enum WA_REVERSE     = A_REVERSE;
enum WA_BLINK       = A_BLINK;
enum WA_DIM         = A_DIM;
enum WA_BOLD        = A_BOLD;
enum WA_ALTCHARSET  = A_ALTCHARSET;
enum WA_INVIS       = A_INVIS;
enum WA_PROTECT     = A_PROTECT;
enum WA_HORIZONTAL  = A_HORIZONTAL;
enum WA_LEFT        = A_LEFT;
enum WA_LOW         = A_LOW;
enum WA_RIGHT       = A_RIGHT;
enum WA_TOP         = A_TOP;
enum WA_VERTICAL    = A_VERTICAL;

version (all) {
enum WA_ITALIC  = A_ITALIC      /* ncurses extension */;
}

/* colors */
enum COLOR_BLACK     = 0;
enum COLOR_RED       = 1;
enum COLOR_GREEN     = 2;
enum COLOR_YELLOW    = 3;
enum COLOR_BLUE      = 4;
enum COLOR_MAGENTA   = 5;
enum COLOR_CYAN      = 6;
enum COLOR_WHITE     = 7;

/* line graphics */

extern nothrow @nogc __gshared chtype[256] acs_map;

@property auto NCURSES_ACS(C)(C c) { pragma(inline, true); return acs_map[cast(ubyte)c]; }

/* VT100 symbols begin here */
@property auto ACS_ULCORNER   ()() { pragma(inline, true); return NCURSES_ACS('l'); } /* upper left corner */
@property auto ACS_LLCORNER   ()() { pragma(inline, true); return NCURSES_ACS('m'); } /* lower left corner */
@property auto ACS_URCORNER   ()() { pragma(inline, true); return NCURSES_ACS('k'); } /* upper right corner */
@property auto ACS_LRCORNER   ()() { pragma(inline, true); return NCURSES_ACS('j'); } /* lower right corner */
@property auto ACS_LTEE       ()() { pragma(inline, true); return NCURSES_ACS('t'); } /* tee pointing right */
@property auto ACS_RTEE       ()() { pragma(inline, true); return NCURSES_ACS('u'); } /* tee pointing left */
@property auto ACS_BTEE       ()() { pragma(inline, true); return NCURSES_ACS('v'); } /* tee pointing up */
@property auto ACS_TTEE       ()() { pragma(inline, true); return NCURSES_ACS('w'); } /* tee pointing down */
@property auto ACS_HLINE      ()() { pragma(inline, true); return NCURSES_ACS('q'); } /* horizontal line */
@property auto ACS_VLINE      ()() { pragma(inline, true); return NCURSES_ACS('x'); } /* vertical line */
@property auto ACS_PLUS       ()() { pragma(inline, true); return NCURSES_ACS('n'); } /* large plus or crossover */
@property auto ACS_S1         ()() { pragma(inline, true); return NCURSES_ACS('o'); } /* scan line 1 */
@property auto ACS_S9         ()() { pragma(inline, true); return NCURSES_ACS('s'); } /* scan line 9 */
@property auto ACS_DIAMOND    ()() { pragma(inline, true); return NCURSES_ACS('`'); } /* diamond */
@property auto ACS_CKBOARD    ()() { pragma(inline, true); return NCURSES_ACS('a'); } /* checker board (stipple) */
@property auto ACS_DEGREE     ()() { pragma(inline, true); return NCURSES_ACS('f'); } /* degree symbol */
@property auto ACS_PLMINUS    ()() { pragma(inline, true); return NCURSES_ACS('g'); } /* plus/minus */
@property auto ACS_BULLET     ()() { pragma(inline, true); return NCURSES_ACS('~'); } /* bullet */
/* Teletype 5410v1 symbols begin here */
@property auto ACS_LARROW     ()() { pragma(inline, true); return NCURSES_ACS(','); } /* arrow pointing left */
@property auto ACS_RARROW     ()() { pragma(inline, true); return NCURSES_ACS('+'); } /* arrow pointing right */
@property auto ACS_DARROW     ()() { pragma(inline, true); return NCURSES_ACS('.'); } /* arrow pointing down */
@property auto ACS_UARROW     ()() { pragma(inline, true); return NCURSES_ACS('-'); } /* arrow pointing up */
@property auto ACS_BOARD      ()() { pragma(inline, true); return NCURSES_ACS('h'); } /* board of squares */
@property auto ACS_LANTERN    ()() { pragma(inline, true); return NCURSES_ACS('i'); } /* lantern symbol */
@property auto ACS_BLOCK      ()() { pragma(inline, true); return NCURSES_ACS('0'); } /* solid square block */
/*
 * These aren't documented, but a lot of System Vs have them anyway
 * (you can spot pprryyzz{{||}} in a lot of AT&T terminfo strings).
 * The ACS_names may not match AT&T's, our source didn't know them.
 */
@property auto ACS_S3         ()() { pragma(inline, true); return NCURSES_ACS('p'); } /* scan line 3 */
@property auto ACS_S7         ()() { pragma(inline, true); return NCURSES_ACS('r'); } /* scan line 7 */
@property auto ACS_LEQUAL     ()() { pragma(inline, true); return NCURSES_ACS('y'); } /* less/equal */
@property auto ACS_GEQUAL     ()() { pragma(inline, true); return NCURSES_ACS('z'); } /* greater/equal */
@property auto ACS_PI         ()() { pragma(inline, true); return NCURSES_ACS('{'); } /* Pi */
@property auto ACS_NEQUAL     ()() { pragma(inline, true); return NCURSES_ACS('|'); } /* not equal */
@property auto ACS_STERLING   ()() { pragma(inline, true); return NCURSES_ACS('}'); } /* UK pound sign */

/*
 * Line drawing ACS names are of the form ACS_trbl, where t is the top, r
 * is the right, b is the bottom, and l is the left.  t, r, b, and l might
 * be B (blank), S (single), D (double), or T (thick).  The subset defined
 * here only uses B and S.
 */
@property auto ACS_BSSB        () { pragma(inline, true); return ACS_ULCORNER; }
@property auto ACS_SSBB        () { pragma(inline, true); return ACS_LLCORNER; }
@property auto ACS_BBSS        () { pragma(inline, true); return ACS_URCORNER; }
@property auto ACS_SBBS        () { pragma(inline, true); return ACS_LRCORNER; }
@property auto ACS_SBSS        () { pragma(inline, true); return ACS_RTEE; }
@property auto ACS_SSSB        () { pragma(inline, true); return ACS_LTEE; }
@property auto ACS_SSBS        () { pragma(inline, true); return ACS_BTEE; }
@property auto ACS_BSSS        () { pragma(inline, true); return ACS_TTEE; }
@property auto ACS_BSBS        () { pragma(inline, true); return ACS_HLINE; }
@property auto ACS_SBSB        () { pragma(inline, true); return ACS_VLINE; }
@property auto ACS_SSSS        () { pragma(inline, true); return ACS_PLUS; }

enum ERR     = (-1);

enum OK      = (0);

/* values for the _flags member */
enum _SUBWIN         = 0x01;    /* is this a sub-window? */
enum _ENDLINE        = 0x02;    /* is the window flush right? */
enum _FULLWIN        = 0x04;    /* is the window full-screen? */
enum _SCROLLWIN      = 0x08;    /* bottom edge is at screen bottom? */
enum _ISPAD          = 0x10;    /* is this window a pad? */
enum _HASMOVED       = 0x20;    /* has cursor moved since last refresh? */
enum _WRAPPED        = 0x40;    /* cursor was just wrappped */

/*
 * this value is used in the firstchar and lastchar fields to mark
 * unchanged lines
 */
enum _NOCHANGE       = -1;

/*
 * this value is used in the oldindex field to mark lines created by insertions
 * and scrolls.
 */
enum _NEWINDEX       = -1;

struct screen;
alias SCREEN = screen;

// D porting note: WINDOW moved to the bottom of the file

alias attr_t = chtype;          /* ...must be at least as wide as chtype */

static if (NCURSES_WIDECHAR) {

version (all) {
import core.stdc.wchar_;    /* ...to get mbstate_t, etc. */
}

version (none) {
alias wchar_t1 = ushort;
}

version (none) {
alias wint_t1 = uint;
}

/*
 * cchar_t stores an array of CCHARW_MAX wide characters.  The first is
 * normally a spacing character.  The others are non-spacing.  If those
 * (spacing and nonspacing) do not fill the array, a null L'\0' follows.
 * Otherwise, a null is assumed to follow when extracting via getcchar().
 */
enum CCHARW_MAX      = 5;
struct cchar_t
{
    attr_t      attr;
    wchar_t[CCHARW_MAX] chars;
version (all) {
    int         ext_color;      /* color pair, must be more than 16-bits */
}
}
enum NCURSES_EXT_COLORS = 20211021;

} /* NCURSES_WIDECHAR */

static if (!NCURSES_OPAQUE) {
struct ldat;

struct _win_st
{
        NCURSES_SIZE_T _cury, _curx; /* current cursor position */

        /* window location and size */
        NCURSES_SIZE_T _maxy, _maxx; /* maximums of x and y, NOT window size */
        NCURSES_SIZE_T _begy, _begx; /* screen coords of upper-left-hand corner */

        short   _flags;         /* window state flags */

        /* attribute tracking */
        attr_t  _attrs;         /* current attribute for non-space character */
        chtype  _bkgd;          /* current background char/attribute pair */

        /* option values set by user */
        bool    _notimeout;     /* no time out on function-key entry? */
        bool    _clear;         /* consider all data in the window invalid? */
        bool    _leaveok;       /* OK to not reset cursor on exit? */
        bool    _scroll;        /* OK to scroll this window? */
        bool    _idlok;         /* OK to use insert/delete line? */
        bool    _idcok;         /* OK to use insert/delete char? */
        bool    _immed;         /* window in immed mode? (not yet used) */
        bool    _sync;          /* window in sync mode? */
        bool    _use_keypad;    /* process function keys into KEY_ symbols? */
        int     _delay;         /* 0 = nodelay, <0 = blocking, >0 = delay */

        ldat *_line;    /* the actual line data */

        /* global screen state */
        NCURSES_SIZE_T _regtop; /* top line of scrolling region */
        NCURSES_SIZE_T _regbottom; /* bottom line of scrolling region */

        /* these are used only if this is a sub-window */
        int     _parx;          /* x coordinate of this window in parent */
        int     _pary;          /* y coordinate of this window in parent */
        WINDOW  *_parent;       /* pointer to parent if a sub-window */

        /* these are used only if this is a pad */
        struct pdat
        {
            NCURSES_SIZE_T _pad_y,      _pad_x;
            NCURSES_SIZE_T _pad_top,    _pad_left;
            NCURSES_SIZE_T _pad_bottom, _pad_right;
        } pdat _pad;

        NCURSES_SIZE_T _yoffset; /* real begy is _begy + _yoffset */

static if (NCURSES_WIDECHAR) {
        cchar_t  _bkgrnd;       /* current background char/attribute pair */
version (all) {
        int     _color;         /* current color-pair for non-space character */
}
}
}
} /* NCURSES_OPAQUE */

/*
 * Curses uses a helper function.  Define our type for this to simplify
 * extending it for the sp-funcs feature.
 */
alias NCURSES_OUTC = int function(int);

/*
 * Function prototypes.  This is the complete X/Open Curses list of required
 * functions.  Those marked `generated' will have sources generated from the
 * macro definitions later in this file, in order to satisfy XPG4.2
 * requirements.
 */

// extern nothrow @nogc int addch (const(chtype));                        /* generated */
// extern nothrow @nogc int addchnstr (const(chtype) *, int);             /* generated */
// extern nothrow @nogc int addchstr (const(chtype) *);                   /* generated */
// extern nothrow @nogc int addnstr (const(char) *, int);                 /* generated */
// extern nothrow @nogc int addstr (const(char) *);                       /* generated */
// extern nothrow @nogc int attroff (NCURSES_ATTR_T);                    /* generated */
// extern nothrow @nogc int attron (NCURSES_ATTR_T);                     /* generated */
// extern nothrow @nogc int attrset (NCURSES_ATTR_T);                    /* generated */
// extern nothrow @nogc int attr_get (attr_t *, NCURSES_PAIRS_T *, void *);      /* generated */
// extern nothrow @nogc int attr_off (attr_t, void *);                   /* generated */
// extern nothrow @nogc int attr_on (attr_t, void *);                    /* generated */
// extern nothrow @nogc int attr_set (attr_t, NCURSES_PAIRS_T, void *);          /* generated */
extern nothrow @nogc int baudrate ();                                 /* implemented */
extern nothrow @nogc int beep  ();                                    /* implemented */
// extern nothrow @nogc int bkgd (chtype);                               /* generated */
// extern nothrow @nogc void bkgdset (chtype);                           /* generated */
// extern nothrow @nogc int border (chtype,chtype,chtype,chtype,chtype,chtype,chtype,chtype);    /* generated */
// extern nothrow @nogc int box (WINDOW *, chtype, chtype);              /* generated */
extern nothrow @nogc bool can_change_color ();                        /* implemented */
extern nothrow @nogc int cbreak ();                                   /* implemented */
// extern nothrow @nogc int chgat (int, attr_t, NCURSES_PAIRS_T, const(void) *);  /* generated */
// extern nothrow @nogc int clear ();                                    /* generated */
extern nothrow @nogc int clearok (WINDOW *,bool);                     /* implemented */
// extern nothrow @nogc int clrtobot ();                                 /* generated */
// extern nothrow @nogc int clrtoeol ();                                 /* generated */
extern nothrow @nogc int color_content (NCURSES_COLOR_T,NCURSES_COLOR_T*,NCURSES_COLOR_T*,NCURSES_COLOR_T*);  /* implemented */
// extern nothrow @nogc int color_set (NCURSES_PAIRS_T,void*);                   /* generated */
// extern nothrow @nogc int COLOR_PAIR (int);                            /* generated */
extern nothrow @nogc int copywin (const(WINDOW)*,WINDOW*,int,int,int,int,int,int,int); /* implemented */
extern nothrow @nogc int curs_set (int);                              /* implemented */
extern nothrow @nogc int def_prog_mode ();                            /* implemented */
extern nothrow @nogc int def_shell_mode ();                           /* implemented */
extern nothrow @nogc int delay_output (int);                          /* implemented */
// extern nothrow @nogc int delch ();                                    /* generated */
extern nothrow @nogc void delscreen (SCREEN *);                       /* implemented */
extern nothrow @nogc int delwin (WINDOW *);                           /* implemented */
// extern nothrow @nogc int deleteln ();                                 /* generated */
extern nothrow @nogc WINDOW * derwin (WINDOW *,int,int,int,int);      /* implemented */
extern nothrow @nogc int doupdate ();                                 /* implemented */
extern nothrow @nogc WINDOW * dupwin (WINDOW *);                      /* implemented */
extern nothrow @nogc int echo ();                                     /* implemented */
// extern nothrow @nogc int echochar (const(chtype));                     /* generated */
// extern nothrow @nogc int erase ();                                    /* generated */
extern nothrow @nogc int endwin ();                                   /* implemented */
extern nothrow @nogc char erasechar ();                               /* implemented */
extern nothrow @nogc void filter ();                                  /* implemented */
extern nothrow @nogc int flash ();                                    /* implemented */
extern nothrow @nogc int flushinp ();                                 /* implemented */
// extern nothrow @nogc chtype getbkgd (WINDOW *);                       /* generated */
// extern nothrow @nogc int getch ();                                    /* generated */
// extern nothrow @nogc int getnstr (char *, int);                       /* generated */
// extern nothrow @nogc int getstr (char *);                             /* generated */
extern nothrow @nogc WINDOW * getwin (FILE *);                        /* implemented */
extern nothrow @nogc int halfdelay (int);                             /* implemented */
extern nothrow @nogc bool has_colors ();                              /* implemented */
extern nothrow @nogc bool has_ic ();                                  /* implemented */
extern nothrow @nogc bool has_il ();                                  /* implemented */
// extern nothrow @nogc int hline (chtype, int);                         /* generated */
extern nothrow @nogc void idcok (WINDOW *, bool);                     /* implemented */
extern nothrow @nogc int idlok (WINDOW *, bool);                      /* implemented */
extern nothrow @nogc void immedok (WINDOW *, bool);                   /* implemented */
// extern nothrow @nogc chtype inch ();                                  /* generated */
// extern nothrow @nogc int inchnstr (chtype *, int);                    /* generated */
// extern nothrow @nogc int inchstr (chtype *);                          /* generated */
extern nothrow @nogc WINDOW * initscr ();                             /* implemented */
extern nothrow @nogc int init_color (NCURSES_COLOR_T,NCURSES_COLOR_T,NCURSES_COLOR_T,NCURSES_COLOR_T);        /* implemented */
extern nothrow @nogc int init_pair (NCURSES_PAIRS_T,NCURSES_COLOR_T,NCURSES_COLOR_T);         /* implemented */
// extern nothrow @nogc int innstr (char *, int);                        /* generated */
// extern nothrow @nogc int insch (chtype);                              /* generated */
// extern nothrow @nogc int insdelln (int);                              /* generated */
// extern nothrow @nogc int insertln ();                                 /* generated */
// extern nothrow @nogc int insnstr (const(char) *, int);                 /* generated */
// extern nothrow @nogc int insstr (const(char) *);                       /* generated */
// extern nothrow @nogc int instr (char *);                              /* generated */
extern nothrow @nogc int intrflush (WINDOW *,bool);                   /* implemented */
extern nothrow @nogc bool isendwin ();                                /* implemented */
extern nothrow @nogc bool is_linetouched (WINDOW *,int);              /* implemented */
extern nothrow @nogc bool is_wintouched (WINDOW *);                   /* implemented */
extern nothrow @nogc NCURSES_CONST!char * keyname (int);              /* implemented */
extern nothrow @nogc int keypad (WINDOW *,bool);                      /* implemented */
extern nothrow @nogc char killchar ();                                /* implemented */
extern nothrow @nogc int leaveok (WINDOW *,bool);                     /* implemented */
extern nothrow @nogc char * longname ();                              /* implemented */
extern nothrow @nogc int meta (WINDOW *,bool);                        /* implemented */
// extern nothrow @nogc int move (int, int);                             /* generated */
// extern nothrow @nogc int mvaddch (int, int, const(chtype));            /* generated */
// extern nothrow @nogc int mvaddchnstr (int, int, const(chtype) *, int); /* generated */
// extern nothrow @nogc int mvaddchstr (int, int, const(chtype) *);       /* generated */
// extern nothrow @nogc int mvaddnstr (int, int, const(char) *, int);     /* generated */
// extern nothrow @nogc int mvaddstr (int, int, const(char) *);           /* generated */
// extern nothrow @nogc int mvchgat (int, int, int, attr_t, NCURSES_PAIRS_T, const(void) *);      /* generated */
extern nothrow @nogc int mvcur (int,int,int,int);                     /* implemented */
// extern nothrow @nogc int mvdelch (int, int);                          /* generated */
extern nothrow @nogc int mvderwin (WINDOW *, int, int);               /* implemented */
// extern nothrow @nogc int mvgetch (int, int);                          /* generated */
// extern nothrow @nogc int mvgetnstr (int, int, char *, int);           /* generated */
// extern nothrow @nogc int mvgetstr (int, int, char *);                 /* generated */
// extern nothrow @nogc int mvhline (int, int, chtype, int);             /* generated */
// extern nothrow @nogc chtype mvinch (int, int);                        /* generated */
// extern nothrow @nogc int mvinchnstr (int, int, chtype *, int);        /* generated */
// extern nothrow @nogc int mvinchstr (int, int, chtype *);              /* generated */
// extern nothrow @nogc int mvinnstr (int, int, char *, int);            /* generated */
// extern nothrow @nogc int mvinsch (int, int, chtype);                  /* generated */
// extern nothrow @nogc int mvinsnstr (int, int, const(char) *, int);     /* generated */
// extern nothrow @nogc int mvinsstr (int, int, const(char) *);           /* generated */
// extern nothrow @nogc int mvinstr (int, int, char *);                  /* generated */
extern nothrow @nogc int mvprintw (int,int, const(char) *,...)         /* implemented */
                /*GCC_PRINTFLIKE(3,4)*/;
extern nothrow @nogc int mvscanw (int,int, const(char) *,...)          /* implemented */
                /*GCC_SCANFLIKE(3,4)*/;
// extern nothrow @nogc int mvvline (int, int, chtype, int);             /* generated */
// extern nothrow @nogc int mvwaddch (WINDOW *, int, int, const(chtype)); /* generated */
// extern nothrow @nogc int mvwaddchnstr (WINDOW *, int, int, const(chtype) *, int);/* generated */
// extern nothrow @nogc int mvwaddchstr (WINDOW *, int, int, const(chtype) *);    /* generated */
// extern nothrow @nogc int mvwaddnstr (WINDOW *, int, int, const(char) *, int);  /* generated */
// extern nothrow @nogc int mvwaddstr (WINDOW *, int, int, const(char) *);        /* generated */
// extern nothrow @nogc int mvwchgat (WINDOW *, int, int, int, attr_t, NCURSES_PAIRS_T, const(void) *);/* generated */
// extern nothrow @nogc int mvwdelch (WINDOW *, int, int);               /* generated */
// extern nothrow @nogc int mvwgetch (WINDOW *, int, int);               /* generated */
// extern nothrow @nogc int mvwgetnstr (WINDOW *, int, int, char *, int);        /* generated */
// extern nothrow @nogc int mvwgetstr (WINDOW *, int, int, char *);      /* generated */
// extern nothrow @nogc int mvwhline (WINDOW *, int, int, chtype, int);  /* generated */
extern nothrow @nogc int mvwin (WINDOW *,int,int);                    /* implemented */
// extern nothrow @nogc chtype mvwinch (WINDOW *, int, int);                     /* generated */
// extern nothrow @nogc int mvwinchnstr (WINDOW *, int, int, chtype *, int);     /* generated */
// extern nothrow @nogc int mvwinchstr (WINDOW *, int, int, chtype *);           /* generated */
// extern nothrow @nogc int mvwinnstr (WINDOW *, int, int, char *, int);         /* generated */
// extern nothrow @nogc int mvwinsch (WINDOW *, int, int, chtype);               /* generated */
// extern nothrow @nogc int mvwinsnstr (WINDOW *, int, int, const(char) *, int);  /* generated */
// extern nothrow @nogc int mvwinsstr (WINDOW *, int, int, const(char) *);        /* generated */
// extern nothrow @nogc int mvwinstr (WINDOW *, int, int, char *);               /* generated */
extern nothrow @nogc int mvwprintw (WINDOW*,int,int, const(char) *,...)        /* implemented */
                /*GCC_PRINTFLIKE(4,5)*/;
extern nothrow @nogc int mvwscanw (WINDOW *,int,int, const(char) *,...)        /* implemented */
                /*GCC_SCANFLIKE(4,5)*/;
// extern nothrow @nogc int mvwvline (WINDOW *,int, int, chtype, int);   /* generated */
extern nothrow @nogc int napms (int);                                 /* implemented */
extern nothrow @nogc WINDOW * newpad (int,int);                       /* implemented */
extern nothrow @nogc SCREEN * newterm (const(char) *,FILE *,FILE *);   /* implemented */
extern nothrow @nogc WINDOW * newwin (int,int,int,int);               /* implemented */
extern nothrow @nogc int nl ();                                       /* implemented */
extern nothrow @nogc int nocbreak ();                                 /* implemented */
extern nothrow @nogc int nodelay (WINDOW *,bool);                     /* implemented */
extern nothrow @nogc int noecho ();                                   /* implemented */
extern nothrow @nogc int nonl ();                                     /* implemented */
extern nothrow @nogc void noqiflush ();                               /* implemented */
extern nothrow @nogc int noraw ();                                    /* implemented */
extern nothrow @nogc int notimeout (WINDOW *,bool);                   /* implemented */
extern nothrow @nogc int overlay (const(WINDOW)*,WINDOW *);            /* implemented */
extern nothrow @nogc int overwrite (const(WINDOW)*,WINDOW *);          /* implemented */
extern nothrow @nogc int pair_content (NCURSES_PAIRS_T,NCURSES_COLOR_T*,NCURSES_COLOR_T*);            /* implemented */
// extern nothrow @nogc int PAIR_NUMBER (int);                           /* generated */
extern nothrow @nogc int pechochar (WINDOW *, const(chtype));          /* implemented */
extern nothrow @nogc int pnoutrefresh (WINDOW*,int,int,int,int,int,int);/* implemented */
extern nothrow @nogc int prefresh (WINDOW *,int,int,int,int,int,int); /* implemented */
extern nothrow @nogc int printw (const(char) *,...)                    /* implemented */
                /*GCC_PRINTFLIKE(1,2)*/;
extern nothrow @nogc int putwin (WINDOW *, FILE *);                   /* implemented */
extern nothrow @nogc void qiflush ();                                 /* implemented */
extern nothrow @nogc int raw ();                                      /* implemented */
// extern nothrow @nogc int redrawwin (WINDOW *);                        /* generated */
// extern nothrow @nogc int refresh ();                                  /* generated */
extern nothrow @nogc int resetty ();                                  /* implemented */
extern nothrow @nogc int reset_prog_mode ();                          /* implemented */
extern nothrow @nogc int reset_shell_mode ();                         /* implemented */
extern nothrow @nogc int ripoffline (int, int function(WINDOW *, int));    /* implemented */
extern nothrow @nogc int savetty ();                                  /* implemented */
extern nothrow @nogc int scanw (const(char) *,...)                     /* implemented */
                /*GCC_SCANFLIKE(1,2)*/;
extern nothrow @nogc int scr_dump (const(char) *);                     /* implemented */
extern nothrow @nogc int scr_init (const(char) *);                     /* implemented */
// extern nothrow @nogc int scrl (int);                                  /* generated */
// extern nothrow @nogc int scroll (WINDOW *);                           /* generated */
extern nothrow @nogc int scrollok (WINDOW *,bool);                    /* implemented */
extern nothrow @nogc int scr_restore (const(char) *);                  /* implemented */
extern nothrow @nogc int scr_set (const(char) *);                      /* implemented */
// extern nothrow @nogc int setscrreg (int,int);                         /* generated */
extern nothrow @nogc SCREEN * set_term (SCREEN *);                    /* implemented */
extern nothrow @nogc int slk_attroff (const(chtype));                  /* implemented */
extern nothrow @nogc int slk_attr_off (const(attr_t), void *);         /* generated:WIDEC */
extern nothrow @nogc int slk_attron (const(chtype));                   /* implemented */
extern nothrow @nogc int slk_attr_on (attr_t,void*);                  /* generated:WIDEC */
extern nothrow @nogc int slk_attrset (const(chtype));                  /* implemented */
extern nothrow @nogc attr_t slk_attr ();                              /* implemented */
extern nothrow @nogc int slk_attr_set (const(attr_t),NCURSES_PAIRS_T,void*);   /* implemented */
extern nothrow @nogc int slk_clear ();                                /* implemented */
extern nothrow @nogc int slk_color (NCURSES_PAIRS_T);                         /* implemented */
extern nothrow @nogc int slk_init (int);                              /* implemented */
extern nothrow @nogc char * slk_label (int);                          /* implemented */
extern nothrow @nogc int slk_noutrefresh ();                          /* implemented */
extern nothrow @nogc int slk_refresh ();                              /* implemented */
extern nothrow @nogc int slk_restore ();                              /* implemented */
extern nothrow @nogc int slk_set (int,const(char) *,int);              /* implemented */
extern nothrow @nogc int slk_touch ();                                /* implemented */
// extern nothrow @nogc int standout ();                                 /* generated */
// extern nothrow @nogc int standend ();                                 /* generated */
extern nothrow @nogc int start_color ();                              /* implemented */
extern nothrow @nogc WINDOW * subpad (WINDOW *, int, int, int, int);  /* implemented */
extern nothrow @nogc WINDOW * subwin (WINDOW *, int, int, int, int);  /* implemented */
extern nothrow @nogc int syncok (WINDOW *, bool);                     /* implemented */
extern nothrow @nogc chtype termattrs ();                             /* implemented */
extern nothrow @nogc char * termname ();                              /* implemented */
// extern nothrow @nogc void timeout (int);                              /* generated */
// extern nothrow @nogc int touchline (WINDOW *, int, int);              /* generated */
// extern nothrow @nogc int touchwin (WINDOW *);                         /* generated */
extern nothrow @nogc int typeahead (int);                             /* implemented */
extern nothrow @nogc int ungetch (int);                               /* implemented */
// extern nothrow @nogc int untouchwin (WINDOW *);                       /* generated */
extern nothrow @nogc void use_env (bool);                             /* implemented */
extern nothrow @nogc void use_tioctl (bool);                          /* implemented */
extern nothrow @nogc int vidattr (chtype);                            /* implemented */
extern nothrow @nogc int vidputs (chtype, NCURSES_OUTC);              /* implemented */
// extern nothrow @nogc int vline (chtype, int);                         /* generated */
deprecated("use vw_printw") extern nothrow @nogc int vwprintw (WINDOW *, const(char) *, va_list)   /* implemented */
                /*GCC_PRINTFLIKE(2,0)*/;
extern nothrow @nogc int vw_printw (WINDOW *, const(char) *, va_list)  /* implemented */
                /*GCC_PRINTFLIKE(2,0)*/;    
deprecated("use vw_scanw") extern nothrow @nogc int vwscanw (WINDOW *, const(char) *, va_list)    /* implemented */
                /*GCC_SCANFLIKE(2,0)*/;
extern nothrow @nogc int vw_scanw (WINDOW *, const(char) *, va_list)   /* implemented */
                /*GCC_SCANFLIKE(2,0)*/;
extern nothrow @nogc int waddch (WINDOW *, const(chtype));             /* implemented */
extern nothrow @nogc int waddchnstr (WINDOW *,const(chtype) *,int);    /* implemented */
// extern nothrow @nogc int waddchstr (WINDOW *,const(chtype) *);         /* generated */
extern nothrow @nogc int waddnstr (WINDOW *,const(char) *,int);        /* implemented */
// extern nothrow @nogc int waddstr (WINDOW *,const(char) *);             /* generated */
// extern nothrow @nogc int wattron (WINDOW *, int);                     /* generated */
// extern nothrow @nogc int wattroff (WINDOW *, int);                    /* generated */
// extern nothrow @nogc int wattrset (WINDOW *, int);                    /* generated */
// extern nothrow @nogc int wattr_get (WINDOW *, attr_t *, NCURSES_PAIRS_T *, void *);   /* generated */
extern nothrow @nogc int wattr_on (WINDOW *, attr_t, void *);         /* implemented */
extern nothrow @nogc int wattr_off (WINDOW *, attr_t, void *);        /* implemented */
// extern nothrow @nogc int wattr_set (WINDOW *, attr_t, NCURSES_PAIRS_T, void *);       /* generated */
extern nothrow @nogc int wbkgd (WINDOW *, chtype);                    /* implemented */
extern nothrow @nogc void wbkgdset (WINDOW *,chtype);                 /* implemented */
extern nothrow @nogc int wborder (WINDOW *,chtype,chtype,chtype,chtype,chtype,chtype,chtype,chtype);  /* implemented */
extern nothrow @nogc int wchgat (WINDOW *, int, attr_t, NCURSES_PAIRS_T, const(void) *);/* implemented */
extern nothrow @nogc int wclear (WINDOW *);                           /* implemented */
extern nothrow @nogc int wclrtobot (WINDOW *);                        /* implemented */
extern nothrow @nogc int wclrtoeol (WINDOW *);                        /* implemented */
extern nothrow @nogc int wcolor_set (WINDOW*,NCURSES_PAIRS_T,void*);          /* implemented */
extern nothrow @nogc void wcursyncup (WINDOW *);                      /* implemented */
extern nothrow @nogc int wdelch (WINDOW *);                           /* implemented */
// extern nothrow @nogc int wdeleteln (WINDOW *);                        /* generated */
extern nothrow @nogc int wechochar (WINDOW *, const(chtype));          /* implemented */
extern nothrow @nogc int werase (WINDOW *);                           /* implemented */
extern nothrow @nogc int wgetch (WINDOW *);                           /* implemented */
extern nothrow @nogc int wgetnstr (WINDOW *,char *,int);              /* implemented */
// extern nothrow @nogc int wgetstr (WINDOW *, char *);                  /* generated */
extern nothrow @nogc int whline (WINDOW *, chtype, int);              /* implemented */
extern nothrow @nogc chtype winch (WINDOW *);                         /* implemented */
extern nothrow @nogc int winchnstr (WINDOW *, chtype *, int);         /* implemented */
// extern nothrow @nogc int winchstr (WINDOW *, chtype *);               /* generated */
extern nothrow @nogc int winnstr (WINDOW *, char *, int);             /* implemented */
extern nothrow @nogc int winsch (WINDOW *, chtype);                   /* implemented */
extern nothrow @nogc int winsdelln (WINDOW *,int);                    /* implemented */
// extern nothrow @nogc int winsertln (WINDOW *);                        /* generated */
extern nothrow @nogc int winsnstr (WINDOW *, const(char) *,int);       /* implemented */
// extern nothrow @nogc int winsstr (WINDOW *, const(char) *);            /* generated */
// extern nothrow @nogc int winstr (WINDOW *, char *);                   /* generated */
extern nothrow @nogc int wmove (WINDOW *,int,int);                    /* implemented */
extern nothrow @nogc int wnoutrefresh (WINDOW *);                     /* implemented */
extern nothrow @nogc int wprintw (WINDOW *, const(char) *,...)         /* implemented */
                /*GCC_PRINTFLIKE(2,3)*/;
extern nothrow @nogc int wredrawln (WINDOW *,int,int);                /* implemented */
extern nothrow @nogc int wrefresh (WINDOW *);                         /* implemented */
extern nothrow @nogc int wscanw (WINDOW *, const(char) *,...)          /* implemented */
                /*GCC_SCANFLIKE(2,3)*/;
extern nothrow @nogc int wscrl (WINDOW *,int);                        /* implemented */
extern nothrow @nogc int wsetscrreg (WINDOW *,int,int);               /* implemented */
// extern nothrow @nogc int wstandout (WINDOW *);                        /* generated */
// extern nothrow @nogc int wstandend (WINDOW *);                        /* generated */
extern nothrow @nogc void wsyncdown (WINDOW *);                       /* implemented */
extern nothrow @nogc void wsyncup (WINDOW *);                         /* implemented */
extern nothrow @nogc void wtimeout (WINDOW *,int);                    /* implemented */
extern nothrow @nogc int wtouchln (WINDOW *,int,int,int);             /* implemented */
extern nothrow @nogc int wvline (WINDOW *,chtype,int);                /* implemented */

/*
 * These are also declared in <term.h>:
 */
extern nothrow @nogc int tigetflag (const(char) *);                    /* implemented */
extern nothrow @nogc int tigetnum (const(char) *);                     /* implemented */
extern nothrow @nogc char * tigetstr (const(char) *);                  /* implemented */
extern nothrow @nogc int putp (const(char) *);                         /* implemented */

static if (NCURSES_TPARM_VARARGS) {
extern nothrow @nogc char * tparm (const(char) *, ...);                /* special */
} else {
extern nothrow @nogc char * tparm (const(char) *, NCURSES_TPARM_ARG,NCURSES_TPARM_ARG,NCURSES_TPARM_ARG,NCURSES_TPARM_ARG,NCURSES_TPARM_ARG,NCURSES_TPARM_ARG,NCURSES_TPARM_ARG,NCURSES_TPARM_ARG,NCURSES_TPARM_ARG);  /* special */
}

extern nothrow @nogc char * tiparm (const(char) *, ...);               /* special */

/*
 * These functions are not in X/Open, but we use them in macro definitions:
 */
// extern nothrow @nogc int getattrs (const(WINDOW) *);                   /* generated */
// extern nothrow @nogc int getcurx (const(WINDOW) *);                    /* generated */
// extern nothrow @nogc int getcury (const(WINDOW) *);                    /* generated */
// extern nothrow @nogc int getbegx (const(WINDOW) *);                    /* generated */
// extern nothrow @nogc int getbegy (const(WINDOW) *);                    /* generated */
// extern nothrow @nogc int getmaxx (const(WINDOW) *);                    /* generated */
// extern nothrow @nogc int getmaxy (const(WINDOW) *);                    /* generated */
// extern nothrow @nogc int getparx (const(WINDOW) *);                    /* generated */
// extern nothrow @nogc int getpary (const(WINDOW) *);                    /* generated */

/*
 * vid_attr() was implemented originally based on a draft of X/Open curses.
 */
static if (!NCURSES_WIDECHAR) {
auto vid_attr(A, PAIR, OPTS)(A a,PAIR pair,OPTS opts) { pragma(inline, true); return vidattr(a); }
}

/*
 * These functions are extensions - not in X/Open Curses.
 */
version (all) {
//#undef  NCURSES_EXT_FUNCS
enum NCURSES_EXT_FUNCS = 20211021;
alias NCURSES_WINDOW_CB = int function(WINDOW *, void *);
alias NCURSES_SCREEN_CB = int function (SCREEN *, void *);
extern nothrow @nogc bool is_term_resized (int, int);
extern nothrow @nogc char * keybound (int, int);
extern nothrow @nogc const(char) * curses_version ();
extern nothrow @nogc int alloc_pair (int, int);
extern nothrow @nogc int assume_default_colors (int, int);
extern nothrow @nogc int define_key (const(char) *, int);
extern nothrow @nogc int extended_color_content(int, int *, int *, int *);
extern nothrow @nogc int extended_pair_content(int, int *, int *);
extern nothrow @nogc int extended_slk_color(int);
extern nothrow @nogc int find_pair (int, int);
extern nothrow @nogc int free_pair (int);
extern nothrow @nogc int get_escdelay ();
extern nothrow @nogc int init_extended_color(int, int, int, int);
extern nothrow @nogc int init_extended_pair(int, int, int);
extern nothrow @nogc int key_defined (const(char) *);
extern nothrow @nogc int keyok (int, bool);
extern nothrow @nogc void reset_color_pairs ();
extern nothrow @nogc int resize_term (int, int);
extern nothrow @nogc int resizeterm (int, int);
extern nothrow @nogc int set_escdelay (int);
extern nothrow @nogc int set_tabsize (int);
extern nothrow @nogc int use_default_colors ();
extern nothrow @nogc int use_extended_names (bool);
extern nothrow @nogc int use_legacy_coding (int);
extern nothrow @nogc int use_screen (SCREEN *, NCURSES_SCREEN_CB, void *);
extern nothrow @nogc int use_window (WINDOW *, NCURSES_WINDOW_CB, void *);
extern nothrow @nogc int wresize (WINDOW *, int, int);
extern nothrow @nogc void nofilter();

/*
 * These extensions provide access to information stored in the WINDOW even
 * when NCURSES_OPAQUE is set:
 */
// extern nothrow @nogc WINDOW * wgetparent (const(WINDOW) *);    /* generated */
// extern nothrow @nogc bool is_cleared (const(WINDOW) *);        /* generated */
// extern nothrow @nogc bool is_idcok (const(WINDOW) *);          /* generated */
// extern nothrow @nogc bool is_idlok (const(WINDOW) *);          /* generated */
// extern nothrow @nogc bool is_immedok (const(WINDOW) *);        /* generated */
// extern nothrow @nogc bool is_keypad (const(WINDOW) *);         /* generated */
// extern nothrow @nogc bool is_leaveok (const(WINDOW) *);        /* generated */
// extern nothrow @nogc bool is_nodelay (const(WINDOW) *);        /* generated */
// extern nothrow @nogc bool is_notimeout (const(WINDOW) *);      /* generated */
// extern nothrow @nogc bool is_pad (const(WINDOW) *);            /* generated */
// extern nothrow @nogc bool is_scrollok (const(WINDOW) *);       /* generated */
// extern nothrow @nogc bool is_subwin (const(WINDOW) *);         /* generated */
// extern nothrow @nogc bool is_syncok (const(WINDOW) *);         /* generated */
// extern nothrow @nogc int wgetdelay (const(WINDOW) *);          /* generated */
// extern nothrow @nogc int wgetscrreg (const(WINDOW) *, int *, int *); /* generated */

} else {
auto curses_version()() { pragma(inline, true); return NCURSES_VERSION; }
}

/*
 * Extra extension-functions, which pass a SCREEN pointer rather than using
 * a global variable SP.
 */
version (all) {
//#undef  NCURSES_SP_FUNCS
enum NCURSES_SP_FUNCS = 20211021;
string NCURSES_SP_NAME(string name) { pragma(inline, true); return name ~ "_sp"; }

/* Define the sp-funcs helper function */
mixin(q{alias } ~ NCURSES_SP_NAME(q{NCURSES_OUTC}) ~ q{ = NCURSES_SP_OUTC;});
alias NCURSES_SP_OUTC = int function(SCREEN*, int);

extern nothrow @nogc SCREEN * new_prescr (); /* implemented:SP_FUNC */

extern nothrow @nogc int baudrate_sp (SCREEN*); /* implemented:SP_FUNC */
extern nothrow @nogc int beep_sp (SCREEN*); /* implemented:SP_FUNC */
extern nothrow @nogc bool can_change_color_sp (SCREEN*); /* implemented:SP_FUNC */
extern nothrow @nogc int cbreak_sp (SCREEN*); /* implemented:SP_FUNC */
extern nothrow @nogc int curs_set_sp (SCREEN*, int); /* implemented:SP_FUNC */
extern nothrow @nogc int color_content_sp (SCREEN*, NCURSES_PAIRS_T, NCURSES_COLOR_T*, NCURSES_COLOR_T*, NCURSES_COLOR_T*); /* implemented:SP_FUNC */
extern nothrow @nogc int def_prog_mode_sp (SCREEN*); /* implemented:SP_FUNC */
extern nothrow @nogc int def_shell_mode_sp (SCREEN*); /* implemented:SP_FUNC */
extern nothrow @nogc int delay_output_sp (SCREEN*, int); /* implemented:SP_FUNC */
extern nothrow @nogc int doupdate_sp (SCREEN*); /* implemented:SP_FUNC */
extern nothrow @nogc int echo_sp (SCREEN*); /* implemented:SP_FUNC */
extern nothrow @nogc int endwin_sp (SCREEN*); /* implemented:SP_FUNC */
extern nothrow @nogc char erasechar_sp (SCREEN*);/* implemented:SP_FUNC */
extern nothrow @nogc void filter_sp (SCREEN*); /* implemented:SP_FUNC */
extern nothrow @nogc int flash_sp (SCREEN*); /* implemented:SP_FUNC */
extern nothrow @nogc int flushinp_sp (SCREEN*); /* implemented:SP_FUNC */
extern nothrow @nogc WINDOW * getwin_sp (SCREEN*, FILE *);                      /* implemented:SP_FUNC */
extern nothrow @nogc int halfdelay_sp (SCREEN*, int); /* implemented:SP_FUNC */
extern nothrow @nogc bool has_colors_sp (SCREEN*); /* implemented:SP_FUNC */
extern nothrow @nogc bool has_ic_sp (SCREEN*); /* implemented:SP_FUNC */
extern nothrow @nogc bool has_il_sp (SCREEN*); /* implemented:SP_FUNC */
extern nothrow @nogc int init_color_sp (SCREEN*, NCURSES_COLOR_T, NCURSES_COLOR_T, NCURSES_COLOR_T, NCURSES_COLOR_T); /* implemented:SP_FUNC */
extern nothrow @nogc int init_pair_sp (SCREEN*, NCURSES_PAIRS_T, NCURSES_COLOR_T, NCURSES_COLOR_T); /* implemented:SP_FUNC */
extern nothrow @nogc int intrflush_sp (SCREEN*, WINDOW*, bool); /* implemented:SP_FUNC */
extern nothrow @nogc bool isendwin_sp (SCREEN*); /* implemented:SP_FUNC */
extern nothrow @nogc NCURSES_CONST!char * keyname_sp (SCREEN*, int); /* implemented:SP_FUNC */
extern nothrow @nogc char killchar_sp (SCREEN*); /* implemented:SP_FUNC */
extern nothrow @nogc char * longname_sp (SCREEN*); /* implemented:SP_FUNC */
extern nothrow @nogc int mvcur_sp (SCREEN*, int, int, int, int); /* implemented:SP_FUNC */
extern nothrow @nogc int napms_sp (SCREEN*, int); /* implemented:SP_FUNC */
extern nothrow @nogc WINDOW * newpad_sp (SCREEN*, int, int); /* implemented:SP_FUNC */
extern nothrow @nogc SCREEN * newterm_sp (SCREEN*, const(char) *, FILE *, FILE *); /* implemented:SP_FUNC */
extern nothrow @nogc WINDOW * newwin_sp (SCREEN*, int, int, int, int); /* implemented:SP_FUNC */
extern nothrow @nogc int nl_sp (SCREEN*); /* implemented:SP_FUNC */
extern nothrow @nogc int nocbreak_sp (SCREEN*); /* implemented:SP_FUNC */
extern nothrow @nogc int noecho_sp (SCREEN*); /* implemented:SP_FUNC */
extern nothrow @nogc int nonl_sp (SCREEN*); /* implemented:SP_FUNC */
extern nothrow @nogc void noqiflush_sp (SCREEN*); /* implemented:SP_FUNC */
extern nothrow @nogc int noraw_sp (SCREEN*); /* implemented:SP_FUNC */
extern nothrow @nogc int pair_content_sp (SCREEN*, NCURSES_PAIRS_T, NCURSES_COLOR_T*, NCURSES_COLOR_T*); /* implemented:SP_FUNC */
extern nothrow @nogc void qiflush_sp (SCREEN*); /* implemented:SP_FUNC */
extern nothrow @nogc int raw_sp (SCREEN*); /* implemented:SP_FUNC */
extern nothrow @nogc int reset_prog_mode_sp (SCREEN*); /* implemented:SP_FUNC */
extern nothrow @nogc int reset_shell_mode_sp (SCREEN*); /* implemented:SP_FUNC */
extern nothrow @nogc int resetty_sp (SCREEN*); /* implemented:SP_FUNC */
extern nothrow @nogc int ripoffline_sp (SCREEN*, int, int function(WINDOW *, int));  /* implemented:SP_FUNC */
extern nothrow @nogc int savetty_sp (SCREEN*); /* implemented:SP_FUNC */
extern nothrow @nogc int scr_init_sp (SCREEN*, const(char) *); /* implemented:SP_FUNC */
extern nothrow @nogc int scr_restore_sp (SCREEN*, const(char) *); /* implemented:SP_FUNC */
extern nothrow @nogc int scr_set_sp (SCREEN*, const(char) *); /* implemented:SP_FUNC */
extern nothrow @nogc int slk_attroff_sp (SCREEN*, const(chtype)); /* implemented:SP_FUNC */
extern nothrow @nogc int slk_attron_sp (SCREEN*, const(chtype)); /* implemented:SP_FUNC */
extern nothrow @nogc int slk_attrset_sp (SCREEN*, const(chtype)); /* implemented:SP_FUNC */
extern nothrow @nogc attr_t slk_attr_sp (SCREEN*); /* implemented:SP_FUNC */
extern nothrow @nogc int slk_attr_set_sp (SCREEN*, const(attr_t), NCURSES_PAIRS_T, void*); /* implemented:SP_FUNC */
extern nothrow @nogc int slk_clear_sp (SCREEN*); /* implemented:SP_FUNC */
extern nothrow @nogc int slk_color_sp (SCREEN*, NCURSES_PAIRS_T); /* implemented:SP_FUNC */
extern nothrow @nogc int slk_init_sp (SCREEN*, int); /* implemented:SP_FUNC */
extern nothrow @nogc char * slk_label_sp (SCREEN*, int); /* implemented:SP_FUNC */
extern nothrow @nogc int slk_noutrefresh_sp (SCREEN*); /* implemented:SP_FUNC */
extern nothrow @nogc int slk_refresh_sp (SCREEN*); /* implemented:SP_FUNC */
extern nothrow @nogc int slk_restore_sp (SCREEN*); /* implemented:SP_FUNC */
extern nothrow @nogc int slk_set_sp (SCREEN*, int, const(char) *, int); /* implemented:SP_FUNC */
extern nothrow @nogc int slk_touch_sp (SCREEN*); /* implemented:SP_FUNC */
extern nothrow @nogc int start_color_sp (SCREEN*); /* implemented:SP_FUNC */
extern nothrow @nogc chtype termattrs_sp (SCREEN*); /* implemented:SP_FUNC */
extern nothrow @nogc char * termname_sp (SCREEN*); /* implemented:SP_FUNC */
extern nothrow @nogc int typeahead_sp (SCREEN*, int); /* implemented:SP_FUNC */
extern nothrow @nogc int ungetch_sp (SCREEN*, int); /* implemented:SP_FUNC */
extern nothrow @nogc void use_env_sp (SCREEN*, bool); /* implemented:SP_FUNC */
extern nothrow @nogc void use_tioctl_sp (SCREEN*, bool); /* implemented:SP_FUNC */
extern nothrow @nogc int vidattr_sp (SCREEN*, chtype);  /* implemented:SP_FUNC */
extern nothrow @nogc int vidputs_sp (SCREEN*, chtype, NCURSES_SP_OUTC); /* implemented:SP_FUNC */
version (all) {
extern nothrow @nogc char * keybound_sp (SCREEN*, int, int);    /* implemented:EXT_SP_FUNC */
extern nothrow @nogc int alloc_pair_sp (SCREEN*, int, int); /* implemented:EXT_SP_FUNC */
extern nothrow @nogc int assume_default_colors_sp (SCREEN*, int, int);  /* implemented:EXT_SP_FUNC */
extern nothrow @nogc int define_key_sp (SCREEN*, const(char) *, int);    /* implemented:EXT_SP_FUNC */
extern nothrow @nogc int extended_color_content_sp (SCREEN*, int, int *, int *, int *); /* implemented:EXT_SP_FUNC */
extern nothrow @nogc int extended_pair_content_sp (SCREEN*, int, int *, int *); /* implemented:EXT_SP_FUNC */
extern nothrow @nogc int extended_slk_color_sp (SCREEN*, int);  /* implemented:EXT_SP_FUNC */
extern nothrow @nogc int get_escdelay_sp (SCREEN*);     /* implemented:EXT_SP_FUNC */
extern nothrow @nogc int find_pair_sp (SCREEN*, int, int); /* implemented:EXT_SP_FUNC */
extern nothrow @nogc int free_pair_sp (SCREEN*, int); /* implemented:EXT_SP_FUNC */
extern nothrow @nogc int init_extended_color_sp (SCREEN*, int, int, int, int);  /* implemented:EXT_SP_FUNC */
extern nothrow @nogc int init_extended_pair_sp (SCREEN*, int, int, int);        /* implemented:EXT_SP_FUNC */
extern nothrow @nogc bool is_term_resized_sp (SCREEN*, int, int);       /* implemented:EXT_SP_FUNC */
extern nothrow @nogc int key_defined_sp (SCREEN*, const(char) *);        /* implemented:EXT_SP_FUNC */
extern nothrow @nogc int keyok_sp (SCREEN*, int, bool); /* implemented:EXT_SP_FUNC */
extern nothrow @nogc void nofilter_sp (SCREEN*); /* implemented */      /* implemented:EXT_SP_FUNC */
extern nothrow @nogc void reset_color_pairs_sp (SCREEN*); /* implemented:EXT_SP_FUNC */
extern nothrow @nogc int resize_term_sp (SCREEN*, int, int);    /* implemented:EXT_SP_FUNC */
extern nothrow @nogc int resizeterm_sp (SCREEN*, int, int);     /* implemented:EXT_SP_FUNC */
extern nothrow @nogc int set_escdelay_sp (SCREEN*, int);        /* implemented:EXT_SP_FUNC */
extern nothrow @nogc int set_tabsize_sp (SCREEN*, int); /* implemented:EXT_SP_FUNC */
extern nothrow @nogc int use_default_colors_sp (SCREEN*);       /* implemented:EXT_SP_FUNC */
extern nothrow @nogc int use_legacy_coding_sp (SCREEN*, int);   /* implemented:EXT_SP_FUNC */
}
} else {
//#undef  NCURSES_SP_FUNCS
enum NCURSES_SP_FUNCS = 0;
alias NCURSES_SP_NAME(string name) = mixin(name ~ "_sp");
alias NCURSES_SP_OUTC = NCURSES_OUTC;
}

/* attributes */

enum NCURSES_ATTR_SHIFT       = 8;
auto NCURSES_BITS(Mask, Shift)(Mask mask,Shift shift) { pragma(inline, true); return (cast(chtype)(mask)) << ((shift) + NCURSES_ATTR_SHIFT); }

enum A_NORMAL        = (1U - 1U);
enum A_ATTRIBUTES    = NCURSES_BITS(~(1U - 1U),0);
enum A_CHARTEXT      = (NCURSES_BITS(1U,0) - 1U);
enum A_COLOR         = NCURSES_BITS(((1U) << 8) - 1U,0);
enum A_STANDOUT      = NCURSES_BITS(1U,8);
enum A_UNDERLINE     = NCURSES_BITS(1U,9);
enum A_REVERSE       = NCURSES_BITS(1U,10);
enum A_BLINK         = NCURSES_BITS(1U,11);
enum A_DIM           = NCURSES_BITS(1U,12);
enum A_BOLD          = NCURSES_BITS(1U,13);
enum A_ALTCHARSET    = NCURSES_BITS(1U,14);
enum A_INVIS         = NCURSES_BITS(1U,15);
enum A_PROTECT       = NCURSES_BITS(1U,16);
enum A_HORIZONTAL    = NCURSES_BITS(1U,17);
enum A_LEFT          = NCURSES_BITS(1U,18);
enum A_LOW           = NCURSES_BITS(1U,19);
enum A_RIGHT         = NCURSES_BITS(1U,20);
enum A_TOP           = NCURSES_BITS(1U,21);
enum A_VERTICAL      = NCURSES_BITS(1U,22);

version (all) {
enum A_ITALIC        = NCURSES_BITS(1U,23);     /* ncurses extension */
}

/*
 * Most of the pseudo functions are macros that either provide compatibility
 * with older versions of curses, or provide inline functionality to improve
 * performance.
 */

/*
 * These pseudo functions are always implemented as macros:
 */

void getyx   (Win,Y,X)(Win win,ref Y y,ref X x) { pragma(inline, true); y = getcury(win); x = getcurx(win); }
void getbegyx(Win,Y,X)(Win win,ref Y y,ref X x) { pragma(inline, true); y = getbegy(win); x = getbegx(win); }
void getmaxyx(Win,Y,X)(Win win,ref Y y,ref X x) { pragma(inline, true); y = getmaxy(win); x = getmaxx(win); }
void getparyx(Win,Y,X)(Win win,ref Y y,ref X x) { pragma(inline, true); y = getpary(win); x = getparx(win); }

void getsyx(Y,X)(ref Y y,ref X x) {
                             pragma(inline, true);
                             if (newscr) {
                             if (is_leaveok(newscr))
                                (y) = (x) = -1;
                             else
                                 getyx(newscr,(y), (x));
                        }
                    }

void getsyx(Y,X)(ref Y y,ref X x) {
                             pragma(inline, true);
                             if (newscr) {
                             if ((y) == -1 && (x) == -1)
                                leaveok(newscr, TRUE);
                             else {
                                leaveok(newscr, FALSE);
                                wmove(newscr, (y), (x));
                                                         }
                        }
                    }

static if (!is(typeof(NCURSES_NOMACROS))) {

/*
 * These miscellaneous pseudo functions are provided for compatibility:
 */

auto  wgetstr(w, s)(w w, s s)   { pragma(inline, true); return wgetnstr(w, s, -1); }
auto  getnstr(s, n)(s s, n n)   { pragma(inline, true); return wgetnstr(stdscr, s, (n)); }

auto  setterm(term)(term term)  { pragma(inline, true); return setupterm(term, 1, cast(int *)0); }

auto  fixterm()()               { pragma(inline, true); return reset_prog_mode(); }
auto  resetterm()()             { pragma(inline, true); return reset_shell_mode(); }
auto  saveterm()()              { pragma(inline, true); return def_prog_mode(); }
auto  crmode()()                { pragma(inline, true); return cbreak(); }
auto  nocrmode()()              { pragma(inline, true); return nocbreak(); }
void  gettmode()()              { pragma(inline, true); }

/* It seems older SYSV curses versions define these */
static if (!NCURSES_OPAQUE) {
auto  getattrs(win)(win win)           { pragma(inline, true); return cast(int)(NCURSES_OK_ADDR(win) ? (win)._attrs : A_NORMAL); }
auto  getcurx(win)(win win)            { pragma(inline, true); return (NCURSES_OK_ADDR(win) ? (win)._curx : ERR); }
auto  getcury(win)(win win)            { pragma(inline, true); return (NCURSES_OK_ADDR(win) ? (win)._cury : ERR); }
auto  getbegx(win)(win win)            { pragma(inline, true); return (NCURSES_OK_ADDR(win) ? (win)._begx : ERR); }
auto  getbegy(win)(win win)            { pragma(inline, true); return (NCURSES_OK_ADDR(win) ? (win)._begy : ERR); }
auto  getmaxx(win)(win win)            { pragma(inline, true); return (NCURSES_OK_ADDR(win) ? ((win)._maxx + 1) : ERR); }
auto  getmaxy(win)(win win)            { pragma(inline, true); return (NCURSES_OK_ADDR(win) ? ((win)._maxy + 1) : ERR); }
auto  getparx(win)(win win)            { pragma(inline, true); return (NCURSES_OK_ADDR(win) ? (win)._parx : ERR); }
auto  getpary(win)(win win)            { pragma(inline, true); return (NCURSES_OK_ADDR(win) ? (win)._pary : ERR); }
} /* NCURSES_OPAQUE */

auto  wstandout(win)(win win)          { pragma(inline, true); return (wattrset(win,A_STANDOUT)); }
auto  wstandend(win)(win win)          { pragma(inline, true); return (wattrset(win,A_NORMAL)); }

auto  wattron(win,at)(win win,at at)   { pragma(inline, true); return wattr_on(win, cast(attr_t)(at), null); }
auto  wattroff(win,at)(win win,at at)  { pragma(inline, true); return wattr_off(win, cast(attr_t)(at), null); }

static if (!NCURSES_OPAQUE) {
static if (NCURSES_WATTR_MACROS) {
static if (NCURSES_WIDECHAR && 1) {
auto  wattrset(win,at)(win win,at at) { pragma(inline, true); return 
        (NCURSES_OK_ADDR(win) 
          ? ((win)._color = cast(int)(PAIR_NUMBER(at)), 
             (win)._attrs = cast(attr_t)(at), 
             OK) 
          : ERR); }
} else {
auto  wattrset(win,at)(win win,at at) { pragma(inline, true); return 
        (NCURSES_OK_ADDR(win) 
          ? ((win)._attrs = cast(attr_t)(at), 
             OK) 
          : ERR); }
}
} /* NCURSES_WATTR_MACROS */
} /* NCURSES_OPAQUE */

auto  scroll(win)(win win)             { pragma(inline, true); return wscrl(win,1); }

auto  touchwin(win)(win win)           { pragma(inline, true); return wtouchln((win), 0, getmaxy(win), 1); }
auto  touchline(win, s, c)(win win, s s, c c)    { pragma(inline, true); return wtouchln((win), s, c, 1); }
auto  untouchwin(win)(win win)         { pragma(inline, true); return wtouchln((win), 0, getmaxy(win), 0); }

auto  box(win, v, h)(win win, v v, h h) { pragma(inline, true); return wborder(win, v, v, h, h, 0, 0, 0, 0); }
auto  border(ls, rs, ts, bs, tl, tr, bl, br)(ls ls, rs rs, ts ts, bs bs, tl tl, tr tr, bl bl, br br)  { pragma(inline, true); return wborder(stdscr, ls, rs, ts, bs, tl, tr, bl, br); }
auto  hline(ch, n)(ch ch, n n)         { pragma(inline, true); return whline(stdscr, ch, (n)); }
auto  vline(ch, n)(ch ch, n n)         { pragma(inline, true); return wvline(stdscr, ch, (n)); }

auto  winstr(w, s)(w w, s s)           { pragma(inline, true); return winnstr(w, s, -1); }
auto  winchstr(w, s)(w w, s s)         { pragma(inline, true); return winchnstr(w, s, -1); }
auto  winsstr(w, s)(w w, s s)          { pragma(inline, true); return winsnstr(w, s, -1); }

static if (!NCURSES_OPAQUE) {
auto  redrawwin(win)(win win)          { pragma(inline, true); return wredrawln(win, 0, (NCURSES_OK_ADDR(win) ? (win)._maxy+1 : -1)); }
} /* NCURSES_OPAQUE */

auto  waddstr(win,str)(win win,str str)   { pragma(inline, true); return waddnstr(win,str,-1); }
auto  waddchstr(win,str)(win win,str str) { pragma(inline, true); return waddchnstr(win,str,-1); }

/*
 * These apply to the first 256 color pairs.
 */
auto  COLOR_PAIR(n)(n n)   { pragma(inline, true); return (NCURSES_BITS((n), 0) & A_COLOR); }
auto  PAIR_NUMBER(a)(a a)  { pragma(inline, true); return (cast(int)(((cast(c_ulong)((a)) & A_COLOR) >> NCURSES_ATTR_SHIFT))); }

/*
 * pseudo functions for standard screen
 */

auto  addch(ch)(ch ch)                      { pragma(inline, true); return waddch(stdscr,(ch)); }
auto  addchnstr(str,n)(str str,n n)         { pragma(inline, true); return waddchnstr(stdscr,(str),(n)); }
auto  addchstr(str)(str str)                { pragma(inline, true); return waddchstr(stdscr,(str)); }
auto  addnstr(str,n)(str str,n n)           { pragma(inline, true); return waddnstr(stdscr,(str),(n)); }
auto  addstr(str)(str str)                  { pragma(inline, true); return waddnstr(stdscr,(str),-1); }
auto  attr_get(ap,cp,o)(ap ap,cp cp,o o)    { pragma(inline, true); return wattr_get(stdscr,(ap),(cp),(o)); }
auto  attr_off(a,o)(a a,o o)                { pragma(inline, true); return wattr_off(stdscr,(a),(o)); }
auto  attr_on(a,o)(a a,o o)                 { pragma(inline, true); return wattr_on(stdscr,(a),(o)); }
auto  attr_set(a,c,o)(a a,c c,o o)          { pragma(inline, true); return wattr_set(stdscr,(a),(c),(o)); }
auto  attroff(at)(at at)                    { pragma(inline, true); return wattroff(stdscr,(at)); }
auto  attron(at)(at at)                     { pragma(inline, true); return wattron(stdscr,(at)); }
auto  attrset(at)(at at)                    { pragma(inline, true); return wattrset(stdscr,(at)); }
auto  bkgd(ch)(ch ch)                       { pragma(inline, true); return wbkgd(stdscr,(ch)); }
auto  bkgdset(ch)(ch ch)                    { pragma(inline, true); return wbkgdset(stdscr,(ch)); }
auto  chgat(n,a,c,o)(n n,a a,c c,o o)       { pragma(inline, true); return wchgat(stdscr,(n),(a),(c),(o)); }
auto  clear()()                             { pragma(inline, true); return wclear(stdscr); }
auto  clrtobot()()                          { pragma(inline, true); return wclrtobot(stdscr); }
auto  clrtoeol()()                          { pragma(inline, true); return wclrtoeol(stdscr); }
auto  color_set(c,o)(c c,o o)               { pragma(inline, true); return wcolor_set(stdscr,(c),(o)); }
auto  delch()()                             { pragma(inline, true); return wdelch(stdscr); }
auto  deleteln()()                          { pragma(inline, true); return winsdelln(stdscr,-1); }
auto  echochar(c)(c c)                      { pragma(inline, true); return wechochar(stdscr,(c)); }
auto  erase()()                             { pragma(inline, true); return werase(stdscr); }
auto  getch()()                             { pragma(inline, true); return wgetch(stdscr); }
auto  getstr(str)(str str)                  { pragma(inline, true); return wgetstr(stdscr,(str)); }
auto  inch()()                              { pragma(inline, true); return winch(stdscr); }
auto  inchnstr(s,n)(s s,n n)                { pragma(inline, true); return winchnstr(stdscr,(s),(n)); }
auto  inchstr(s)(s s)                       { pragma(inline, true); return winchstr(stdscr,(s)); }
auto  innstr(s,n)(s s,n n)                  { pragma(inline, true); return winnstr(stdscr,(s),(n)); }
auto  insch(c)(c c)                         { pragma(inline, true); return winsch(stdscr,(c)); }
auto  insdelln(n)(n n)                      { pragma(inline, true); return winsdelln(stdscr,(n)); }
auto  insertln()()                          { pragma(inline, true); return winsdelln(stdscr,1); }
auto  insnstr(s,n)(s s,n n)                 { pragma(inline, true); return winsnstr(stdscr,(s),(n)); }
auto  insstr(s)(s s)                        { pragma(inline, true); return winsstr(stdscr,(s)); }
auto  instr(s)(s s)                         { pragma(inline, true); return winstr(stdscr,(s)); }
auto  move(y,x)(y y,x x)                    { pragma(inline, true); return wmove(stdscr,(y),(x)); }
auto  refresh()()                           { pragma(inline, true); return wrefresh(stdscr); }
auto  scrl(n)(n n)                          { pragma(inline, true); return wscrl(stdscr,(n)); }
auto  setscrreg(t,b)(t t,b b)               { pragma(inline, true); return wsetscrreg(stdscr,(t),(b)); }
auto  standend()()                          { pragma(inline, true); return wstandend(stdscr); }
auto  standout()()                          { pragma(inline, true); return wstandout(stdscr); }
auto  timeout(delay)(delay delay)           { pragma(inline, true); return wtimeout(stdscr,(delay)); }
auto  wdeleteln(win)(win win)               { pragma(inline, true); return winsdelln(win,-1); }
auto  winsertln(win)(win win)               { pragma(inline, true); return winsdelln(win,1); }

/*
 * mv functions
 */

auto  mvwaddch(win,y,x,ch)(win win,y y,x x,ch ch)                   { pragma(inline, true); return (wmove((win),(y),(x)) == ERR ? ERR : waddch((win),(ch))); }
auto  mvwaddchnstr(win,y,x,str,n)(win win,y y,x x,str str,n n)      { pragma(inline, true); return (wmove((win),(y),(x)) == ERR ? ERR : waddchnstr((win),(str),(n))); }
auto  mvwaddchstr(win,y,x,str)(win win,y y,x x,str str)             { pragma(inline, true); return (wmove((win),(y),(x)) == ERR ? ERR : waddchnstr((win),(str),-1)); }
auto  mvwaddnstr(win,y,x,str,n)(win win,y y,x x,str str,n n)        { pragma(inline, true); return (wmove((win),(y),(x)) == ERR ? ERR : waddnstr((win),(str),(n))); }
auto  mvwaddstr(win,y,x,str)(win win,y y,x x,str str)               { pragma(inline, true); return (wmove((win),(y),(x)) == ERR ? ERR : waddnstr((win),(str),-1)); }
auto  mvwchgat(win,y,x,n,a,c,o)(win win,y y,x x,n n,a a,c c,o o)    { pragma(inline, true); return (wmove((win),(y),(x)) == ERR ? ERR : wchgat((win),(n),(a),(c),(o))); }
auto  mvwdelch(win,y,x)(win win,y y,x x)                            { pragma(inline, true); return (wmove((win),(y),(x)) == ERR ? ERR : wdelch(win)); }
auto  mvwgetch(win,y,x)(win win,y y,x x)                            { pragma(inline, true); return (wmove((win),(y),(x)) == ERR ? ERR : wgetch(win)); }
auto  mvwgetnstr(win,y,x,str,n)(win win,y y,x x,str str,n n)        { pragma(inline, true); return (wmove((win),(y),(x)) == ERR ? ERR : wgetnstr((win),(str),(n))); }
auto  mvwgetstr(win,y,x,str)(win win,y y,x x,str str)               { pragma(inline, true); return (wmove((win),(y),(x)) == ERR ? ERR : wgetstr((win),(str))); }
auto  mvwhline(win,y,x,c,n)(win win,y y,x x,c c,n n)                { pragma(inline, true); return (wmove((win),(y),(x)) == ERR ? ERR : whline((win),(c),(n))); }
auto  mvwinch(win,y,x)(win win,y y,x x)                             { pragma(inline, true); return (wmove((win),(y),(x)) == ERR ? cast(chtype)(ERR) : winch(win)); }
auto  mvwinchnstr(win,y,x,s,n)(win win,y y,x x,s s,n n)             { pragma(inline, true); return (wmove((win),(y),(x)) == ERR ? ERR : winchnstr((win),(s),(n))); }
auto  mvwinchstr(win,y,x,s)(win win,y y,x x,s s)                    { pragma(inline, true); return (wmove((win),(y),(x)) == ERR ? ERR : winchstr((win),(s))); }
auto  mvwinnstr(win,y,x,s,n)(win win,y y,x x,s s,n n)               { pragma(inline, true); return (wmove((win),(y),(x)) == ERR ? ERR : winnstr((win),(s),(n))); }
auto  mvwinsch(win,y,x,c)(win win,y y,x x,c c)                      { pragma(inline, true); return (wmove((win),(y),(x)) == ERR ? ERR : winsch((win),(c))); }
auto  mvwinsnstr(win,y,x,s,n)(win win,y y,x x,s s,n n)              { pragma(inline, true); return (wmove((win),(y),(x)) == ERR ? ERR : winsnstr((win),(s),(n))); }
auto  mvwinsstr(win,y,x,s)(win win,y y,x x,s s)                     { pragma(inline, true); return (wmove((win),(y),(x)) == ERR ? ERR : winsstr((win),(s))); }
auto  mvwinstr(win,y,x,s)(win win,y y,x x,s s)                      { pragma(inline, true); return (wmove((win),(y),(x)) == ERR ? ERR : winstr((win),(s))); }
auto  mvwvline(win,y,x,c,n)(win win,y y,x x,c c,n n)                { pragma(inline, true); return (wmove((win),(y),(x)) == ERR ? ERR : wvline((win),(c),(n))); }

auto  mvaddch(y,x,ch)(y y,x x,ch ch)                                { pragma(inline, true); return mvwaddch(stdscr,(y),(x),(ch)); }
auto  mvaddchnstr(y,x,str,n)(y y,x x,str str,n n)                   { pragma(inline, true); return mvwaddchnstr(stdscr,(y),(x),(str),(n)); }
auto  mvaddchstr(y,x,str)(y y,x x,str str)                          { pragma(inline, true); return mvwaddchstr(stdscr,(y),(x),(str)); }
auto  mvaddnstr(y,x,str,n)(y y,x x,str str,n n)                     { pragma(inline, true); return mvwaddnstr(stdscr,(y),(x),(str),(n)); }
auto  mvaddstr(y,x,str)(y y,x x,str str)                            { pragma(inline, true); return mvwaddstr(stdscr,(y),(x),(str)); }
auto  mvchgat(y,x,n,a,c,o)(y y,x x,n n,a a,c c,o o)                 { pragma(inline, true); return mvwchgat(stdscr,(y),(x),(n),(a),(c),(o)); }
auto  mvdelch(y,x)(y y,x x)                                         { pragma(inline, true); return mvwdelch(stdscr,(y),(x)); }
auto  mvgetch(y,x)(y y,x x)                                         { pragma(inline, true); return mvwgetch(stdscr,(y),(x)); }
auto  mvgetnstr(y,x,str,n)(y y,x x,str str,n n)                     { pragma(inline, true); return mvwgetnstr(stdscr,(y),(x),(str),(n)); }
auto  mvgetstr(y,x,str)(y y,x x,str str)                            { pragma(inline, true); return mvwgetstr(stdscr,(y),(x),(str)); }
auto  mvhline(y,x,c,n)(y y,x x,c c,n n)                             { pragma(inline, true); return mvwhline(stdscr,(y),(x),(c),(n)); }
auto  mvinch(y,x)(y y,x x)                                          { pragma(inline, true); return mvwinch(stdscr,(y),(x)); }
auto  mvinchnstr(y,x,s,n)(y y,x x,s s,n n)                          { pragma(inline, true); return mvwinchnstr(stdscr,(y),(x),(s),(n)); }
auto  mvinchstr(y,x,s)(y y,x x,s s)                                 { pragma(inline, true); return mvwinchstr(stdscr,(y),(x),(s)); }
auto  mvinnstr(y,x,s,n)(y y,x x,s s,n n)                            { pragma(inline, true); return mvwinnstr(stdscr,(y),(x),(s),(n)); }
auto  mvinsch(y,x,c)(y y,x x,c c)                                   { pragma(inline, true); return mvwinsch(stdscr,(y),(x),(c)); }
auto  mvinsnstr(y,x,s,n)(y y,x x,s s,n n)                           { pragma(inline, true); return mvwinsnstr(stdscr,(y),(x),(s),(n)); }
auto  mvinsstr(y,x,s)(y y,x x,s s)                                  { pragma(inline, true); return mvwinsstr(stdscr,(y),(x),(s)); }
auto  mvinstr(y,x,s)(y y,x x,s s)                                   { pragma(inline, true); return mvwinstr(stdscr,(y),(x),(s)); }
auto  mvvline(y,x,c,n)(y y,x x,c c,n n)                             { pragma(inline, true); return mvwvline(stdscr,(y),(x),(c),(n)); }

/*
 * Some wide-character functions can be implemented without the extensions.
 */
static if (!NCURSES_OPAQUE) {
auto  getbkgd(win)(win win)                    { pragma(inline, true); return (NCURSES_OK_ADDR(win) ? ((win)._bkgd) : 0); }
} /* NCURSES_OPAQUE */

auto  slk_attr_off(a,v)(a a,v v)               { pragma(inline, true); return ((v) ? ERR : slk_attroff(a)); }
auto  slk_attr_on(a,v)(a a,v v)                { pragma(inline, true); return ((v) ? ERR : slk_attron(a)); }

static if (!NCURSES_OPAQUE) {
static if (NCURSES_WATTR_MACROS) {
static if (NCURSES_WIDECHAR && 1) {
auto  wattr_set(win,a,p,opts)(win win,a a,p p,opts opts) { pragma(inline, true); return 
        (NCURSES_OK_ADDR(win) 
         ? (cast(void)((win)._attrs = ((a) & ~A_COLOR), 
                       (win)._color = (opts) ? *cast(int *)(opts) : (p)), 
            OK) 
         : ERR); }
auto  wattr_get(win,a,p,opts)(win win,a a,p p,opts opts) { pragma(inline, true); return 
        (NCURSES_OK_ADDR(win) 
         ? (cast(void)(NCURSES_OK_ADDR(a) 
                   ? (*(a) = (win)._attrs) 
                   : OK), 
            cast(void)(NCURSES_OK_ADDR(p) 
                   ? (*(p) = cast(NCURSES_PAIRS_T) (win)._color) 
                   : OK), 
            cast(void)(NCURSES_OK_ADDR(opts) 
                   ? (*cast(int *)(opts) = (win)._color) 
                   : OK), 
            OK) 
         : ERR); }
} else { /* !(NCURSES_WIDECHAR && NCURSES_EXE_COLORS) */
auto  wattr_set(win,a,p,opts)(win win,a a,p p,opts opts) { pragma(inline, true); return 
         (NCURSES_OK_ADDR(win) 
          ? (cast(void)((win)._attrs = (((a) & ~A_COLOR) | 
                                     cast(attr_t)COLOR_PAIR(p))), 
             OK) 
          : ERR); }
auto  wattr_get(win,a,p,opts)(win win,a a,p p,opts opts) { pragma(inline, true); return 
        (NCURSES_OK_ADDR(win) 
         ? (cast(void)(NCURSES_OK_ADDR(a) 
                   ? (*(a) = (win)._attrs) 
                   : OK), 
            cast(void)(NCURSES_OK_ADDR(p) 
                   ? (*(p) = cast(NCURSES_PAIRS_T) PAIR_NUMBER((win)._attrs)) 
                   : OK), 
            OK) 
         : ERR); }
} /* (NCURSES_WIDECHAR && NCURSES_EXE_COLORS) */
} /* NCURSES_WATTR_MACROS */
} /* NCURSES_OPAQUE */

/*
 * X/Open curses deprecates SVr4 vwprintw/vwscanw, which are supposed to use
 * varargs.h.  It adds new calls vw_printw/vw_scanw, which are supposed to
 * use POSIX stdarg.h.  The ncurses versions of vwprintw/vwscanw already
 * use stdarg.h, so...
 */
/* define vw_printw             vwprintw */
/* define vw_scanw              vwscanw */

/*
 * Export fallback function for use in C++ binding.
 */
static if (!1) {
alias vsscanf = _nc_vsscanf;
int _nc_vsscanf(const(char) *, const(char) *, va_list);
}

/*
 * These macros are extensions - not in X/Open Curses.
 */
version (all) {
static if (!NCURSES_OPAQUE) {
auto  is_cleared(win)(win win)         { pragma(inline, true); return (NCURSES_OK_ADDR(win) ? (win)._clear : FALSE); }
auto  is_idcok(win)(win win)           { pragma(inline, true); return (NCURSES_OK_ADDR(win) ? (win)._idcok : FALSE); }
auto  is_idlok(win)(win win)           { pragma(inline, true); return (NCURSES_OK_ADDR(win) ? (win)._idlok : FALSE); }
auto  is_immedok(win)(win win)         { pragma(inline, true); return (NCURSES_OK_ADDR(win) ? (win)._immed : FALSE); }
auto  is_keypad(win)(win win)          { pragma(inline, true); return (NCURSES_OK_ADDR(win) ? (win)._use_keypad : FALSE); }
auto  is_leaveok(win)(win win)         { pragma(inline, true); return (NCURSES_OK_ADDR(win) ? (win)._leaveok : FALSE); }
auto  is_nodelay(win)(win win)         { pragma(inline, true); return (NCURSES_OK_ADDR(win) ? ((win)._delay == 0) : FALSE); }
auto  is_notimeout(win)(win win)       { pragma(inline, true); return (NCURSES_OK_ADDR(win) ? (win)._notimeout : FALSE); }
auto  is_pad(win)(win win)             { pragma(inline, true); return (NCURSES_OK_ADDR(win) ? ((win)._flags & _ISPAD) != 0 : FALSE); }
auto  is_scrollok(win)(win win)        { pragma(inline, true); return (NCURSES_OK_ADDR(win) ? (win)._scroll : FALSE); }
auto  is_subwin(win)(win win)          { pragma(inline, true); return (NCURSES_OK_ADDR(win) ? ((win)._flags & _SUBWIN) != 0 : FALSE); }
auto  is_syncok(win)(win win)          { pragma(inline, true); return (NCURSES_OK_ADDR(win) ? (win)._sync : FALSE); }
auto  wgetdelay(win)(win win)          { pragma(inline, true); return (NCURSES_OK_ADDR(win) ? (win)._delay : 0); }
auto  wgetparent(win)(win win)         { pragma(inline, true); return (NCURSES_OK_ADDR(win) ? (win)._parent : 0); }
auto  wgetscrreg(win,t,b)(win win,t t,b b)     { pragma(inline, true); return (NCURSES_OK_ADDR(win) ? (*(t) = (win)._regtop, *(b) = (win)._regbottom, OK) : ERR); }
}
}

/*
 * X/Open says this returns a bool; SVr4 also checked for out-of-range line.
 * The macro provides compatibility:
 */
// auto  is_linetouched(w,l)(w w,l l) { pragma(inline, true); return ((!(w) || ((l) > getmaxy(w)) || ((l) < 0)) ? ERR : is_linetouched((w),(l))); }

} /* NCURSES_NOMACROS */

/*
 * Public variables.
 *
 * Notes:
 *      a. ESCDELAY was an undocumented feature under AIX curses.
 *         It gives the ESC expire time in milliseconds.
 *      b. ttytype is needed for backward compatibility
 */
version (NCURSES_REENTRANT) {

mixin NCURSES_D_VAR!(WINDOW *, q{curscr});
mixin NCURSES_D_VAR!(WINDOW *, q{newscr});
mixin NCURSES_D_VAR!(WINDOW *, q{stdscr});
mixin NCURSES_D_VAR!(char *, q{ttytype});
mixin NCURSES_D_VAR!(int, q{COLORS});
mixin NCURSES_D_VAR!(int, q{COLOR_PAIRS});
mixin NCURSES_D_VAR!(int, q{COLS});
mixin NCURSES_D_VAR!(int, q{ESCDELAY});
mixin NCURSES_D_VAR!(int, q{LINES});
mixin NCURSES_D_VAR!(int, q{TABSIZE});

} else {

extern __gshared NCURSES_EXPORT_VAR!(WINDOW *) curscr;
extern __gshared NCURSES_EXPORT_VAR!(WINDOW *) newscr;
extern __gshared NCURSES_EXPORT_VAR!(WINDOW *) stdscr;
extern __gshared NCURSES_EXPORT_VAR!(char*/*[]*/) ttytype;
extern __gshared NCURSES_EXPORT_VAR!(int) COLORS;
extern __gshared NCURSES_EXPORT_VAR!(int) COLOR_PAIRS;
extern __gshared NCURSES_EXPORT_VAR!(int) COLS;
extern __gshared NCURSES_EXPORT_VAR!(int) ESCDELAY;
extern __gshared NCURSES_EXPORT_VAR!(int) LINES;
extern __gshared NCURSES_EXPORT_VAR!(int) TABSIZE;

}
/*
 * Pseudo-character tokens outside ASCII range.  The curses wgetch() function
 * will return any given one of these only if the corresponding k- capability
 * is defined in your terminal's terminfo entry.
 *
 * Some keys (KEY_A1, etc) are arranged like this:
 *      a1     up    a3
 *      left   b2    right
 *      c1     down  c3
 *
 * A few key codes do not depend upon the terminfo entry.
 */
enum KEY_CODE_YES    = octal!400;            /* A wchar_t contains a key code */
enum KEY_MIN         = octal!401;            /* Minimum curses key */
enum KEY_BREAK       = octal!401;            /* Break key (unreliable) */
enum KEY_SRESET      = octal!530;            /* Soft (partial) reset (unreliable) */
enum KEY_RESET       = octal!531;            /* Reset or hard reset (unreliable) */
/*
 * These definitions were generated by ./MKkey_defs.sh ./Caps ./Caps-ncurses
 */
enum KEY_DOWN        = octal!402;            /* down-arrow key */
enum KEY_UP          = octal!403;            /* up-arrow key */
enum KEY_LEFT        = octal!404;            /* left-arrow key */
enum KEY_RIGHT       = octal!405;            /* right-arrow key */
enum KEY_HOME        = octal!406;            /* home key */
enum KEY_BACKSPACE   = octal!407;            /* backspace key */
enum KEY_F0          = octal!410;            /* Function keys.  Space for 64 */
auto  KEY_F(n)(n n)        { pragma(inline, true); return (KEY_F0+(n)); }    /* Value of function key n */
enum KEY_DL          = octal!510;            /* delete-line key */
enum KEY_IL          = octal!511;            /* insert-line key */
enum KEY_DC          = octal!512;            /* delete-character key */
enum KEY_IC          = octal!513;            /* insert-character key */
enum KEY_EIC         = octal!514;            /* sent by rmir or smir in insert mode */
enum KEY_CLEAR       = octal!515;            /* clear-screen or erase key */
enum KEY_EOS         = octal!516;            /* clear-to-end-of-screen key */
enum KEY_EOL         = octal!517;            /* clear-to-end-of-line key */
enum KEY_SF          = octal!520;            /* scroll-forward key */
enum KEY_SR          = octal!521;            /* scroll-backward key */
enum KEY_NPAGE       = octal!522;            /* next-page key */
enum KEY_PPAGE       = octal!523;            /* previous-page key */
enum KEY_STAB        = octal!524;            /* set-tab key */
enum KEY_CTAB        = octal!525;            /* clear-tab key */
enum KEY_CATAB       = octal!526;            /* clear-all-tabs key */
enum KEY_ENTER       = octal!527;            /* enter/send key */
enum KEY_PRINT       = octal!532;            /* print key */
enum KEY_LL          = octal!533;            /* lower-left key (home down) */
enum KEY_A1          = octal!534;            /* upper left of keypad */
enum KEY_A3          = octal!535;            /* upper right of keypad */
enum KEY_B2          = octal!536;            /* center of keypad */
enum KEY_C1          = octal!537;            /* lower left of keypad */
enum KEY_C3          = octal!540;            /* lower right of keypad */
enum KEY_BTAB        = octal!541;            /* back-tab key */
enum KEY_BEG         = octal!542;            /* begin key */
enum KEY_CANCEL      = octal!543;            /* cancel key */
enum KEY_CLOSE       = octal!544;            /* close key */
enum KEY_COMMAND     = octal!545;            /* command key */
enum KEY_COPY        = octal!546;            /* copy key */
enum KEY_CREATE      = octal!547;            /* create key */
enum KEY_END         = octal!550;            /* end key */
enum KEY_EXIT        = octal!551;            /* exit key */
enum KEY_FIND        = octal!552;            /* find key */
enum KEY_HELP        = octal!553;            /* help key */
enum KEY_MARK        = octal!554;            /* mark key */
enum KEY_MESSAGE     = octal!555;            /* message key */
enum KEY_MOVE        = octal!556;            /* move key */
enum KEY_NEXT        = octal!557;            /* next key */
enum KEY_OPEN        = octal!560;            /* open key */
enum KEY_OPTIONS     = octal!561;            /* options key */
enum KEY_PREVIOUS    = octal!562;            /* previous key */
enum KEY_REDO        = octal!563;            /* redo key */
enum KEY_REFERENCE   = octal!564;            /* reference key */
enum KEY_REFRESH     = octal!565;            /* refresh key */
enum KEY_REPLACE     = octal!566;            /* replace key */
enum KEY_RESTART     = octal!567;            /* restart key */
enum KEY_RESUME      = octal!570;            /* resume key */
enum KEY_SAVE        = octal!571;            /* save key */
enum KEY_SBEG        = octal!572;            /* shifted begin key */
enum KEY_SCANCEL     = octal!573;            /* shifted cancel key */
enum KEY_SCOMMAND    = octal!574;            /* shifted command key */
enum KEY_SCOPY       = octal!575;            /* shifted copy key */
enum KEY_SCREATE     = octal!576;            /* shifted create key */
enum KEY_SDC         = octal!577;            /* shifted delete-character key */
enum KEY_SDL         = octal!600;            /* shifted delete-line key */
enum KEY_SELECT      = octal!601;            /* select key */
enum KEY_SEND        = octal!602;            /* shifted end key */
enum KEY_SEOL        = octal!603;            /* shifted clear-to-end-of-line key */
enum KEY_SEXIT       = octal!604;            /* shifted exit key */
enum KEY_SFIND       = octal!605;            /* shifted find key */
enum KEY_SHELP       = octal!606;            /* shifted help key */
enum KEY_SHOME       = octal!607;            /* shifted home key */
enum KEY_SIC         = octal!610;            /* shifted insert-character key */
enum KEY_SLEFT       = octal!611;            /* shifted left-arrow key */
enum KEY_SMESSAGE    = octal!612;            /* shifted message key */
enum KEY_SMOVE       = octal!613;            /* shifted move key */
enum KEY_SNEXT       = octal!614;            /* shifted next key */
enum KEY_SOPTIONS    = octal!615;            /* shifted options key */
enum KEY_SPREVIOUS   = octal!616;            /* shifted previous key */
enum KEY_SPRINT      = octal!617;            /* shifted print key */
enum KEY_SREDO       = octal!620;            /* shifted redo key */
enum KEY_SREPLACE    = octal!621;            /* shifted replace key */
enum KEY_SRIGHT      = octal!622;            /* shifted right-arrow key */
enum KEY_SRSUME      = octal!623;            /* shifted resume key */
enum KEY_SSAVE       = octal!624;            /* shifted save key */
enum KEY_SSUSPEND    = octal!625;            /* shifted suspend key */
enum KEY_SUNDO       = octal!626;            /* shifted undo key */
enum KEY_SUSPEND     = octal!627;            /* suspend key */
enum KEY_UNDO        = octal!630;            /* undo key */
enum KEY_MOUSE       = octal!631;            /* Mouse event has occurred */

version (NCURSES_EXT_FUNCS) {
enum KEY_RESIZE      = octal!632;            /* Terminal resize event */
}

enum KEY_MAX         = octal!777;            /* Maximum key value is 0632 */
/* $Id: curses.wide,v 1.51 2021/05/22 20:28:29 tom Exp $ */
/*
 * vile:cmode:
 * This file is part of ncurses, designed to be appended after curses.h.in
 * (see that file for the relevant copyright).
 */
enum _XOPEN_CURSES = 1;

static if (NCURSES_WIDECHAR) {

extern NCURSES_EXPORT_VAR!(cchar_t *) _nc_wacs;

auto  NCURSES_WACS(c)(c c) { pragma(inline, true); return (&_nc_wacs[cast(ubyte)(c)]); }

@property auto WACS_BSSB       () { pragma(inline, true); return NCURSES_WACS('l'); }
@property auto WACS_SSBB       () { pragma(inline, true); return NCURSES_WACS('m'); }
@property auto WACS_BBSS       () { pragma(inline, true); return NCURSES_WACS('k'); }
@property auto WACS_SBBS       () { pragma(inline, true); return NCURSES_WACS('j'); }
@property auto WACS_SBSS       () { pragma(inline, true); return NCURSES_WACS('u'); }
@property auto WACS_SSSB       () { pragma(inline, true); return NCURSES_WACS('t'); }
@property auto WACS_SSBS       () { pragma(inline, true); return NCURSES_WACS('v'); }
@property auto WACS_BSSS       () { pragma(inline, true); return NCURSES_WACS('w'); }
@property auto WACS_BSBS       () { pragma(inline, true); return NCURSES_WACS('q'); }
@property auto WACS_SBSB       () { pragma(inline, true); return NCURSES_WACS('x'); }
@property auto WACS_SSSS       () { pragma(inline, true); return NCURSES_WACS('n'); }

alias WACS_ULCORNER   = WACS_BSSB;
alias WACS_LLCORNER   = WACS_SSBB;
alias WACS_URCORNER   = WACS_BBSS;
alias WACS_LRCORNER   = WACS_SBBS;
alias WACS_RTEE       = WACS_SBSS;
alias WACS_LTEE       = WACS_SSSB;
alias WACS_BTEE       = WACS_SSBS;
alias WACS_TTEE       = WACS_BSSS;
alias WACS_HLINE      = WACS_BSBS;
alias WACS_VLINE      = WACS_SBSB;
alias WACS_PLUS       = WACS_SSSS;

@property auto WACS_S1         () { pragma(inline, true); return NCURSES_WACS('o'); } /* scan line 1 */
@property auto WACS_S9         () { pragma(inline, true); return NCURSES_WACS('s'); } /* scan line 9 */
@property auto WACS_DIAMOND    () { pragma(inline, true); return NCURSES_WACS('`'); } /* diamond */
@property auto WACS_CKBOARD    () { pragma(inline, true); return NCURSES_WACS('a'); } /* checker board */
@property auto WACS_DEGREE     () { pragma(inline, true); return NCURSES_WACS('f'); } /* degree symbol */
@property auto WACS_PLMINUS    () { pragma(inline, true); return NCURSES_WACS('g'); } /* plus/minus */
@property auto WACS_BULLET     () { pragma(inline, true); return NCURSES_WACS('~'); } /* bullet */

        /* Teletype 5410v1 symbols */
@property auto WACS_LARROW     () { pragma(inline, true); return NCURSES_WACS(','); } /* arrow left */
@property auto WACS_RARROW     () { pragma(inline, true); return NCURSES_WACS('+'); } /* arrow right */
@property auto WACS_DARROW     () { pragma(inline, true); return NCURSES_WACS('.'); } /* arrow down */
@property auto WACS_UARROW     () { pragma(inline, true); return NCURSES_WACS('-'); } /* arrow up */
@property auto WACS_BOARD      () { pragma(inline, true); return NCURSES_WACS('h'); } /* board of squares */
@property auto WACS_LANTERN    () { pragma(inline, true); return NCURSES_WACS('i'); } /* lantern symbol */
@property auto WACS_BLOCK      () { pragma(inline, true); return NCURSES_WACS('0'); } /* solid square block */

        /* ncurses extensions */
@property auto WACS_S3         () { pragma(inline, true); return NCURSES_WACS('p'); } /* scan line 3 */
@property auto WACS_S7         () { pragma(inline, true); return NCURSES_WACS('r'); } /* scan line 7 */
@property auto WACS_LEQUAL     () { pragma(inline, true); return NCURSES_WACS('y'); } /* less/equal */
@property auto WACS_GEQUAL     () { pragma(inline, true); return NCURSES_WACS('z'); } /* greater/equal */
@property auto WACS_PI         () { pragma(inline, true); return NCURSES_WACS('{'); } /* Pi */
@property auto WACS_NEQUAL     () { pragma(inline, true); return NCURSES_WACS('|'); } /* not equal */
@property auto WACS_STERLING   () { pragma(inline, true); return NCURSES_WACS('}'); } /* UK pound sign */

        /* double lines */
@property auto WACS_BDDB       () { pragma(inline, true); return NCURSES_WACS('C'); }
@property auto WACS_DDBB       () { pragma(inline, true); return NCURSES_WACS('D'); }
@property auto WACS_BBDD       () { pragma(inline, true); return NCURSES_WACS('B'); }
@property auto WACS_DBBD       () { pragma(inline, true); return NCURSES_WACS('A'); }
@property auto WACS_DBDD       () { pragma(inline, true); return NCURSES_WACS('G'); }
@property auto WACS_DDDB       () { pragma(inline, true); return NCURSES_WACS('F'); }
@property auto WACS_DDBD       () { pragma(inline, true); return NCURSES_WACS('H'); }
@property auto WACS_BDDD       () { pragma(inline, true); return NCURSES_WACS('I'); }
@property auto WACS_BDBD       () { pragma(inline, true); return NCURSES_WACS('R'); }
@property auto WACS_DBDB       () { pragma(inline, true); return NCURSES_WACS('Y'); }
@property auto WACS_DDDD       () { pragma(inline, true); return NCURSES_WACS('E'); }

alias WACS_D_ULCORNER = WACS_BDDB;
alias WACS_D_LLCORNER = WACS_DDBB;
alias WACS_D_URCORNER = WACS_BBDD;
alias WACS_D_LRCORNER = WACS_DBBD;
alias WACS_D_RTEE     = WACS_DBDD;
alias WACS_D_LTEE     = WACS_DDDB;
alias WACS_D_BTEE     = WACS_DDBD;
alias WACS_D_TTEE     = WACS_BDDD;
alias WACS_D_HLINE    = WACS_BDBD;
alias WACS_D_VLINE    = WACS_DBDB;
alias WACS_D_PLUS     = WACS_DDDD;

        /* thick lines */
@property auto WACS_BTTB       () { pragma(inline, true); return NCURSES_WACS('L'); }
@property auto WACS_TTBB       () { pragma(inline, true); return NCURSES_WACS('M'); }
@property auto WACS_BBTT       () { pragma(inline, true); return NCURSES_WACS('K'); }
@property auto WACS_TBBT       () { pragma(inline, true); return NCURSES_WACS('J'); }
@property auto WACS_TBTT       () { pragma(inline, true); return NCURSES_WACS('U'); }
@property auto WACS_TTTB       () { pragma(inline, true); return NCURSES_WACS('T'); }
@property auto WACS_TTBT       () { pragma(inline, true); return NCURSES_WACS('V'); }
@property auto WACS_BTTT       () { pragma(inline, true); return NCURSES_WACS('W'); }
@property auto WACS_BTBT       () { pragma(inline, true); return NCURSES_WACS('Q'); }
@property auto WACS_TBTB       () { pragma(inline, true); return NCURSES_WACS('X'); }
@property auto WACS_TTTT       () { pragma(inline, true); return NCURSES_WACS('N'); }

alias WACS_T_ULCORNER = WACS_BTTB;
alias WACS_T_LLCORNER = WACS_TTBB;
alias WACS_T_URCORNER = WACS_BBTT;
alias WACS_T_LRCORNER = WACS_TBBT;
alias WACS_T_RTEE     = WACS_TBTT;
alias WACS_T_LTEE     = WACS_TTTB;
alias WACS_T_BTEE     = WACS_TTBT;
alias WACS_T_TTEE     = WACS_BTTT;
alias WACS_T_HLINE    = WACS_BTBT;
alias WACS_T_VLINE    = WACS_TBTB;
alias WACS_T_PLUS     = WACS_TTTT;

/*
 * Function prototypes for wide-character operations.
 *
 * "generated" comments should include ":WIDEC" to make the corresponding
 * functions ifdef'd in lib_gen.c
 *
 * "implemented" comments do not need this marker.
 */

extern nothrow @nogc NCURSES_EXPORT!(int) add_wch (const(cchar_t) *);                  /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) add_wchnstr (const(cchar_t) *, int);         /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) add_wchstr (const(cchar_t) *);               /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) addnwstr (const(wchar_t) *, int);            /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) addwstr (const(wchar_t) *);                  /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) bkgrnd (const(cchar_t) *);                   /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(void) bkgrndset (const(cchar_t) *);               /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) border_set (const(cchar_t)*,const(cchar_t)*,const(cchar_t)*,const(cchar_t)*,const(cchar_t)*,const(cchar_t)*,const(cchar_t)*,const(cchar_t)*); /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) box_set (WINDOW *, const(cchar_t) *, const(cchar_t) *);       /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) echo_wchar (const(cchar_t) *);               /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) erasewchar (wchar_t*);                      /* implemented */
extern nothrow @nogc NCURSES_EXPORT!(int) get_wch (wint_t *);                         /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) get_wstr (wint_t *);                                /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) getbkgrnd (cchar_t *);                      /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) getcchar (const(cchar_t) *, wchar_t*, attr_t*, NCURSES_PAIRS_T*, void*);     /* implemented */
extern nothrow @nogc NCURSES_EXPORT!(int) getn_wstr (wint_t *, int);                  /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) hline_set (const(cchar_t) *, int);           /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) in_wch (cchar_t *);                         /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) in_wchnstr (cchar_t *, int);                        /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) in_wchstr (cchar_t *);                      /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) innwstr (wchar_t *, int);                   /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) ins_nwstr (const(wchar_t) *, int);           /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) ins_wch (const(cchar_t) *);                  /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) ins_wstr (const(wchar_t) *);                 /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) inwstr (wchar_t *);                         /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(NCURSES_CONST!char*) key_name (wchar_t);         /* implemented */
extern nothrow @nogc NCURSES_EXPORT!(int) killwchar (wchar_t *);                      /* implemented */
extern nothrow @nogc NCURSES_EXPORT!(int) mvadd_wch (int, int, const(cchar_t) *);      /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) mvadd_wchnstr (int, int, const(cchar_t) *, int);/* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) mvadd_wchstr (int, int, const(cchar_t) *);   /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) mvaddnwstr (int, int, const(wchar_t) *, int);        /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) mvaddwstr (int, int, const(wchar_t) *);      /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) mvget_wch (int, int, wint_t *);             /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) mvget_wstr (int, int, wint_t *);            /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) mvgetn_wstr (int, int, wint_t *, int);      /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) mvhline_set (int, int, const(cchar_t) *, int);       /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) mvin_wch (int, int, cchar_t *);             /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) mvin_wchnstr (int, int, cchar_t *, int);    /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) mvin_wchstr (int, int, cchar_t *);          /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) mvinnwstr (int, int, wchar_t *, int);       /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) mvins_nwstr (int, int, const(wchar_t) *, int);       /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) mvins_wch (int, int, const(cchar_t) *);      /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) mvins_wstr (int, int, const(wchar_t) *);     /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) mvinwstr (int, int, wchar_t *);             /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) mvvline_set (int, int, const(cchar_t) *, int);       /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) mvwadd_wch (WINDOW *, int, int, const(cchar_t) *);   /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) mvwadd_wchnstr (WINDOW *, int, int, const(cchar_t) *, int); /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) mvwadd_wchstr (WINDOW *, int, int, const(cchar_t) *);        /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) mvwaddnwstr (WINDOW *, int, int, const(wchar_t) *, int);/* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) mvwaddwstr (WINDOW *, int, int, const(wchar_t) *);   /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) mvwget_wch (WINDOW *, int, int, wint_t *);  /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) mvwget_wstr (WINDOW *, int, int, wint_t *); /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) mvwgetn_wstr (WINDOW *, int, int, wint_t *, int);/* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) mvwhline_set (WINDOW *, int, int, const(cchar_t) *, int);/* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) mvwin_wch (WINDOW *, int, int, cchar_t *);  /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) mvwin_wchnstr (WINDOW *, int,int, cchar_t *,int);   /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) mvwin_wchstr (WINDOW *, int, int, cchar_t *);       /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) mvwinnwstr (WINDOW *, int, int, wchar_t *, int);    /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) mvwins_nwstr (WINDOW *, int,int, const(wchar_t) *,int); /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) mvwins_wch (WINDOW *, int, int, const(cchar_t) *);   /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) mvwins_wstr (WINDOW *, int, int, const(wchar_t) *);  /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) mvwinwstr (WINDOW *, int, int, wchar_t *);          /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) mvwvline_set (WINDOW *, int,int, const(cchar_t) *,int); /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) pecho_wchar (WINDOW *, const(cchar_t) *);    /* implemented */
extern nothrow @nogc NCURSES_EXPORT!(int) setcchar (cchar_t *, const(wchar_t) *, const(attr_t), NCURSES_PAIRS_T, const(void) *); /* implemented */
extern nothrow @nogc NCURSES_EXPORT!(int) slk_wset (int, const(wchar_t) *, int);       /* implemented */
extern nothrow @nogc NCURSES_EXPORT!(attr_t) term_attrs ();                           /* implemented */
extern nothrow @nogc NCURSES_EXPORT!(int) unget_wch (const(wchar_t));                  /* implemented */
extern nothrow @nogc NCURSES_EXPORT!(int) vid_attr (attr_t, NCURSES_PAIRS_T, void *);         /* implemented */
extern nothrow @nogc NCURSES_EXPORT!(int) vid_puts (attr_t, NCURSES_PAIRS_T, void *, NCURSES_OUTC); /* implemented */
extern nothrow @nogc NCURSES_EXPORT!(int) vline_set (const(cchar_t) *, int);           /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) wadd_wch (WINDOW *,const(cchar_t) *);                /* implemented */
extern nothrow @nogc NCURSES_EXPORT!(int) wadd_wchnstr (WINDOW *,const(cchar_t) *,int);        /* implemented */
extern nothrow @nogc NCURSES_EXPORT!(int) wadd_wchstr (WINDOW *,const(cchar_t) *);     /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) waddnwstr (WINDOW *,const(wchar_t) *,int);   /* implemented */
extern nothrow @nogc NCURSES_EXPORT!(int) waddwstr (WINDOW *,const(wchar_t) *);                /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) wbkgrnd (WINDOW *,const(cchar_t) *);         /* implemented */
extern nothrow @nogc NCURSES_EXPORT!(void) wbkgrndset (WINDOW *,const(cchar_t) *);     /* implemented */
extern nothrow @nogc NCURSES_EXPORT!(int) wborder_set (WINDOW *,const(cchar_t)*,const(cchar_t)*,const(cchar_t)*,const(cchar_t)*,const(cchar_t)*,const(cchar_t)*,const(cchar_t)*,const(cchar_t)*);     /* implemented */
extern nothrow @nogc NCURSES_EXPORT!(int) wecho_wchar (WINDOW *, const(cchar_t) *);    /* implemented */
extern nothrow @nogc NCURSES_EXPORT!(int) wget_wch (WINDOW *, wint_t *);              /* implemented */
extern nothrow @nogc NCURSES_EXPORT!(int) wget_wstr (WINDOW *, wint_t *);             /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) wgetbkgrnd (WINDOW *, cchar_t *);           /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) wgetn_wstr (WINDOW *, wint_t *, int);       /* implemented */
extern nothrow @nogc NCURSES_EXPORT!(int) whline_set (WINDOW *, const(cchar_t) *, int);        /* implemented */
extern nothrow @nogc NCURSES_EXPORT!(int) win_wch (WINDOW *, cchar_t *);              /* implemented */
extern nothrow @nogc NCURSES_EXPORT!(int) win_wchnstr (WINDOW *, cchar_t *, int);     /* implemented */
extern nothrow @nogc NCURSES_EXPORT!(int) win_wchstr (WINDOW *, cchar_t *);           /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) winnwstr (WINDOW *, wchar_t *, int);                /* implemented */
extern nothrow @nogc NCURSES_EXPORT!(int) wins_nwstr (WINDOW *, const(wchar_t) *, int);        /* implemented */
extern nothrow @nogc NCURSES_EXPORT!(int) wins_wch (WINDOW *, const(cchar_t) *);       /* implemented */
extern nothrow @nogc NCURSES_EXPORT!(int) wins_wstr (WINDOW *, const(wchar_t) *);      /* generated:WIDEC */
extern nothrow @nogc NCURSES_EXPORT!(int) winwstr (WINDOW *, wchar_t *);              /* implemented */
extern nothrow @nogc NCURSES_EXPORT!(wchar_t*) wunctrl (cchar_t *);                   /* implemented */
extern nothrow @nogc NCURSES_EXPORT!(int) wvline_set (WINDOW *, const(cchar_t) *, int);        /* implemented */

static if (NCURSES_SP_FUNCS) {
extern nothrow @nogc NCURSES_EXPORT!(attr_t) NCURSES_SP_NAME(term_attrs) (SCREEN*);            /* implemented:SP_FUNC */
extern nothrow @nogc NCURSES_EXPORT!(int) NCURSES_SP_NAME(erasewchar) (SCREEN*, wchar_t *);    /* implemented:SP_FUNC */
extern nothrow @nogc NCURSES_EXPORT!(int) NCURSES_SP_NAME(killwchar) (SCREEN*, wchar_t *);     /* implemented:SP_FUNC */
extern nothrow @nogc NCURSES_EXPORT!(int) NCURSES_SP_NAME(unget_wch) (SCREEN*, const(wchar_t)); /* implemented:SP_FUNC */
extern nothrow @nogc NCURSES_EXPORT!(int) NCURSES_SP_NAME(vid_attr) (SCREEN*, attr_t, NCURSES_PAIRS_T, void *);        /* implemented:SP_FUNC */
extern nothrow @nogc NCURSES_EXPORT!(int) NCURSES_SP_NAME(vid_puts) (SCREEN*, attr_t, NCURSES_PAIRS_T, void *, NCURSES_SP_OUTC);       /* implemented:SP_FUNC */
extern nothrow @nogc NCURSES_EXPORT!(wchar_t*) NCURSES_SP_NAME(wunctrl) (SCREEN*, cchar_t *);  /* implemented:SP_FUNC */
}

version (NCURSES_NOMACROS) {} else {

/*
 * XSI curses macros for XPG4 conformance.
 */
auto  add_wch(c)(c c)															{ pragma(inline, true); return wadd_wch(stdscr,(c)); }
auto  add_wchnstr(str,n)(str str,n n)											{ pragma(inline, true); return wadd_wchnstr(stdscr,(str),(n)); }
auto  add_wchstr(str)(str str)													{ pragma(inline, true); return wadd_wchstr(stdscr,(str)); }
auto  addnwstr(wstr,n)(wstr wstr,n n)											{ pragma(inline, true); return waddnwstr(stdscr,(wstr),(n)); }
auto  addwstr(wstr)(wstr wstr)													{ pragma(inline, true); return waddwstr(stdscr,(wstr)); }
auto  bkgrnd(c)(c c)															{ pragma(inline, true); return wbkgrnd(stdscr,(c)); }
auto  bkgrndset(c)(c c)															{ pragma(inline, true); return wbkgrndset(stdscr,(c)); }
auto  border_set(l,r,t,b,tl,tr,bl,br)(l l,r r,t t,b b,tl tl,tr tr,bl bl,br br)	{ pragma(inline, true); return wborder_set(stdscr,(l),(r),(t),(b),tl,tr,bl,br); }
auto  box_set(w,v,h)(w w,v v,h h)												{ pragma(inline, true); return wborder_set((w),(v),(v),(h),(h),0,0,0,0); }
auto  echo_wchar(c)(c c)														{ pragma(inline, true); return wecho_wchar(stdscr,(c)); }
auto  get_wch(c)(c c)															{ pragma(inline, true); return wget_wch(stdscr,(c)); }
auto  get_wstr(t)(t t)															{ pragma(inline, true); return wget_wstr(stdscr,(t)); }
auto  getbkgrnd(wch)(wch wch)													{ pragma(inline, true); return wgetbkgrnd(stdscr,(wch)); }
auto  getn_wstr(t,n)(t t,n n)													{ pragma(inline, true); return wgetn_wstr(stdscr,(t),(n)); }
auto  hline_set(c,n)(c c,n n)													{ pragma(inline, true); return whline_set(stdscr,(c),(n)); }
auto  in_wch(c)(c c)															{ pragma(inline, true); return win_wch(stdscr,(c)); }
auto  in_wchnstr(c,n)(c c,n n)													{ pragma(inline, true); return win_wchnstr(stdscr,(c),(n)); }
auto  in_wchstr(c)(c c)															{ pragma(inline, true); return win_wchstr(stdscr,(c)); }
auto  innwstr(c,n)(c c,n n)														{ pragma(inline, true); return winnwstr(stdscr,(c),(n)); }
auto  ins_nwstr(t,n)(t t,n n)													{ pragma(inline, true); return wins_nwstr(stdscr,(t),(n)); }
auto  ins_wch(c)(c c)															{ pragma(inline, true); return wins_wch(stdscr,(c)); }
auto  ins_wstr(t)(t t)															{ pragma(inline, true); return wins_wstr(stdscr,(t)); }
auto  inwstr(c)(c c)															{ pragma(inline, true); return winwstr(stdscr,(c)); }
auto  vline_set(c,n)(c c,n n)													{ pragma(inline, true); return wvline_set(stdscr,(c),(n)); }
auto  wadd_wchstr(win,str)(win win,str str)										{ pragma(inline, true); return wadd_wchnstr((win),(str),-1); }
auto  waddwstr(win,wstr)(win win,wstr wstr)										{ pragma(inline, true); return waddnwstr((win),(wstr),-1); }
auto  wget_wstr(w,t)(w w,t t)													{ pragma(inline, true); return wgetn_wstr((w),(t),-1); }
auto  win_wchstr(w,c)(w w,c c)													{ pragma(inline, true); return win_wchnstr((w),(c),-1); }
auto  wins_wstr(w,t)(w w,t t)													{ pragma(inline, true); return wins_nwstr((w),(t),-1); }

static if (!NCURSES_OPAQUE)														{
auto  wgetbkgrnd(win,wch)(win win,wch wch)										{ pragma(inline, true); return (NCURSES_OK_ADDR(wch) ? ((win) ? (*(wch) = (win)._bkgrnd) : *(wch), OK) : ERR); }
}

auto  mvadd_wch(y,x,c)(y y,x x,c c)												{ pragma(inline, true); return mvwadd_wch(stdscr,(y),(x),(c)); }
auto  mvadd_wchnstr(y,x,s,n)(y y,x x,s s,n n)									{ pragma(inline, true); return mvwadd_wchnstr(stdscr,(y),(x),(s),(n)); }
auto  mvadd_wchstr(y,x,s)(y y,x x,s s)											{ pragma(inline, true); return mvwadd_wchstr(stdscr,(y),(x),(s)); }
auto  mvaddnwstr(y,x,wstr,n)(y y,x x,wstr wstr,n n)								{ pragma(inline, true); return mvwaddnwstr(stdscr,(y),(x),(wstr),(n)); }
auto  mvaddwstr(y,x,wstr)(y y,x x,wstr wstr)									{ pragma(inline, true); return mvwaddwstr(stdscr,(y),(x),(wstr)); }
auto  mvget_wch(y,x,c)(y y,x x,c c)												{ pragma(inline, true); return mvwget_wch(stdscr,(y),(x),(c)); }
auto  mvget_wstr(y,x,t)(y y,x x,t t)											{ pragma(inline, true); return mvwget_wstr(stdscr,(y),(x),(t)); }
auto  mvgetn_wstr(y,x,t,n)(y y,x x,t t,n n)										{ pragma(inline, true); return mvwgetn_wstr(stdscr,(y),(x),(t),(n)); }
auto  mvhline_set(y,x,c,n)(y y,x x,c c,n n)										{ pragma(inline, true); return mvwhline_set(stdscr,(y),(x),(c),(n)); }
auto  mvin_wch(y,x,c)(y y,x x,c c)												{ pragma(inline, true); return mvwin_wch(stdscr,(y),(x),(c)); }
auto  mvin_wchnstr(y,x,c,n)(y y,x x,c c,n n)									{ pragma(inline, true); return mvwin_wchnstr(stdscr,(y),(x),(c),(n)); }
auto  mvin_wchstr(y,x,c)(y y,x x,c c)											{ pragma(inline, true); return mvwin_wchstr(stdscr,(y),(x),(c)); }
auto  mvinnwstr(y,x,c,n)(y y,x x,c c,n n)										{ pragma(inline, true); return mvwinnwstr(stdscr,(y),(x),(c),(n)); }
auto  mvins_nwstr(y,x,t,n)(y y,x x,t t,n n)										{ pragma(inline, true); return mvwins_nwstr(stdscr,(y),(x),(t),(n)); }
auto  mvins_wch(y,x,c)(y y,x x,c c)												{ pragma(inline, true); return mvwins_wch(stdscr,(y),(x),(c)); }
auto  mvins_wstr(y,x,t)(y y,x x,t t)											{ pragma(inline, true); return mvwins_wstr(stdscr,(y),(x),(t)); }
auto  mvinwstr(y,x,c)(y y,x x,c c)												{ pragma(inline, true); return mvwinwstr(stdscr,(y),(x),(c)); }
auto  mvvline_set(y,x,c,n)(y y,x x,c c,n n)										{ pragma(inline, true); return mvwvline_set(stdscr,(y),(x),(c),(n)); }

auto  mvwadd_wch(win,y,x,c)(win win,y y,x x,c c)								{ pragma(inline, true); return (wmove(win,(y),(x)) == ERR ? ERR : wadd_wch((win),(c))); }
auto  mvwadd_wchnstr(win,y,x,s,n)(win win,y y,x x,s s,n n)						{ pragma(inline, true); return (wmove(win,(y),(x)) == ERR ? ERR : wadd_wchnstr((win),(s),(n))); }
auto  mvwadd_wchstr(win,y,x,s)(win win,y y,x x,s s)								{ pragma(inline, true); return (wmove(win,(y),(x)) == ERR ? ERR : wadd_wchstr((win),(s))); }
auto  mvwaddnwstr(win,y,x,wstr,n)(win win,y y,x x,wstr wstr,n n)				{ pragma(inline, true); return (wmove(win,(y),(x)) == ERR ? ERR : waddnwstr((win),(wstr),(n))); }
auto  mvwaddwstr(win,y,x,wstr)(win win,y y,x x,wstr wstr)						{ pragma(inline, true); return (wmove(win,(y),(x)) == ERR ? ERR : waddwstr((win),(wstr))); }
auto  mvwget_wch(win,y,x,c)(win win,y y,x x,c c)								{ pragma(inline, true); return (wmove(win,(y),(x)) == ERR ? ERR : wget_wch((win),(c))); }
auto  mvwget_wstr(win,y,x,t)(win win,y y,x x,t t)								{ pragma(inline, true); return (wmove(win,(y),(x)) == ERR ? ERR : wget_wstr((win),(t))); }
auto  mvwgetn_wstr(win,y,x,t,n)(win win,y y,x x,t t,n n)						{ pragma(inline, true); return (wmove(win,(y),(x)) == ERR ? ERR : wgetn_wstr((win),(t),(n))); }
auto  mvwhline_set(win,y,x,c,n)(win win,y y,x x,c c,n n)						{ pragma(inline, true); return (wmove(win,(y),(x)) == ERR ? ERR : whline_set((win),(c),(n))); }
auto  mvwin_wch(win,y,x,c)(win win,y y,x x,c c)									{ pragma(inline, true); return (wmove(win,(y),(x)) == ERR ? ERR : win_wch((win),(c))); }
auto  mvwin_wchnstr(win,y,x,c,n)(win win,y y,x x,c c,n n)						{ pragma(inline, true); return (wmove(win,(y),(x)) == ERR ? ERR : win_wchnstr((win),(c),(n))); }
auto  mvwin_wchstr(win,y,x,c)(win win,y y,x x,c c)								{ pragma(inline, true); return (wmove(win,(y),(x)) == ERR ? ERR : win_wchstr((win),(c))); }
auto  mvwinnwstr(win,y,x,c,n)(win win,y y,x x,c c,n n)							{ pragma(inline, true); return (wmove(win,(y),(x)) == ERR ? ERR : winnwstr((win),(c),(n))); }
auto  mvwins_nwstr(win,y,x,t,n)(win win,y y,x x,t t,n n)						{ pragma(inline, true); return (wmove(win,(y),(x)) == ERR ? ERR : wins_nwstr((win),(t),(n))); }
auto  mvwins_wch(win,y,x,c)(win win,y y,x x,c c)								{ pragma(inline, true); return (wmove(win,(y),(x)) == ERR ? ERR : wins_wch((win),(c))); }
auto  mvwins_wstr(win,y,x,t)(win win,y y,x x,t t)								{ pragma(inline, true); return (wmove(win,(y),(x)) == ERR ? ERR : wins_wstr((win),(t))); }
auto  mvwinwstr(win,y,x,c)(win win,y y,x x,c c)									{ pragma(inline, true); return (wmove(win,(y),(x)) == ERR ? ERR : winwstr((win),(c))); }
auto  mvwvline_set(win,y,x,c,n)(win win,y y,x x,c c,n n)						{ pragma(inline, true); return (wmove(win,(y),(x)) == ERR ? ERR : wvline_set((win),(c),(n))); }

} /* NCURSES_NOMACROS */

// #if defined(TRACE) || defined(NCURSES_TEST)
// extern nothrow @nogc NCURSES_EXPORT!(const(char) *) _nc_viswbuf(const(wchar_t) *);
// extern nothrow @nogc NCURSES_EXPORT!(const(char) *) _nc_viswibuf(const(wint_t) *);
// #endif

} /* NCURSES_WIDECHAR */
/* $Id: curses.tail,v 1.26 2021/03/20 15:49:25 tom Exp $ */
/*
 * vile:cmode:
 * This file is part of ncurses, designed to be appended after curses.h.in
 * (see that file for the relevant copyright).
 */

/* mouse interface */

static if (NCURSES_MOUSE_VERSION > 1) {
auto  NCURSES_MOUSE_MASK(b,m)(b b,m m) { pragma(inline, true); return ((m) << (((b) - 1) * 5)); }
} else {
auto  NCURSES_MOUSE_MASK(b,m)(b b,m m) { pragma(inline, true); return ((m) << (((b) - 1) * 6)); }
}

enum NCURSES_BUTTON_RELEASED = octal!01L;
enum NCURSES_BUTTON_PRESSED  = octal!02L;
enum NCURSES_BUTTON_CLICKED  = octal!04L;
enum NCURSES_DOUBLE_CLICKED  = octal!10L;
enum NCURSES_TRIPLE_CLICKED  = octal!20L;
enum NCURSES_RESERVED_EVENT  = octal!40L;

/* event masks */
enum BUTTON1_RELEASED        = NCURSES_MOUSE_MASK(1, NCURSES_BUTTON_RELEASED);
enum BUTTON1_PRESSED         = NCURSES_MOUSE_MASK(1, NCURSES_BUTTON_PRESSED);
enum BUTTON1_CLICKED         = NCURSES_MOUSE_MASK(1, NCURSES_BUTTON_CLICKED);
enum BUTTON1_DOUBLE_CLICKED  = NCURSES_MOUSE_MASK(1, NCURSES_DOUBLE_CLICKED);
enum BUTTON1_TRIPLE_CLICKED  = NCURSES_MOUSE_MASK(1, NCURSES_TRIPLE_CLICKED);

enum BUTTON2_RELEASED        = NCURSES_MOUSE_MASK(2, NCURSES_BUTTON_RELEASED);
enum BUTTON2_PRESSED         = NCURSES_MOUSE_MASK(2, NCURSES_BUTTON_PRESSED);
enum BUTTON2_CLICKED         = NCURSES_MOUSE_MASK(2, NCURSES_BUTTON_CLICKED);
enum BUTTON2_DOUBLE_CLICKED  = NCURSES_MOUSE_MASK(2, NCURSES_DOUBLE_CLICKED);
enum BUTTON2_TRIPLE_CLICKED  = NCURSES_MOUSE_MASK(2, NCURSES_TRIPLE_CLICKED);

enum BUTTON3_RELEASED        = NCURSES_MOUSE_MASK(3, NCURSES_BUTTON_RELEASED);
enum BUTTON3_PRESSED         = NCURSES_MOUSE_MASK(3, NCURSES_BUTTON_PRESSED);
enum BUTTON3_CLICKED         = NCURSES_MOUSE_MASK(3, NCURSES_BUTTON_CLICKED);
enum BUTTON3_DOUBLE_CLICKED  = NCURSES_MOUSE_MASK(3, NCURSES_DOUBLE_CLICKED);
enum BUTTON3_TRIPLE_CLICKED  = NCURSES_MOUSE_MASK(3, NCURSES_TRIPLE_CLICKED);

enum BUTTON4_RELEASED        = NCURSES_MOUSE_MASK(4, NCURSES_BUTTON_RELEASED);
enum BUTTON4_PRESSED         = NCURSES_MOUSE_MASK(4, NCURSES_BUTTON_PRESSED);
enum BUTTON4_CLICKED         = NCURSES_MOUSE_MASK(4, NCURSES_BUTTON_CLICKED);
enum BUTTON4_DOUBLE_CLICKED  = NCURSES_MOUSE_MASK(4, NCURSES_DOUBLE_CLICKED);
enum BUTTON4_TRIPLE_CLICKED  = NCURSES_MOUSE_MASK(4, NCURSES_TRIPLE_CLICKED);

/*
 * In 32 bits the version-1 scheme does not provide enough space for a 5th
 * button, unless we choose to change the ABI by omitting the reserved-events.
 */
static if (NCURSES_MOUSE_VERSION > 1) {

enum BUTTON5_RELEASED        = NCURSES_MOUSE_MASK(5, NCURSES_BUTTON_RELEASED);
enum BUTTON5_PRESSED         = NCURSES_MOUSE_MASK(5, NCURSES_BUTTON_PRESSED);
enum BUTTON5_CLICKED         = NCURSES_MOUSE_MASK(5, NCURSES_BUTTON_CLICKED);
enum BUTTON5_DOUBLE_CLICKED  = NCURSES_MOUSE_MASK(5, NCURSES_DOUBLE_CLICKED);
enum BUTTON5_TRIPLE_CLICKED  = NCURSES_MOUSE_MASK(5, NCURSES_TRIPLE_CLICKED);

enum BUTTON_CTRL             = NCURSES_MOUSE_MASK(6, octal! 01L);
enum BUTTON_SHIFT            = NCURSES_MOUSE_MASK(6, octal! 02L);
enum BUTTON_ALT              = NCURSES_MOUSE_MASK(6, octal! 04L);
enum REPORT_MOUSE_POSITION   = NCURSES_MOUSE_MASK(6, octal! 10L);

} else {

enum BUTTON1_RESERVED_EVENT  = NCURSES_MOUSE_MASK(1, NCURSES_RESERVED_EVENT);
enum BUTTON2_RESERVED_EVENT  = NCURSES_MOUSE_MASK(2, NCURSES_RESERVED_EVENT);
enum BUTTON3_RESERVED_EVENT  = NCURSES_MOUSE_MASK(3, NCURSES_RESERVED_EVENT);
enum BUTTON4_RESERVED_EVENT  = NCURSES_MOUSE_MASK(4, NCURSES_RESERVED_EVENT);

enum BUTTON_CTRL             = NCURSES_MOUSE_MASK(5, octal! 01L);
enum BUTTON_SHIFT            = NCURSES_MOUSE_MASK(5, octal! 02L);
enum BUTTON_ALT              = NCURSES_MOUSE_MASK(5, octal! 04L);
enum REPORT_MOUSE_POSITION   = NCURSES_MOUSE_MASK(5, octal! 10L);

}

enum ALL_MOUSE_EVENTS        = (REPORT_MOUSE_POSITION - 1);

/* macros to extract single event-bits from masks */
auto  BUTTON_RELEASE(e, x)(e e, x x)            { pragma(inline, true); return ((e) & NCURSES_MOUSE_MASK(x, octal!01)); }
auto  BUTTON_PRESS(e, x)(e e, x x)              { pragma(inline, true); return ((e) & NCURSES_MOUSE_MASK(x, octal!02)); }
auto  BUTTON_CLICK(e, x)(e e, x x)              { pragma(inline, true); return ((e) & NCURSES_MOUSE_MASK(x, octal!04)); }
auto  BUTTON_DOUBLE_CLICK(e, x)(e e, x x)       { pragma(inline, true); return ((e) & NCURSES_MOUSE_MASK(x, octal!10)); }
auto  BUTTON_TRIPLE_CLICK(e, x)(e e, x x)       { pragma(inline, true); return ((e) & NCURSES_MOUSE_MASK(x, octal!20)); }
auto  BUTTON_RESERVED_EVENT(e, x)(e e, x x)     { pragma(inline, true); return ((e) & NCURSES_MOUSE_MASK(x, octal!40)); }

struct MEVENT
{
    short id;           /* ID to distinguish multiple devices */
    int x, y, z;        /* event coordinates (character-cell) */
    mmask_t bstate;     /* button state bits */
}

extern nothrow @nogc NCURSES_EXPORT!(bool)    has_mouse();
extern nothrow @nogc NCURSES_EXPORT!(int)     getmouse (MEVENT *);
extern nothrow @nogc NCURSES_EXPORT!(int)     ungetmouse (MEVENT *);
extern nothrow @nogc NCURSES_EXPORT!(mmask_t) mousemask (mmask_t, mmask_t *);
extern nothrow @nogc NCURSES_EXPORT!(bool)    wenclose (const(WINDOW) *, int, int);
extern nothrow @nogc NCURSES_EXPORT!(int)     mouseinterval (int);
extern nothrow @nogc NCURSES_EXPORT!(bool)    wmouse_trafo (const(WINDOW)*, int*, int*, bool);
// extern nothrow @nogc NCURSES_EXPORT!(bool)    mouse_trafo (int*, int*, bool);              /* generated */

static if (NCURSES_SP_FUNCS) {
extern nothrow @nogc NCURSES_EXPORT!(bool)    NCURSES_SP_NAME(has_mouse) (SCREEN*);
extern nothrow @nogc NCURSES_EXPORT!(int)     NCURSES_SP_NAME(getmouse) (SCREEN*, MEVENT *);
extern nothrow @nogc NCURSES_EXPORT!(int)     NCURSES_SP_NAME(ungetmouse) (SCREEN*,MEVENT *);
extern nothrow @nogc NCURSES_EXPORT!(mmask_t) NCURSES_SP_NAME(mousemask) (SCREEN*, mmask_t, mmask_t *);
extern nothrow @nogc NCURSES_EXPORT!(int)     NCURSES_SP_NAME(mouseinterval) (SCREEN*, int);
}

version (NCURSES_NOMACROS) {} else {
auto  mouse_trafo(y,x,to_screen)(y y,x x,to_screen to_screen) { pragma(inline, true); return wmouse_trafo(stdscr,y,x,to_screen); }
}

/* other non-XSI functions */

extern nothrow @nogc NCURSES_EXPORT!(int) mcprint (char *, int);      /* direct data to printer */
extern nothrow @nogc NCURSES_EXPORT!(int) has_key (int);              /* do we have given key? */

static if (NCURSES_SP_FUNCS) {
extern nothrow @nogc NCURSES_EXPORT!(int) NCURSES_SP_NAME(has_key) (SCREEN*, int);    /* do we have given key? */
extern nothrow @nogc NCURSES_EXPORT!(int) NCURSES_SP_NAME(mcprint) (SCREEN*, char *, int);     /* direct data to printer */
}

/* Debugging : use with libncurses_g.a */

extern nothrow @nogc NCURSES_EXPORT!(void) _tracef (const(char) *, ...) /*GCC_PRINTFLIKE(1,2)*/;
extern nothrow @nogc NCURSES_EXPORT!(char *) _traceattr (attr_t);
extern nothrow @nogc NCURSES_EXPORT!(char *) _traceattr2 (int, chtype);
extern nothrow @nogc NCURSES_EXPORT!(char *) _tracechar (int);
extern nothrow @nogc NCURSES_EXPORT!(char *) _tracechtype (chtype);
extern nothrow @nogc NCURSES_EXPORT!(char *) _tracechtype2 (int, chtype);
static if (NCURSES_WIDECHAR) {
alias _tracech_t              = _tracecchar_t;
extern nothrow @nogc NCURSES_EXPORT!(char *) _tracecchar_t (const(cchar_t) *);
alias _tracech_t2             = _tracecchar_t2;
extern nothrow @nogc NCURSES_EXPORT!(char *) _tracecchar_t2 (int, const(cchar_t) *);
} else {
alias _tracech_t              = _tracechtype;
alias _tracech_t2             = _tracechtype2;
}
deprecated("use curses_trace") extern nothrow @nogc NCURSES_EXPORT!(void) trace (const(uint));
extern nothrow @nogc NCURSES_EXPORT!(uint) curses_trace (const(uint));

/* trace masks */
enum TRACE_DISABLE   = 0x0000;  /* turn off tracing */
enum TRACE_TIMES     = 0x0001;  /* trace user and system times of updates */
enum TRACE_TPUTS     = 0x0002;  /* trace tputs calls */
enum TRACE_UPDATE    = 0x0004;  /* trace update actions, old & new screens */
enum TRACE_MOVE      = 0x0008;  /* trace cursor moves and scrolls */
enum TRACE_CHARPUT   = 0x0010;  /* trace all character outputs */
enum TRACE_ORDINARY  = 0x001F;  /* trace all update actions */
enum TRACE_CALLS     = 0x0020;  /* trace all curses calls */
enum TRACE_VIRTPUT   = 0x0040;  /* trace virtual character puts */
enum TRACE_IEVENT    = 0x0080;  /* trace low-level input processing */
enum TRACE_BITS      = 0x0100;  /* trace state of TTY control bits */
enum TRACE_ICALLS    = 0x0200;  /* trace internal/nested calls */
enum TRACE_CCALLS    = 0x0400;  /* trace per-character calls */
enum TRACE_DATABASE  = 0x0800;  /* trace read/write of terminfo/termcap data */
enum TRACE_ATTRS     = 0x1000;  /* trace attribute updates */

enum TRACE_SHIFT     = 13;      /* number of bits in the trace masks */
enum TRACE_MAXIMUM   = ((1 << TRACE_SHIFT) - 1); /* maximum trace level */

// #if defined(TRACE) || defined(NCURSES_TEST)
extern NCURSES_EXPORT_VAR!(int) _nc_optimize_enable;              /* enable optimizations */
extern nothrow @nogc NCURSES_EXPORT!(const(char) *) _nc_visbuf (const(char) *);
enum OPTIMIZE_MVCUR          = 0x01;    /* cursor movement optimization */
enum OPTIMIZE_HASHMAP        = 0x02;    /* diff hashing to detect scrolls */
enum OPTIMIZE_SCROLL         = 0x04;    /* scroll optimization */
enum OPTIMIZE_ALL            = 0xff;    /* enable all optimizations (dflt) */
// #endif

extern nothrow @nogc /*GCC_NORETURN*/ NCURSES_EXPORT!(void) exit_curses (int);

// #include <unctrl.h>

// #ifdef __cplusplus

// #ifndef NCURSES_NOMACROS

/* these names conflict with STL */
// #undef box
// #undef clear
// #undef erase
// #undef move
// #undef refresh

// #endif /* NCURSES_NOMACROS */

// D porting note: these have to be here to avoid dependency issues.

// struct _win_st;
alias WINDOW = _win_st;
