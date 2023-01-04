import std.string : toStringz;
import deimos.curses;

void main()
{
    initscr();
    scope (exit)
        endwin();
    scope (failure)
        endwin();
    // Please note: you might want to maximize your terminal before you try to
    // run this.  It does not check the size or enable scrolling.
    // In other word, if your terminal is <= 23 by 79, it will do weird things.
    // The spaces are for readability on the screen when you run the program.

    printw(toStringz("Upper left corner           "));
    addch(ACS_ULCORNER());
    printw("\n");

    printw(toStringz("Lower left corner           "));
    addch(ACS_LLCORNER());
    printw("\n");

    printw(toStringz("Lower right corner          "));
    addch(ACS_LRCORNER());
    printw("\n");

    printw(toStringz("Tee pointing right          "));
    addch(ACS_LTEE());
    printw("\n");

    printw(toStringz("Tee pointing left           "));
    addch(ACS_RTEE());
    printw("\n");

    printw(toStringz("Tee pointing up             "));
    addch(ACS_BTEE());
    printw("\n");

    printw(toStringz("Tee pointing down           "));
    addch(ACS_TTEE());
    printw("\n");

    printw(toStringz("Horizontal line             "));
    addch(ACS_HLINE());
    printw("\n");

    printw(toStringz("Vertical line               "));
    addch(ACS_VLINE());
    printw("\n");

    printw(toStringz("Large Plus or cross over    "));
    addch(ACS_PLUS());
    printw("\n");

    printw(toStringz("Scan Line 1                 "));
    addch(ACS_S1());
    printw("\n");

    printw(toStringz("Scan Line 3                 "));
    addch(ACS_S3());
    printw("\n");

    printw(toStringz("Scan Line 7                 "));
    addch(ACS_S7());
    printw("\n");

    printw(toStringz("Scan Line 9                 "));
    addch(ACS_S9());
    printw("\n");

    printw(toStringz("Diamond                     "));
    addch(ACS_DIAMOND());
    printw("\n");

    printw(toStringz("Checker board (stipple)     "));
    addch(ACS_CKBOARD());
    printw("\n");

    printw(toStringz("Degree Symbol               "));
    addch(ACS_DEGREE());
    printw("\n");

    printw(toStringz("Plus/Minus Symbol           "));
    addch(ACS_PLMINUS());
    printw("\n");

    printw(toStringz("Bullet                      "));
    addch(ACS_BULLET());
    printw("\n");

    printw(toStringz("Arrow Pointing Left         "));
    addch(ACS_LARROW());
    printw("\n");

    printw(toStringz("Arrow Pointing Right        "));
    addch(ACS_RARROW());
    printw("\n");

    printw(toStringz("Arrow Pointing Down         "));
    addch(ACS_DARROW());
    printw("\n");

    printw(toStringz("Arrow Pointing Up           "));
    addch(ACS_UARROW());
    printw("\n");

    printw(toStringz("Board of squares            "));
    addch(ACS_BOARD());
    printw("\n");

    printw(toStringz("Lantern Symbol              "));
    addch(ACS_LANTERN());
    printw("\n");

    printw(toStringz("Solid Square Block          "));
    addch(ACS_BLOCK());
    printw("\n");

    printw(toStringz("Less/Equal sign             "));
    addch(ACS_LEQUAL());
    printw("\n");

    printw(toStringz("Greater/Equal sign          "));
    addch(ACS_GEQUAL());
    printw("\n");

    printw(toStringz("Pi                          "));
    addch(ACS_PI());
    printw("\n");

    printw(toStringz("Not equal                   "));
    addch(ACS_NEQUAL());
    printw("\n");

    printw(toStringz("UK pound sign               "));
    addch(ACS_STERLING());
    printw("\n");

    refresh();
    getch();
}
