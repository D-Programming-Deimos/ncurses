//Modified by: 1100110

import std.stdio: writefln;
import ncurses;


void main()
{
    //I'm going to assume that you've played with
    //a bunch of the other tutorials by now...
    int ch;

    initscr();
    cbreak();               //Line buffering disabled
    noecho();
    keypad(stdscr, true);

    ch = getch();
    endwin();
    writefln("The key pressed is: %d", ch);
}
