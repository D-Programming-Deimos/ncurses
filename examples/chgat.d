#!/usr/bin/rdmd -L-lncurses
import std.string:  toStringz;
import std.conv:    to;
import deimos.ncurses.ncurses;

void main()
{   
    initscr();          //Start curses mode
    scope(failure)  endwin();
    scope(exit)     endwin();

    start_color();      //Start color functionality

    init_pair(1, COLOR_CYAN, COLOR_BLACK);
    printw(toStringz("A Big string which i didn't care to type fully... "));
                      //type attr_t    
    mvchgat(0, 0, -1, A_BLINK.to!attr_t, 1.to!short, null.to!(void*));
    /*
     * First two parameters specify the position at which to start
     * Third parameter number of characters to update. -1 means till
     * end of line
     * Forth parameter is the normal attribute you wanted to give
     * to the charcter
     * Fifth is the color index. It is the index given during init_pair()
     * use 0 if you didn't want color
     * Sixth one is always NULL
     */
    refresh();
    getch();
}
