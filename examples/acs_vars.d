//regretfully modified by: 1100110

import std.string: toStringz;
import ncurses;

void main()
{
    initscr();

    //Please note: you might want to maximize your terminal before you try to
    //run this.  It does not check the size or enable scrolling.
    //That is left as an exersize for the reader.
    //Plus I'm lazy and I still have to port the rest of the tutorials.. ;)
    //The spaces are for readability on the screen when you run the program.

    printw(toStringz("Upper left corner           "));
    addch(acs_map[ACS.ULCORNER]);
    printw("\n");

    printw(toStringz("Lower left corner           "));
    addch(acs_map[ACS.LLCORNER]);
    printw("\n");

    printw(toStringz("Lower right corner          "));
    addch(acs_map[ACS.LRCORNER]);
    printw("\n");

    printw(toStringz("Tee pointing right          "));
    addch(acs_map[ACS.LTEE]);
    printw("\n");

    printw(toStringz("Tee pointing left           "));
    addch(acs_map[ACS.RTEE]);
    printw("\n");

    printw(toStringz("Tee pointing up             "));
    addch(acs_map[ACS.BTEE]);
    printw("\n");

    printw(toStringz("Tee pointing down           "));
    addch(acs_map[ACS.TTEE]);
    printw("\n");

    printw(toStringz("Horizontal line             "));
    addch(acs_map[ACS.HLINE]);
    printw("\n");

    printw(toStringz("Vertical line               "));
    addch(acs_map[ACS.VLINE]);
    printw("\n");

    printw(toStringz("Large Plus or cross over    "));
    addch(acs_map[ACS.PLUS]);
    printw("\n");

    printw(toStringz("Scan Line 1                 "));
    addch(acs_map[ACS.S1]);
    printw("\n");

    printw(toStringz("Scan Line 3                 "));
    addch(acs_map[ACS.S3]);
    printw("\n");

    printw(toStringz("Scan Line 7                 "));
    addch(acs_map[ACS.S7]);
    printw("\n");

    printw(toStringz("Scan Line 9                 "));
    addch(acs_map[ACS.S9]);
    printw("\n");

    printw(toStringz("Diamond                     "));
    addch(acs_map[ACS.DIAMOND]);
    printw("\n");

    printw(toStringz("Checker board (stipple)     "));
    addch(acs_map[ACS.CKBOARD]);
    printw("\n");

    printw(toStringz("Degree Symbol               "));
    addch(acs_map[ACS.DEGREE]);
    printw("\n");

    printw(toStringz("Plus/Minus Symbol           "));
    addch(acs_map[ACS.PLMINUS]);
    printw("\n");

    printw(toStringz("Bullet                      "));
    addch(acs_map[ACS.BULLET]);
    printw("\n");

    printw(toStringz("Arrow Pointing Left         "));
    addch(acs_map[ACS.LARROW]);
    printw("\n");

    printw(toStringz("Arrow Pointing Right        "));
    addch(acs_map[ACS.RARROW]);
    printw("\n");

    printw(toStringz("Arrow Pointing Down         "));
    addch(acs_map[ACS.DARROW]);
    printw("\n");

    printw(toStringz("Arrow Pointing Up           "));
    addch(acs_map[ACS.UARROW]);
    printw("\n");

    printw(toStringz("Board of squares            "));
    addch(acs_map[ACS.BOARD]);
    printw("\n");

    printw(toStringz("Lantern Symbol              "));
    addch(acs_map[ACS.LANTERN]);
    printw("\n");

    printw(toStringz("Solid Square Block          "));
    addch(acs_map[ACS.BLOCK]);
    printw("\n");

    printw(toStringz("Less/Equal sign             "));
    addch(acs_map[ACS.LEQUAL]);
    printw("\n");

    printw(toStringz("Greater/Equal sign          "));
    addch(acs_map[ACS.GEQUAL]);
    printw("\n");

    printw(toStringz("Pi                          "));
    addch(acs_map[ACS.PI]);
    printw("\n");

    printw(toStringz("Not equal                   "));
    addch(acs_map[ACS.NEQUAL]);
    printw("\n");

    printw(toStringz("UK pound sign               "));
    addch(acs_map[ACS.STERLING]);
    printw("\n");

    refresh();
    getch();
    endwin();
}
