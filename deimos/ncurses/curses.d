/****************************************************************************
 * Copyright (c) 1998-2009,2010 Free Software Foundation, Inc.              *
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

/* $Id: curses.h.in,v 1.215 2010/04/29 09:46:38 tom Exp $ */
module deimos.ncurses.curses;

/*
 * We need FILE, etc.  Include this before checking any feature symbols.
 */
import std.c.stdio;
import std.c.stddef;    /* we want wchar_t */
import std.c.stdarg;    /* we need va_list */
import core.stdc.config; /* we need c_ulong */

//#include <ncursesw/unctrl.h>
public import deimos.ncurses.unctrl;

//TODO check if needed... I don't have a windows machine...
version(Win32)
{
  alias wchar wint_t;
}
else
{
  alias dchar wint_t;
}

/* These are defined only in curses.h, and are used for conditional compiles */
immutable enum
{
    NCURSES_VERSION_MAJOR = 5,
    NCURSES_VERSION_MINOR = 7,
    NCURSES_VERSION_PATCH = 20101128
}
/* This is defined in more than one ncurses header, for identification */
string NCURSES_VERSION = "5.7";

extern (C) nothrow
{

/* types */
alias   c_ulong    chtype;
alias   c_ulong    mmask_t;
alias   chtype  attr_t;
alias   int     OPTIONS;
alias   void    SCREEN;


/* attributes */
//Thank you, Dejan Lekic, dejan.lekic @ (gmail.com || kcl.ac.uk)
immutable ubyte NCURSES_ATTR_SHIFT = 8;

chtype NCURSES_BITS(uint mask, ubyte shift)
{   return (mask << (shift + NCURSES_ATTR_SHIFT));  }

immutable enum :chtype
{
    A_NORMAL        = (1u - 1u),
    A_ATTRIBUTES    = NCURSES_BITS(~(1u - 1u),0),
    A_CHARTEXT      = (NCURSES_BITS(1u,0) - 1u),
    A_COLOR         = NCURSES_BITS(((1u) << 8) - 1u,0),
    A_STANDOUT      = NCURSES_BITS(1u,8),
    A_UNDERLINE     = NCURSES_BITS(1u,9),
    A_REVERSE       = NCURSES_BITS(1u,10),
    A_BLINK         = NCURSES_BITS(1u,11),
    A_DIM           = NCURSES_BITS(1u,12),
    A_BOLD          = NCURSES_BITS(1u,13),
    A_ALTCHARSET    = NCURSES_BITS(1u,14),
    A_INVIS         = NCURSES_BITS(1u,15),
    A_PROTECT       = NCURSES_BITS(1u,16),
    A_HORIZONTAL    = NCURSES_BITS(1u,17),
    A_LEFT          = NCURSES_BITS(1u,18),
    A_LOW           = NCURSES_BITS(1u,19),
    A_RIGHT         = NCURSES_BITS(1u,20),
    A_TOP           = NCURSES_BITS(1u,21),
    A_VERTICAL      = NCURSES_BITS(1u,22),

/*
 * X/Open attributes.  In the ncurses implementation, they are identical to the
 * A_ attributes.
 */
    WA_ATTRIBUTES   = A_ATTRIBUTES,
    WA_NORMAL       = A_NORMAL,
    WA_STANDOUT     = A_STANDOUT,
    WA_UNDERLINE    = A_UNDERLINE,
    WA_REVERSE      = A_REVERSE,
    WA_BLINK        = A_BLINK,
    WA_DIM          = A_DIM,
    WA_BOLD         = A_BOLD,
    WA_ALTCHARSET   = A_ALTCHARSET,
    WA_INVIS        = A_INVIS,
    WA_PROTECT      = A_PROTECT,
    WA_HORIZONTAL   = A_HORIZONTAL,
    WA_LEFT         = A_LEFT,
    WA_LOW          = A_LOW,
    WA_RIGHT        = A_RIGHT,
    WA_TOP          = A_TOP,
    WA_VERTICAL     = A_VERTICAL
}


immutable enum :chtype
{
    /* colors */
    COLOR_BLACK   = 0,
    COLOR_RED     = 1,
    COLOR_GREEN   = 2,
    COLOR_YELLOW  = 3,
    COLOR_BLUE    = 4,
    COLOR_MAGENTA = 5,
    COLOR_CYAN    = 6,
    COLOR_WHITE   = 7
}


/* global variables */
__gshared WINDOW*   stdscr;
__gshared WINDOW*   curscr;
__gshared WINDOW*   newscr;
__gshared char      ttytype[];
__gshared int       COLORS;
__gshared int       COLOR_PAIRS;
__gshared int       LINES;
__gshared int       COLS;
__gshared int       TABSIZE;
__gshared int       ESCDELAY;
__gshared chtype    acs_map[256];



/* acs symbols */
/* VT100 symbols begin here */

@property auto ACS_ULCORNER()()
{   return acs_map[cast(ubyte)'l']; }
@property auto ACS_LLCORNER()()
{   return acs_map[cast(ubyte)'m']; }
@property auto ACS_URCORNER()()
{   return acs_map[cast(ubyte)'k']; }
@property auto ACS_LRCORNER()()
{   return acs_map[cast(ubyte)'j']; }
@property auto ACS_LTEE()()
{   return acs_map[cast(ubyte)'t']; }
@property auto ACS_RTEE()()
{   return acs_map[cast(ubyte)'u']; }
@property auto ACS_BTEE()()
{   return acs_map[cast(ubyte)'v']; }
@property auto ACS_TTEE()()
{   return acs_map[cast(ubyte)'w']; }
@property auto ACS_HLINE()()
{   return acs_map[cast(ubyte)'q']; }
@property auto ACS_VLINE()()
{   return acs_map[cast(ubyte)'x']; }
@property auto ACS_PLUS()()
{   return acs_map[cast(ubyte)'n']; }
@property auto ACS_S1()()
{   return acs_map[cast(ubyte)'o']; }
@property auto ACS_S9()()
{   return acs_map[cast(ubyte)'s']; }
@property auto ACS_DIAMOND()()
{   return acs_map[cast(ubyte)'`']; }
@property auto ACS_CKBOARD()()
{   return acs_map[cast(ubyte)'a']; }
@property auto ACS_DEGREE()()
{   return acs_map[cast(ubyte)'f']; }
@property auto ACS_PLMINUS()()
{   return acs_map[cast(ubyte)'g']; }
@property auto ACS_BULLET()()
{   return acs_map[cast(ubyte)'~']; }

/* Teletype 5410v1 symbols begin here */
@property auto ACS_LARROW()()
{   return acs_map[cast(ubyte)',']; }
@property auto ACS_RARROW()()
{   return  acs_map[cast(ubyte)'+'];}
@property auto ACS_DARROW()()
{   return acs_map[cast(ubyte)'.']; }
@property auto ACS_UARROW()()
{   return acs_map[cast(ubyte)'-']; }
@property auto ACS_BOARD()()
{   return acs_map[cast(ubyte)'h']; }
@property auto ACS_LANTERN()()
{   return acs_map[cast(ubyte)'i']; }
@property auto ACS_BLOCK()()
{   return acs_map[cast(ubyte)'0']; }

/*
 * These aren't documented, but a lot of System Vs have them anyway
 * (you can spot pprryyzz{{||}} in a lot of AT&T terminfo strings).
 * The ACS_names may not match AT&T's, our source didn't know them.
 */
@property auto ACS_S3()()
{   return acs_map[cast(ubyte)'p']; }
@property auto ACS_S7()()
{   return acs_map[cast(ubyte)'r']; }
@property auto ACS_LEQUAL()()
{   return acs_map[cast(ubyte)'y']; }
@property auto ACS_GEQUAL()()
{   return acs_map[cast(ubyte)'z']; }
@property auto ACS_PI()()
{   return acs_map[cast(ubyte)'{']; }
@property auto ACS_NEQUAL()()
{   return acs_map[cast(ubyte)'|']; }
@property auto ACS_STERLING()()
{   return acs_map[cast(ubyte)'}']; }

/*
 * Line drawing ACS names are of the form ACS_trbl, where t is the top, r
 * is the right, b is the bottom, and l is the left.  t, r, b, and l might
 * be B (blank), S (single), D (double), or T (thick).  The subset defined
 * here only uses B and S.
 */
@property auto ACS_BSSB()()
{   return ACS_ULCORNER();  }
@property auto ACS_SSBB()()
{   return ACS_LLCORNER();  }
@property auto ACS_BBSS()()
{   return ACS_URCORNER();  }
@property auto ACS_SBBS()()
{   return ACS_LRCORNER();  }
@property auto ACS_SBSS()()
{   return ACS_RTEE();      }
@property auto ACS_SSSB()()
{   return ACS_LTEE();      }
@property auto ACS_SSBS()()
{   return ACS_BTEE();      }
@property auto ACS_BSSS()()
{   return ACS_TTEE();      }
@property auto ACS_BSBS()()
{   return ACS_HLINE();     }
@property auto ACS_SBSB()()
{   return ACS_VLINE();     }
@property auto ACS_SSSS()()
{   return ACS_PLUS();      }


/* error codes */
immutable enum
{
    OK  = 0,
    ERR = -1
}

immutable enum
{
    /* values for the _flags member */
    _SUBWIN       =  0x01,   /* is this a sub-window? */
    _ENDLINE      =  0x02,   /* is the window flush right? */
    _FULLWIN      =  0x04,   /* is the window full-screen? */
    _SCROLLWIN    =  0x08,   /* bottom edge is at screen bottom? */
    _ISPAD        =  0x10,   /* is this window a pad? */
    _HASMOVED     =  0x20,   /* has cursor moved since last refresh? */
    _WRAPPED      =  0x40    /* cursor was just wrappped */
}

/*
 * this value is used in the firstchar and lastchar fields to mark
 * unchanged lines
 */
immutable int _NOCHANGE = -1;

/*
 * this value is used in the oldindex field to mark lines created by insertions
 * and scrolls.
 */
immutable int _NEWINDEX = -1;

/*
 * cchar_t stores an array of CCHARW_MAX wide characters.  The first is
 * normally a spacing character.  The others are non-spacing.  If those
 * (spacing and nonspacing) do not fill the array, a null L'\0' follows.
 * Otherwise, a null is assumed to follow when extracting via getcchar().
 */
immutable size_t CCHARW_MAX = 5;

struct cchar_t
{
  attr_t attr;
  wchar_t chars[CCHARW_MAX];
}

struct  WINDOW
{
    short   cury, curx;
    short   maxy, maxx;
    short   begy, begx;
    short   flags;

    attr_t  attrs;
    chtype  bkgd;
    bool    notimeout,
            clear,
            leaveok,
            scroll,
            idlok,
            idcok,
            immed,
            sync,
            use_keypad;
    int     delay;
    void*   line;
    short   regtop,
            regbottom;
    int     parx,
            pary;
    WINDOW* parent;

    struct pdat
    {
        short   pad_y,      pad_x,
                pad_top,    pad_left,
                pad_bottom, pad_right;
    }
    pdat pad;

    short yoffset;
    cchar_t bkgrnd;
}

struct _nc_event
{
    int type;
    union data
    {
        long timeout_msec;  /* _NC_EVENT_TIMEOUT_MSEC */
        struct fev
        {
            uint    flags;
            int     fd;
            uint    result;
        }              /* _NC_EVENT_FILE */
    }
}


struct _nc_eventlist
{
    int count;
    int result_flags;   /* _NC_EVENT_TIMEOUT_MSEC or _NC_EVENT_FILE_READABLE */
    _nc_event* events[1];
}

int wgetch_events(WINDOW* win, _nc_eventlist* nc);   /* experimental */
int wgetnstr_events(WINDOW* win, char* str, int one, _nc_eventlist* nc);/* experimental */


/*
 * Function prototypes.  This is the complete X/Open Curses list of required
 * functions.  Those marked `generated' will have sources generated from the
 * macro definitions later in this file, in order to satisfy XPG4.2
 * requirements.
 */

int addch(C:chtype)(C ch)
{   return waddch(stdscr, ch);    }
int addchnstr(C:chtype, N:int)(C* chstr, N n)
{   return waddchnstr(stdscr, chstr, n); }
int addchstr(C:chtype)(C* chstr)
{   return waddchstr(stdscr, str);    }
int addnstr(C:const char, N:int)(C* str, N n)
{   return waddnstr(stdscr, str, n);  }
int addstr(C:const char)(C* str)
{   return waddnstr(stdscr, str, -1); }
int attroff(N:chtype)(N attrs)
{   return wattroff(stdscr, attrs);   }
int attron(N:chtype)(N attrs)
{   return wattron(stdscr, attrs);    }
int attrset(N:chtype)(N attrs)
{   return wattrset(stdscr, attrs);   }
int attr_get(A:attr_t, S:short, V:void)(A* attrs, S* pair, V* opts)
{   return wattr_get(stdscr, attrs, pair, opts);  }
int attr_off(A:attr_t, V:void)(A attrs, V* opts)
{   return wattr_off(stdscr, attrs, opts);    }
int attr_on(A:attr_t, V:void)(A attrs, V* opts)
{   return wattr_on(stdscr, attrs, opts); }
int attr_set(A:attr_t, S:short, V:void)(A attrs, S pair, V* opts)
{   return wattr_set(stdscr, attrs, pair, opts);  }
int baudrate();
int beep();
int bkgd(C:chtype)(C ch)
{   return wbkgd(stdscr, ch); }
void bkgdset(C:chtype)(C ch)
{   return wbkgdset(stdscr, ch);  }
int border(C:chtype)(C ls, C rs, C ts, C bs, C tl, C tr, C bl, C br)
{   return wborder(stdscr, ls, rs, ts, bs, tl, tr, bl, br);   }
int box(W:WINDOW, C:chtype)(W* win, C verch, C horch)
{   return wborder(win, verch, verch, horch, horch, 0, 0, 0, 0);  }
//TODO is this needed?
int box(W:WINDOW, C:int)(W* win, C verch, C horch)
{   return wborder(win, verch, verch, horch, horch, 0, 0, 0, 0);  }
bool can_change_color();
int cbreak();
int chgat(N:int, A:attr_t, S:short, V:void)(N n, A attr, S color, V* opts)
{   return wchgat(stdscr, n, attr, color, opts);  }
int clear()()
{   return wclear(stdscr);    }
int clearok(WINDOW* win, bool bf);
int clrtobot()()
{   return wclrtobot(stdscr); }
int clrtoeol()()
{   return wclrtoeol(stdscr); }
int color_content(short color, short* r, short* g, short* b);
int color_set(N:short, V:void)(N color_pair_number, V* opts)
{   return wcolor_set(stdscr, color_pair_number, opts);   }
//TODO look at this, might be able to be rewritten using NCURSES_BITS
chtype COLOR_PAIR(N:int)(N n)
{   return cast(chtype)(n<<8);    }
int copywin(WINDOW* srcwin, WINDOW* dstwin, int sminrow,
     int smincol, int dminrow, int dmincol, int dmaxrow,
     int dmaxcol, int overlay);
int curs_set(int visibility);
int def_prog_mode();
int def_shell_mode();
int delay_output(int ms);
int delch()()
{   return wdelch(stdscr);    }
void delscreen(SCREEN* sp);
int delwin(WINDOW* win);
int deleteln()()
{   return winsdelln(stdscr, -1); }
WINDOW* derwin(WINDOW* orig, int nlines, int ncols, int begin_y, int begin_x);
int doupdate();
WINDOW* dupwin(WINDOW* win);
int echo();
int echochar(C:chtype)(C ch)
{   return wechochar(stdscr, ch); }
int erase()()
{   return werase(stdscr);    }
int endwin();
char erasechar();
void filter();
int flash();
int flushinp();
chtype getbkgd(W:WINDOW)(W* win)
{   return win.bkgd;  }
int getch()()
{   return wgetch(stdscr);    }
int getnstr(C:char, N:int)(C* str, N n)
{   return wgetnstr(stdscr, str, n);  }
int getstr(C:char)(C* str)
{   return wgetstr(stdscr, str);  }
WINDOW* getwin(FILE* filep);
int halfdelay(int tenths);
bool has_colors();
bool has_ic();
bool has_il();
int hline(C:chtype, N:int)(C ch, N n)
{   return whline(stdscr, ch, n); }
void idcok(WINDOW* win, bool bf);
int idlok(WINDOW* win, bool bf);
void immedok(WINDOW* win, bool bf);
chtype inch()()
{   return winch(stdscr); }
int inchnstr(C:chtype, N:int)(C* chstr, N n)
{   return winchnstr(stdscr, chstr, n);   }
int inchstr(C:chtype)(C* chstr)
{   return winchstr(stdscr, chstr);   }
WINDOW* initscr();
int init_color(short color, short r, short g, short b);
int init_pair(short pair, short f, short b);
int innstr(C:char, N:int)(C* str, N n)
{   return winnstr(stdscr, str, n);   }
int insch(CH:chtype)(CH ch)
{   return winsch(stdscr, ch);    }
int insdelln(N:int)(N n)
{   return winsdelln(stdscr, n);  }
int insertln()()
{   return winsdelln(stdscr, 1);  }
int insnstr(C:char, N:int)(C* str, N n)
{   return winsnstr(stdscr, str, n);  }
int insstr(C:char)(C* str)
{   return winsstr(stdscr, str);  }
int instr(C:char)(C* str)
{   return winstr(stdscr, str);   }
int intrflush(WINDOW* win, bool bf);
bool isendwin();
bool is_linetouched(WINDOW* win, int line);
bool is_wintouched(WINDOW* win);
char* keyname(int c);
int keypad(WINDOW* win, bool bf);
char killchar();
int leaveok(WINDOW* win, bool bf);
char* longname();
int meta(WINDOW* win, bool bf);
int move(N:int)(N y, N x)
{   return wmove(stdscr, y, x);   }
int mvaddch(N:int, C:chtype)(N y, N x, C ch)
{   return mvwaddch(stdscr, y, x, ch);    }
int mvaddch(N:int, C:char)(N y, N x, C ch)
{   return mvwaddch(stdscr, y, x, ch);    }
int mvaddchnstr(N:int, C:chtype)(N y, N x, C* chstr, N n)///ditto
{   return mvwaddchnstr(stdscr, y, x, chstr, n);  }
int mvaddchstr(N:int, C:chtype)(N y, N x, C* chstr)///ditto
{   return mvwaddchstr(stdscr, y, x, str);    }
int mvaddnstr(N:int, C:const char)(N y, N x, C* str, N n)
{   return mvwaddnstr(stdscr, y, x, str, n);  }
int mvaddstr(N:int, C:const char)(N y, N x, C* str)
{   return mvwaddstr(stdscr, y, x, str);  }
int mvchgat(N:int, A:attr_t, S:short, V:void)
  (N y, N x, N n, A attr, S color, V* opts)
{   return mvwchgat(stdscr, y, x, n, attr, color, opts);  }
int mvcur(int,int,int,int);
int mvdelch(N:int)(N y, N x)
{   return mvwdelch(stdscr, y, x);    }
int mvderwin(WINDOW* win, int par_y, int par_x);
int mvgetch(N:int)(N y, N x)
{   return mvwgetch(stdscr, y, x);    }
int mvgetnstr(N:int, C:char)(N y, N x, C* str, N n)
{   return mvwgetnstr(stdscr, y, x, str, n);  }
int mvgetstr(N:int, C:char)(N y, N x, C* str)
{   return mvwgetstr(stdscr, y, x, str);  }
int mvhline(N:int, C:chtype)(N y, N x, C ch, N n)
{   return mvwhline(stdscr, y, x, ch, n); }
chtype mvinch(N:int)(N y, N x)
{   return mvwinch(stdscr, y, x); }
int mvinchnstr(N:int, C:chtype)(N y, N x, C* chstr, N n)
{   return mvwinchnstr(stdscr, y, x, chstr, n);   }
int mvinchstr(N:int, C:chtype)(N y, N x, C* chstr)
{   return mvwinchstr(stdscr, y, x, chstr);   }
int mvinnstr(N:int, C:char)(N y, N x, C* str, N n)
{   return mvwinnstr(stdscr, y, x, str, n);   }
int mvinsch(N:int, CH:chtype)(N y, N x, CH ch)
{   return mvwinsch(stdscr, y, x, ch);    }
int mvinsnstr(N:int, C:char)(N y, N x, C* str, N n)
{   return mvwinsnstr(stdscr, y, x, str, n);  }
int mvinsstr(N:int, C:char)(N y, N x, C* str)
{   return mvwinsstr(stdscr, y, x, str);  }
int mvinstr(N:int, C:char)(N y, N x, C* str)
{   return mvwinstr(stdscr, y, x, str);   }
int mvprintw(int y, int x, const char* fmt, ...);
int mvscanw(int y, int x, char* fmt, ...);
int mvvline(N:int, C:chtype)(N y, N x, C ch, N n)
{   return mvwvline(stdscr, y, x, ch, n); }
int mvwaddch(W:WINDOW, N:int, C:chtype)(W* win, N y, N x, C ch)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return waddch(win, ch);
}
int mvwaddch(W:WINDOW, N:int, C:char)(W* win, N y, N x, C ch)
{   return mvwaddch(win, y, x, cast(chtype)ch);    }
int  mvwaddchnstr(W:WINDOW, N:int, C:chtype)
  (W* win,  N y, N x, C* chstr, N n)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return waddchnstr(win, chstr, n);
}
int mvwaddchstr(W:WINDOW, N:int, C:chtype)
  (W* win, N y, N x, C* chstr)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return waddchnstr(win, chstr, -1);
}
int mvwaddnstr(W:WINDOW, N:int, C:const char)(W* win, N y, N x, C* str, N n)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return waddnstr(win, str, n);
}
int mvwaddstr(W:WINDOW, N:int, C:const char)(W* win, N y, N x, C* str)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return waddnstr(win, str, -1);
}
int mvwchgat(W:WINDOW, N:int, A:attr_t, S:short, V:void)
  (W* win, N y, N x, N n, A attr, S color, V* opts)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return wchgat(win, n, attr, color, opts);
}
int mvwdelch(W:WINDOW, N:int)(W* win, N y, N x)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return wdelch(win);
}
int mvwgetch(W:WINDOW, N:int)(W* win, N y, N x)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return wgetch(win);
}
int mvwgetnstr(W:WINDOW, N:int, C:char)(W* win, N y, N x, C* str, N n)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return wgetnstr(win, str, n);
}
int mvwgetstr(W:WINDOW, N:int, C:char)(W* win, N y, N x, C* str)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return wgetstr(win, str);
}
int mvwhline(W:WINDOW, N:int, C:chtype)(W* win, N y, N x, C ch, N n)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return whline(win, ch, n);
}
int mvwin(WINDOW* win, int y, int x);
chtype mvwinch(W:WINDOW, N:int)(W* win, N y, N x)
{
  if(wmove(win, y, x) == ERR)
    return cast(chtype)ERR;
  return winch(win);
}
int mvwinchnstr(W:WINDOW, N:int, C:chtype)(W* win, N y, N x, C* chstr, N n)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return winchnstr(win, chstr, n);
}
int mvwinchstr(W:WINDOW, N:int, C:chtype)(W* win, N y, N x, C* chstr)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return winchstr(win, chstr);
}
int mvwinnstr(W:WINDOW, N:int, C:char)(W* win, N y, N x, C* str, N n)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return winnstr(win, str, n);
}
int mvwinsch(W:WINDOW, N:int, CH:chtype)(W* win, N y, N x, CH ch)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return winsch(win, ch);
}
int mvwinsnstr(W:WINDOW, N:int, C:char)(W* win, N y, N x, char* str, N n)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return winsnstr(win, str, n);
}
int mvwinsstr(W:WINDOW, N:int, C:char)(W* win, N y, N x, C* str)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return winsstr(win, str);
}
int mvwinstr(W:WINDOW, N:int, C:char)(W* win, N y, N x, C* str)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return winstr(win, str);
}
int mvwprintw(WINDOW* win, int y, int x, const char* fmt, ...);
int mvwscanw(WINDOW* win, int y, int x, char* fmt, ...);
int mvwvline(W:WINDOW, N:int, C:chtype)(W* win, N y, N x, C ch, N n)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return wvline(win, ch, n);
}
int napms(int ms);
WINDOW* newpad(int nlines, int ncols);
SCREEN* newterm(char* type, FILE* outfd, FILE* infd);
WINDOW* newwin(int nlines, int ncols, int begin_y, int begin_x);
int nl();
int nocbreak();
int nodelay(WINDOW *win, bool bf);
int noecho();
int nonl();
void noqiflush();
int noraw();
int notimeout(WINDOW *win, bool bf);
int overlay(WINDOW* srcwin, WINDOW* dstwin);
int overwrite(WINDOW* srcwin, WINDOW* dstwin);
int pair_content(short pair, short* f, short* b);
//TODO check this, .h returns an int. and accepts an int...
short PAIR_NUMBER(A:attr_t)(A attrs)
{   return (attrs & A_COLOR) >> 8;    }
int pechochar(WINDOW* pad, chtype ch);
int pnoutrefresh(WINDOW* pad, int pminrow, int pmincol,
     int sminrow, int smincol, int smaxrow, int smaxcol);
int prefresh(WINDOW* pad, int pminrow, int pmincol,
     int sminrow, int smincol, int smaxrow, int smaxcol);
int printw(const char* fmt, ...);
int putwin(WINDOW* win, FILE* filep);
void qiflush();
int raw();
int redrawwin(W:WINDOW)(W* win)
{   return wredrawln(win, 0, win.maxy+1); }
int refresh()()
{   return wrefresh(stdscr);  }
int resetty();
int reset_prog_mode();
int reset_shell_mode();
//TODO
__gshared int function(int line, int function(WINDOW* win, int cols) init) ripoffline;
int savetty();
int scanw(char* fmt, ...);
int scr_dump(char *filename);
int scr_init(char *filename);
int scrl(N:int)(N n)
{   return wscrl(stdscr, n);  }
int scroll(W:WINDOW)(W* win)
{   return wscrl(win, 1); }
int scrollok(WINDOW* win, bool bf);
int scr_restore(char *filename);
int scr_set(char *filename);
int setscrreg(N:int)(N top, N bot)
{   return wsetscrreg(stdscr, top, bot);  }
SCREEN* set_term(SCREEN* newscreen);
int slk_attroff(chtype attrs);
int slk_attr_off(A:attr_t, V:void)(A attrs, V* opts)
{
  if(opts == null)
    return ERR;
  return slk_attroff(a);
}
int slk_attron(chtype attrs);
int slk_attr_on(A:attr_t, V:void)(A attrs, V* opts)
{
  if(opts == null)
    return ERR;
  return slk_attron(a);
}
int slk_attrset(chtype attrs);
attr_t slk_attr();
int slk_attr_set(attr_t attrs, short color_pair_number, void* opts);
int slk_clear();
int slk_color(short color_pair_number);
int slk_init(int fmt);
char* slk_label(int labnum);
int slk_noutrefresh();
int slk_refresh();
int slk_restore();
int slk_set(int labnum, char* label, int fmt);
int slk_touch();
int standout()()
{   return wstandout(stdscr); }
int standend()()
{   return wstandend(stdscr); }
int start_color();
WINDOW* subpad(WINDOW* orig, int nlines, int ncols, int begin_y, int begin_x);
WINDOW* subwin(WINDOW* orig, int nlines, int ncols, int begin_y, int begin_x);
int syncok(WINDOW* win, bool bf);
chtype termattrs();
char* termname();
void timeout(N:int)(N delay)
{   return wtimeout(stdscr, delay);   }
int touchline(W:WINDOW, N:int)(W* win, N start, N count)
{   return wtouchln(win, start, count, 1);    }
int touchwin(W:WINDOW)(W* win)
{   return wtouchln(win, 0, getmaxy(win), 1); }
int typeahead(int fd);
int ungetch(int ch);
int untouchwin(W:WINDOW)(W* win)
{   return wtouchln(win, 0, getmaxy(win), 0); }
void use_env(bool f);
int vidattr(chtype c);
//TODO check this.
int vidputs(chtype, int function(int));
int vline(C:chtype, N:int)(C ch, N n)
{   return wvline(stdscr, ch, n); }
int vwprintw(WINDOW* win, const char* fmt, va_list varglist);
int vw_printw(W:WINDOW, C:const char, V:va_list)(W* win, C* fmt, V varglist)
{   return vwprintw(win, fmt, varglist);  }
int vw_scanw(W:WINDOW, C:char, V:va_list)(W* win, C* fmt, V varglist)
{   return vwscanw(win, fmt, varglist);   }
int vwscanw(WINDOW* win, char* fmt, va_list varglist);
int waddch(WINDOW* win, chtype ch);
int waddchnstr(WINDOW* win, chtype* chstr, int n);
int waddchstr(W:WINDOW, C:chtype)(W* win, C* chstr)
{   return waddchnstr(win, chstr, -1);    }
int waddnstr(WINDOW* win, const char* str, int n);
int waddstr(W:WINDOW, C:const char)(W* win, C* str)
{   return waddnstr(win, str, -1);    }
int wattron(W:WINDOW, N:chtype)(W* win, N attrs)
{   return wattr_on(win, cast(attr_t)attrs, null);    }
int wattroff(W:WINDOW, N:chtype)(W* win, N attrs)
{   return wattr_off(win, attrs, null);   }
int wattrset(W:WINDOW, N:chtype)(W* win, N attrs)
{
  if(win == null) return ERR;
  win.attrs = attrs;
  return OK;
}
int wattr_get(W:WINDOW, A:attr_t, S:short, V:void)
  (W* win, A* attrs, S* pair, V* opts)
{
  if(attrs == null || pair == null)
    return ERR;

  *attrs = win.attrs;
  *pair = PAIR_NUMBER(win.attrs);
  return OK;
}
int wattr_on(WINDOW* win, attr_t attrs, void* opts);
int wattr_off(WINDOW* win, attr_t attrs, void* opts);
int wattr_set(W:WINDOW, A:attr_t, S:short, V:void)
  (W* win, A attrs, S pair, V* opts)
{   return win.attrs = (attrs & ~A_COLOR) | COLOR_PAIR(pair); }
int wbkgd(WINDOW* win, chtype ch);
void wbkgdset(WINDOW* win, chtype ch);
int wborder(WINDOW* win, chtype ls, chtype rs,
  chtype ts, chtype bs, chtype tl, chtype tr,
  chtype bl, chtype br);
int wchgat(WINDOW* win, int n, attr_t attr, short color, void* opts);
int wclear(WINDOW* win);
int wclrtobot(WINDOW* win);
int wclrtoeol(WINDOW* win);
int wcolor_set(WINDOW* win, short color_pair_number, void* opts);
void wcursyncup(WINDOW* win);
int wdelch(WINDOW* win);
int wdeleteln(W:WINDOW)(W* win)
{   return winsdelln(win, -1);    }
int wechochar(WINDOW* win, chtype ch);
int werase(WINDOW* win);
int wgetch(WINDOW* win);
int wgetnstr(WINDOW* win, char* str, int n);
int wgetstr(W:WINDOW, C:char)(W* win, C* str)
{   return wgetnstr(win, str, -1);    }
int whline(WINDOW* win, chtype ch, int n);
chtype winch(WINDOW* win);
int winchnstr(WINDOW* win, chtype* chstr, int n);
int winchstr(W:WINDOW, C:chtype)(W* win, C* chstr)
{   return winchnstr(win, chstr, -1); }
int winnstr(WINDOW* win, char* str, int n);
int winsch(WINDOW* win, chtype ch);
int winsdelln(WINDOW* win, int n);
int winsertln(W:WINDOW)(W* win)
{   return winsdelln(win, 1); }
int winsnstr(WINDOW* win, char* str, int n);
int winsstr(W:WINDOW, C:char)(W* win, C* str)
{   return winsnstr(win, str, -1);    }
int winstr(W:WINDOW, C:char)(W* win, C* str)
{   return winnstr(win, str, -1); }
int wmove(WINDOW* win, int y, int x);
int wnoutrefresh(WINDOW* win);
int wprintw(WINDOW* win, const char* fmt, ...);
int wredrawln(WINDOW* win, int beg_line, int num_lines);
int wrefresh(WINDOW* win);
int wscanw(WINDOW* win, char* fmt, ...);
int wscrl(WINDOW *win, int n);
int wsetscrreg(WINDOW* win, int top, int bot);
int wstandout(W:WINDOW)(W* win)
{   return wattrset(win, A_STANDOUT); }
int wstandend(W:WINDOW)(W* win)
{   return wattrset(win, A_NORMAL);   }
void wsyncdown(WINDOW* win);
void wsyncup(WINDOW* win);
void wtimeout(WINDOW *win, int delay);
int wtouchln(WINDOW* win, int y, int n, int changed);
int wvline(WINDOW* win, chtype ch, int n);

/*
 * These are also declared in <ncursesw/term.h>:
 */
int tigetflag(char *);
int tigetnum(char *);
char* tigetstr (char *);
int putp (char *);

//#if NCURSES_TPARM_VARARGS | Set to 1 on my system...
char* tparm (char *, ...);
//endif
char* tiparm(const char*, ...);    /* special */


/*
 * These functions are not in X/Open, but we use them in macro definitions:
 */

int getattrs(U:WINDOW)(U win)
{   return win ? win.curx : ERR;    }
int getcurx(U:WINDOW*)(U win)
{   return win ? win.curx : ERR;    }
int getcury(U:WINDOW*)(U win)
{   return win ? win.cury : ERR;  }
int getbegx(U:WINDOW*)(U win)
{   return win ? win.begx : ERR;  }
int getbegy(U:WINDOW*)(U win)
{   return win ? win.begy : ERR;  }
int getmaxx(U:WINDOW*)(U win)
{   return win ? win.maxx : ERR;  }
int getmaxy(U:WINDOW*)(U win)
{   return win ? win.maxy : ERR;  }
int getparx(U:WINDOW*)(U win)
{   return win ? win.parx : ERR;  }
int getpary(U:WINDOW*)(U win)
{   return win ? win.pary : ERR;  }

/*
 * vid_attr() was implemented originally based on a draft of X/Open curses.
 */
 //TODO check...
int vid_attr(chtype a, ...)
{   return vidattr(a); }


/*
 * These functions are extensions - not in X/Open Curses.
 */
 //TODO Check
alias int function(WINDOW *, void *) NCURSES_WINDOW_CB;
alias int function(SCREEN *, void *) NCURSES_SCREEN_CB;

bool is_term_resized(int lines, int columns);
char* keybound(int keycode, int count);
char* curses_version();
int assume_default_colors(int fg, int bg);
int define_key(char* definition, int keycode);
int get_escdelay();
int key_defined(char* definition);
int keyok(int keycode, bool enable);
int resize_term(int lines, int columns);
int resizeterm(int lines, int columns);
//TODO check
int set_delay(int i);
//TODO check
int set_tabsize(int i);
int use_default_colors();
int use_extended_names(bool enable);
int use_legacy_coding(int i);
//TODO check, I might not have gotten the function pointer alias correct.
int use_screen(SCREEN* scr, NCURSES_SCREEN_CB, void* v);
int use_window(WINDOW* win, NCURSES_WINDOW_CB, void* v);
int wresize(WINDOW* win, int lines, int columns);
void nofilter();


/*
 * These extensions provide access to information stored in the WINDOW even
 * when NCURSES_OPAQUE is set:
 */
//TODO implement
//extern NCURSES_EXPORT(WINDOW *) wgetparent (const WINDOW *);    /* generated */
//extern NCURSES_EXPORT(bool) is_cleared (const WINDOW *);    /* generated */
//extern NCURSES_EXPORT(bool) is_idcok (const WINDOW *);      /* generated */
//extern NCURSES_EXPORT(bool) is_idlok (const WINDOW *);      /* generated */
//extern NCURSES_EXPORT(bool) is_immedok (const WINDOW *);    /* generated */
//extern NCURSES_EXPORT(bool) is_keypad (const WINDOW *);     /* generated */
//extern NCURSES_EXPORT(bool) is_leaveok (const WINDOW *);    /* generated */
//extern NCURSES_EXPORT(bool) is_nodelay (const WINDOW *);    /* generated */
//extern NCURSES_EXPORT(bool) is_notimeout (const WINDOW *);  /* generated */
//extern NCURSES_EXPORT(bool) is_pad (const WINDOW *);        /* generated */
//extern NCURSES_EXPORT(bool) is_scrollok (const WINDOW *);   /* generated */
//extern NCURSES_EXPORT(bool) is_subwin (const WINDOW *);     /* generated */
//extern NCURSES_EXPORT(bool) is_syncok (const WINDOW *);     /* generated */
//extern NCURSES_EXPORT(int) wgetscrreg (const WINDOW *, int *, int *); /* generated */

/*  A few macros..  */

void getyx(U:WINDOW*, T: int)(U win, ref T y, ref T x)
{
  y = getcury(win);
  x = getcurx(win);
}
void getparyx(U:WINDOW*, T: int)(U win, ref T y, ref T x)
{
  y = getpary(win);
  x = getparx(win);
}
void getmaxyx(U:WINDOW*, T: int)(U win, ref T y, ref T x)
{
  y = getmaxy(win);
  x = getmaxx(win);
}
void getbegyx(U:WINDOW*, T: int)(U win, ref T y, ref T x)
{
  y = getbegy(win);
  x = getbegx(win);
}



/*
 * Pseudo-character tokens outside ASCII range.  The curses wgetch() function
 * will return any given one of these only if the corresponding k- capability
 * is defined in your terminal's terminfo entry.
 *
 * Some keys (KEY_A1, etc) are arranged like this:
 *  a1     up    a3
 *  left   b2    right
 *  c1     down  c3
 *
 * A few key codes do not depend upon the terminfo entry.
 */

immutable enum :int
{
    KEY_CODE_YES  = 0x100,
    KEY_MIN       = 0x101,
    KEY_BREAK     = 0x101,
/*
 * These definitions were generated by /build/buildd/ncurses-5.7+20101128/include/MKkey_defs.sh /build/buildd/ncurses-5.7+20101128/include/Caps
 */
    KEY_DOWN      = 0x102,
    KEY_UP        = 0x103,
    KEY_LEFT      = 0x104,
    KEY_RIGHT     = 0x105,
    KEY_HOME      = 0x106,
    KEY_BACKSPACE = 0x107,
    KEY_F0        = 0x108,
    KEY_DL        = 0x148,
    KEY_IL        = 0x149,
    KEY_DC        = 0x14A,
    KEY_IC        = 0x14B,
    KEY_EIC       = 0x14C,
    KEY_CLEAR     = 0x14D,
    KEY_EOS       = 0x14E,
    KEY_EOL       = 0x14F,
    KEY_SF        = 0x150,
    KEY_SR        = 0x151,
    KEY_NPAGE     = 0x152,
    KEY_PPAGE     = 0x153,
    KEY_STAB      = 0x154,
    KEY_CTAB      = 0x155,
    KEY_CATAB     = 0x156,
    KEY_ENTER     = 0x157,
    KEY_SRESET    = 0x158,
    KEY_RESET     = 0x159,
    KEY_PRINT     = 0x15A,
    KEY_LL        = 0x15B,
    KEY_A1        = 0x15C,
    KEY_A3        = 0x15D,
    KEY_B2        = 0x15E,
    KEY_C1        = 0x15F,
    KEY_C3        = 0x160,
    KEY_BTAB      = 0x161,
    KEY_BEG       = 0x162,
    KEY_CANCEL    = 0x163,
    KEY_CLOSE     = 0x164,
    KEY_COMMAND   = 0x165,
    KEY_COPY      = 0x166,
    KEY_CREATE    = 0x167,
    KEY_END       = 0x168,
    KEY_EXIT      = 0x169,
    KEY_FIND      = 0x16A,
    KEY_HELP      = 0x16B,
    KEY_MARK      = 0x16C,
    KEY_MESSAGE   = 0x16D,
    KEY_MOVE      = 0x16E,
    KEY_NEXT      = 0x16F,
    KEY_OPEN      = 0x170,
    KEY_OPTIONS   = 0x171,
    KEY_PREVIOUS  = 0x172,
    KEY_REDO      = 0x173,
    KEY_REFERENCE = 0x174,
    KEY_REFRESH   = 0x175,
    KEY_REPLACE   = 0x176,
    KEY_RESTART   = 0x177,
    KEY_RESUME    = 0x178,
    KEY_SAVE      = 0x179,
    KEY_SBEG      = 0x17A,
    KEY_SCANCEL   = 0x17B,
    KEY_SCOMMAND  = 0x17C,
    KEY_SCOPY     = 0x17D,
    KEY_SCREATE   = 0x17E,
    KEY_SDC       = 0x17F,
    KEY_SDL       = 0x180,
    KEY_SELECT    = 0x181,
    KEY_SEND      = 0x182,
    KEY_SEOL      = 0x183,
    KEY_SEXIT     = 0x184,
    KEY_SFIND     = 0x185,
    KEY_SHELP     = 0x186,
    KEY_SHOME     = 0x187,
    KEY_SIC       = 0x188,
    KEY_SLEFT     = 0x189,
    KEY_SMESSAGE  = 0x18A,
    KEY_SMOVE     = 0x18B,
    KEY_SNEXT     = 0x18C,
    KEY_SOPTIONS  = 0x18D,
    KEY_SPREVIOUS = 0x18E,
    KEY_SPRINT    = 0x18F,
    KEY_SREDO     = 0x190,
    KEY_SREPLACE  = 0x191,
    KEY_SRIGHT    = 0x192,
    KEY_SRSUME    = 0x193,
    KEY_SSAVE     = 0x194,
    KEY_SSUSPEND  = 0x195,
    KEY_SUNDO     = 0x196,
    KEY_SUSPEND   = 0x197,
    KEY_UNDO      = 0x198,
    KEY_MOUSE     = 0x199,
    KEY_RESIZE    = 0x19A,
    KEY_EVENT     = 0x19B,
    KEY_MAX       = 0x1FF
}


/*
 * Function prototypes for wide-character operations.
 *
 * "generated" comments should include ":WIDEC" to make the corresponding
 * functions ifdef'd in lib_gen.c
 *
 * "implemented" comments do not need this marker.
 */
int add_wch(C:cchar_t)(C* wch)
{   return wadd_wch(stdscr, wch); }
int add_wchnstr(C:cchar_t, N:int)(C* wchstr, N n)
{   return wadd_wchnstr(stdscr, wchstr, n);   }
int add_wchstr(C:cchar_t)(C* wchstr)
{   return wadd_wchstr(stdscr, wchstr);   }
int addnwstr(WC:wchar_t, N:int)(WC* wstr, N n)
{   return waddnwstr(stdscr, wstr);   }
int addwstr(WC:wchar_t)(WC* wstr)
{   return waddwstr(stdscr, wstr);    }
int bkgrnd(C:cchar_t)(C* wch)
{   return wbkgrnd(stdscr, wch);  }
void bkgrndset(C:cchar_t)(C* wch )
{   wbkgrndset(stdscr, wch);  }
int border_set(C:cchar_t)
  (C* ls, C* rs, C* ts, C* bs, C* tl, C* tr, C* bl, C* br)
{   return wborder_set(stdscr, ls, rs, ts, bs, tl, tr, bl, br);   }
int box_set(W:WINDOW, C:cchar_t)(W* win, C* verch, C* horch)
{return wborder_set(win, verch, verch, horch, horch, null, null, null, null);  }
int echo_wchar(C:cchar_t)(C* wch )
{   return wecho_wchar(stdscr, wch);  }
int erasewchar(wchar_t* ch);
int get_wch(WN:wint_t)(WN* wch)
{   return wget_wch(stdscr, wch); }
int get_wstr(WN:wint_t)(WN* wstr)
{   return wget_wstr(stdscr, wstr);   }
int getbkgrnd(C:cchar_t)(C* wch)
{   return wgetbkgrnd(stdscr, wch);   }
int getcchar(cchar_t* wcval, wchar_t* wch, attr_t* attrs, short* color_pair, void* opts);
int getn_wstr(WN:wint_t, N:int)(WN* wstr, N n)
{   return wgetn_wstr(stdscr, wstr, n);   }
int hline_set(C:cchar_t, N:int)(C* wch, N n)
{   return whline_set(stdscr, wch, n);    }
int in_wch(CC:cchar_t)(CC* wcval)
{   return win_wch(stdscr, wcval);    }
int in_wchnstr(CC:cchar_t, N:int)(CC* wchstr, N n)
{   return win_wchnstr(stdscr, wchstr, n);    }
int in_wchstr(CC:cchar_t)(CC* wchstr)
{   return win_wchstr(stdscr, wchstr);    }
int innwstr(WC:wchar_t, N:int)(WC* str, N n)
{   return winnwstr(stdscr, str, n);  }
int ins_nwstr(WC:wchar_t, N:int)(WC* wstr, N n)
{   return wins_nwstr(stdscr, wstr, n);   }
int ins_wch(CC:cchar_t)(CC* wch)
{   return wins_wch(stdscr, wch); }
int ins_wstr(WC:wchar_t)(WC* wstr)
{   return wins_wstr(stdscr, wstr);   }
int inwstr(WC:wchar_t)(WC* str)
{   return winwstr(stdscr, str);  }
char* key_name(wchar_t w);
int killwchar(wchar_t* ch);
int mvadd_wch(N:int, C:cchar_t)(N y, N x, C* wch)
{   return mvwadd_wch(stdscr, y, x, wch); }
int mvadd_wchnstr(N:int,C:cchar_t)(N y, N x, C* wchstr, N n)
{   return mvwadd_wchnstr(stdscr, y, x, wchstr, n);   }
int mvadd_wchstr(N:int, C:cchar_t)(N y, N x, C* wchstr)
{   return mvwadd_wchstr(stdscr, y, x, wchstr);   }
int mvaddnwstr(N:int, WC:wchar_t)(N y, N x, WC* wstr, N n)
{   return mvwaddnwstr(stdscr, y, x, wstr, n);    }
int mvaddwstr(N:int, WC:wchar_t)(N y, N x, WC* wstr)
{   return mvwaddwstr(stdscr, y, x, wstr);    }
int mvget_wch(N:int, WN:wint_t)(N y, N x, WN* wch)
{   return mvwget_wch(stdscr, y, x, wch); }
int mvget_wstr(N:int, WN:wint_t)(N y, N x, WN* wstr)
{   return mvwget_wstr(stdscr, y, x, wstr);   }
int mvgetn_wstr(N:int, WN:wint_t)(N y, N x, WN* wstr, N n)
{   return mvwgetn_wstr(stdscr, y, x, wstr, n);   }
int mvhline_set(N:int, C:cchar_t)(N y, N x, C* wch, N n)
{   return mvwhline_set(stdscr, y, x, wch, n);    }
int mvin_wch(N:int, CC:cchar_t)(N y, N x, CC* wcval)
{   return mvwin_wch(stdscr, y, x, wcval);    }
int mvin_wchnstr(N:int, CC:cchar_t)(N y, N x, CC* wchstr, N n)
{   return mvwin_wchnstr(stdscr, y, x, wchstr, n);    }
int mvin_wchstr(N:int, CC:cchar_t)(N y, N x, CC* wchstr)
{   return mvwin_wchstr(stdscr, y, x, wchstr);    }
int mvinnwstr(N:int, WC:wchar_t)(N y, N x, WC* str, N n)
{   return mvwinnwstr(stdscr, y, x, str, n);  }
int mvins_nwstr(N:int, WC:wchar_t)(N y, N x, WC* wstr, N n)
{   return mvwins_nwstr(stdscr, y, x, wstr, n);   }
int mvins_wch(N:int, CC:cchar_t)(N y, N x, CC* wch)
{   return mvwins_wch(stdscr, y, x, wch); }
int mvins_wstr(N:int, WC:wchar_t)(N y, N x, WC* wstr)
{   return mvwins_wstr(stdscr, y, x, wstr);   }
int mvinwstr(N:int, WC:wchar_t)(N y, N x, WC* str)
{   return mvwinwstr(stdscr, y, x, str);  }
int mvvline_set(N:int, C:cchar_t)(N y, N x, C* wch, N n)
{   return mvwvline_set(stdscr, y, x, wch, n);    }
int mvwadd_wch(W:WINDOW, N:int, C:cchar_t)
      (W* win, N y, N x, C* wch)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return wadd_wch(win, wch);
}
int mvwadd_wchnstr(W:WINDOW, N:int, C:cchar_t)
  (W* win, N y, N x, C* wchstr, N n)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return wadd_wchnstr(win, wchstr, n);
}
int mvwadd_wchstr(W:WINDOW, N:int, C:cchar_t)
  (W* win, N y, N x, C* wchstr)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return wadd_wchstr(win, wchstr);
}
int mvwaddnwstr(W:WINDOW, N:int, WC:wchar_t)
  (W* win, N y, N x, WC* wstr, N n)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return waddnwstr(win, wstr, n);
}
int mvwaddwstr(W:WINDOW, N:int, WC:wchar_t)(W* win, N y, N x, WC* wstr)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return waddwstr(win, wstr);
}
int mvwget_wch(W:WINDOW, N:int, WN:wint_t)(W* win, N y, N x, WN* wch)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return wget_wch(win, wch);
}
int mvwget_wstr(W:WINDOW, N:int, WN:wint_t)(W* win, N y, N x, WN* wstr)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return wget_wstr(win, wstr);
}
int mvwgetn_wstr(W:WINDOW, N:int, WN:wint_t)
  (W* win, N y, N x, WN* wstr, N n)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return wgetn_wstr(win, wstr, n);
}
int mvwhline_set(W:WINDOW, N:int, C:cchar_t)
  (W* win, N y, N x, C* wch, N n)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return whline_set(win, wch, n);
}
int mvwin_wch(W:WINDOW, N:int, CC:cchar_t)(W* win, N y, N x, CC* wcval)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return win_wch(win, wcval);
}
int mvwin_wchnstr(W:WINDOW, N:int, CC:cchar_t)
  (W* win, N y, N x, CC* wchstr, N n)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return win_wchnstr(win, wchstr, n);
}
int mvwin_wchstr(W:WINDOW, N:int, CC:cchar_t)
  (W* win, N y, N x, CC* wchstr)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return win_wchstr(win, wchstr);
}
int mvwinnwstr(W:WINDOW, N:int, WC:wchar_t)(W* win, N y, N x, WC* str, N n)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return winnwstr(win, str, n);
}
int mvwins_nwstr(W:WINDOW, N:int, WC:wchar_t)
  (W* win, N y, N x, WC* wstr, N n)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return wins_nwstr(win, wstr, n);
}
int mvwins_wch(W:WINDOW, N:int, CC:cchar_t)(W* win, N y, N x, CC* wch)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return wins_wch(win, wch);
}
int mvwins_wstr(W:WINDOW, N:int, WC:wchar_t)(W* win, N y, N x, WC* wstr)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return wins_wstr(win, wstr);
}
int mvwinwstr(W:WINDOW, N:int, WC:wchar_t)(W* win, N y, N x, WC* str)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return winwstr(win, str);
}
int mvwvline_set(W:WINDOW, N:int, C:cchar_t)
  (W* win, N y, N x, C* wch, N n)
{
  if(wmove(win, y, x) == ERR)
    return ERR;
  return wvline_set(win, wch, n);
}
int pecho_wchar(WINDOW* pad, cchar_t *wch);
int setcchar(cchar_t *wcval, wchar_t* wch, attr_t attrs, short color_pair, void* opts );
//TODO check
int slk_wset(int one, const wchar_t* two, int three);    /* implemented */
attr_t term_attrs();
int unget_wch(wchar_t wch);

int vline_set(C:cchar_t, N:int)(C* wch, N n)
{
  return wvline_set(stdscr, wch, n);
}
int wadd_wch(WINDOW* win, cchar_t* wch);
int wadd_wchnstr(WINDOW* win, cchar_t* wchstr, int n);
int wadd_wchstr(W:WINDOW, C:cchar_t)(W* win, C* wchstr)
{   return wadd_wchnstr(win, wchstr, -1); }
int waddnwstr(WINDOW* win, wchar_t* wstr, int n);
int waddwstr(W:WINDOW, WC:wchar_t)(W* win, WC* wstr)
{   return waddnwstr(win, wstr, -1);  }
int wbkgrnd(WINDOW* win, cchar_t* wch);
void wbkgrndset(WINDOW* win, cchar_t* wch);
int wborder_set(
  WINDOW* win,
  cchar_t* ls, cchar_t* rs, cchar_t* ts, cchar_t* bs,
  cchar_t* tl, cchar_t* tr, cchar_t* bl, cchar_t* br);
int wecho_wchar(WINDOW* win, cchar_t* wch);
int wget_wch(WINDOW* win, wint_t* wch);
int wget_wstr(W:WINDOW, WN:wint_t)(W* win, WN* wstr)
{   return wgetn_wstr(win, wstr, -1); }
int wgetbkgrnd(W:WINDOW, C:cchar_t)(W* win, C* wch)
{
  *wch=win.bkgrnd;
  return OK;
}
int wgetn_wstr(WINDOW* win, wint_t* wstr, int n);
int whline_set(WINDOW* win, cchar_t* wch, int n);
int win_wch(WINDOW* win, cchar_t* wcval);
int win_wchnstr(WINDOW* win, cchar_t* wchstr, int n);
int win_wchstr(W:WINDOW, CC:cchar_t)(W* win, CC* wchstr)
{   return win_wchnstr(win, wchstr, -1);  }
int winnwstr(WINDOW* win, wchar_t* str, int n);
int wins_nwstr(WINDOW* win, wchar_t* wstr, int n);
int wins_wch(WINDOW* win, cchar_t* wch);
int wins_wstr(W:WINDOW, WC:wchar_t)(W* win, WC* wstr)
{   return wins_nwstr(win, wstr, -1); }
int winwstr(W:WINDOW, WC:wchar_t)(W* win, WC* str)
{   return winnwstr(win, str, -1);    }
char* wunctrl(cchar_t* c);
int wvline_set(WINDOW* win, cchar_t* wch, int n);


/* mouse interface */

/* mouse events */
immutable enum :mmask_t
{
    BUTTON1_RELEASED          = 0x1,
    BUTTON2_RELEASED          = 0x40,
    BUTTON3_RELEASED          = 0x1000,
    BUTTON4_RELEASED          = 0x40000,
    BUTTON1_PRESSED           = 0x2,
    BUTTON2_PRESSED           = 0x80,
    BUTTON3_PRESSED           = 0x2000,
    BUTTON4_PRESSED           = 0x80000,
    BUTTON1_CLICKED           = 0x4,
    BUTTON2_CLICKED           = 0x100,
    BUTTON3_CLICKED           = 0x4000,
    BUTTON4_CLICKED           = 0x100000,
    BUTTON1_DOUBLE_CLICKED    = 0x8,
    BUTTON2_DOUBLE_CLICKED    = 0x200,
    BUTTON3_DOUBLE_CLICKED    = 0x8000,
    BUTTON4_DOUBLE_CLICKED    = 0x200000,
    BUTTON1_TRIPLE_CLICKED    = 0x10,
    BUTTON2_TRIPLE_CLICKED    = 0x400,
    BUTTON3_TRIPLE_CLICKED    = 0x10000,
    BUTTON4_TRIPLE_CLICKED    = 0x400000,
    BUTTON_CTRL               = 0x1000000,
    BUTTON_SHIFT              = 0x2000000,
    BUTTON_ALT                = 0x4000000,
    REPORT_MOUSE_POSITION     = 0x8000000,
    ALL_MOUSE_EVENTS          = 0x7FFFFFF
}

/++ TODO
 + #define BUTTON1_RESERVED_EVENT  NCURSES_MOUSE_MASK(1, NCURSES_RESERVED_EVENT)
#define BUTTON2_RESERVED_EVENT  NCURSES_MOUSE_MASK(2, NCURSES_RESERVED_EVENT)
#define BUTTON3_RESERVED_EVENT  NCURSES_MOUSE_MASK(3, NCURSES_RESERVED_EVENT)
#define BUTTON4_RESERVED_EVENT  NCURSES_MOUSE_MASK(4, NCURSES_RESERVED_EVENT)

/* macros to extract single event-bits from masks */
//TODO
#define BUTTON_RELEASE(e, x)        ((e) & NCURSES_MOUSE_MASK(x, 001))
#define BUTTON_PRESS(e, x)      ((e) & NCURSES_MOUSE_MASK(x, 002))
#define BUTTON_CLICK(e, x)      ((e) & NCURSES_MOUSE_MASK(x, 004))
#define BUTTON_DOUBLE_CLICK(e, x)   ((e) & NCURSES_MOUSE_MASK(x, 010))
#define BUTTON_TRIPLE_CLICK(e, x)   ((e) & NCURSES_MOUSE_MASK(x, 020))
#define BUTTON_RESERVED_EVENT(e, x) ((e) & NCURSES_MOUSE_MASK(x, 040))
++/

struct MEVENT
{
  short id;
  int x,
      y,
      z;
  mmask_t bstate;
}

bool has_mouse();
int getmouse(MEVENT* event);
int ungetmouse(MEVENT* event);
mmask_t mousemask(mmask_t newmask, mmask_t* oldmask);
int mouseinterval(int erval);
int mcprint(char *data, int len);
int has_key(int ch);


void _tracef(char* format, ...);
void _tracedump(char* label, WINDOW* win);
char* _traceattr(attr_t attr);
char* _traceattr2(int buffer, chtype ch);
char* _nc_tracebits();
char* _tracechar(ubyte ch);
char* _tracechtype(chtype ch);
char* _tracechtype2(int buffer, chtype ch);
char* _tracemouse(MEVENT* event);
void trace(uint param);


/* trace masks */
immutable enum :uint
{
    TRACE_DISABLE  = 0x0000,
    TRACE_TIMES    = 0x0001,
    TRACE_TPUTS    = 0x0002,
    TRACE_UPDATE   = 0x0004,
    TRACE_MOVE     = 0x0008,
    TRACE_CHARPUT  = 0x0010,
    TRACE_ORDINARY = 0x001F,
    TRACE_CALLS    = 0x0020,
    TRACE_VIRTPUT  = 0x0040,
    TRACE_IEVENT   = 0x0080,
    TRACE_BITS     = 0x0100,
    TRACE_ICALLS   = 0x0200,
    TRACE_CCALLS   = 0x0400,
    TRACE_DATABASE = 0x0800,
    TRACE_ATTRS    = 0x1000,

    TRACE_SHIFT    = 13,
    TRACE_MAXIMUM  = ((1 << TRACE_SHIFT) - 1)
}

int KEY_F(N:int)(N n)
in
{
  assert (n>=0, "Invalid value for KEY_F(n)");
  assert (n<=63, "Invalid value for KEY_F(n)");
}
out (result)
{
  assert (result < KEY_DL, "Invalid value for KEY_F(n)");
}
body
{
  return KEY_F0 + n;
}

}//end extern (C)
