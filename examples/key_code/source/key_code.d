//Modified by: 1100110
import std.stdio : writefln;
import deimos.ncurses;

void main()
{
    int ch;

    initscr();
    cbreak();               //Line buffering disabled
    noecho();
    keypad(stdscr, true);

    ch = getch();

    endwin();
    writefln("The key pressed is: %d", ch);
}
