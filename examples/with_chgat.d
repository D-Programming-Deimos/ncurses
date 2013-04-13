import std.string: toStringz;
import deimos.ncurses.ncurses;

void main()
{   initscr();          //Start curses mode
    start_color();      //Start color functionality

    init_pair(1, COLOR_CYAN, COLOR_BLACK);
    printw(toStringz("A Big string which i didn't care to type fully... "));
    mvchgat(0, 0, -1, cast(attr_t)A_BLINK, cast(short)1, cast(void*)null);
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
    endwin();           //End curses mode
}
