//Modified by: 1100110

import std.conv : to;
import std.string;
import deimos.ncurses;

void main()
{
    immutable mesg = "Just a string...";
    int row, col;
    initscr();

    scope (failure)
        endwin();
    scope (exit)
        endwin();

    getmaxyx(stdscr, row, col);

    // print the message at the center of the screen
    mvprintw(row / 2, ((col - (mesg.length - 1)) / 2).to!int, "%s", toStringz(mesg));
    // Did you notice? there is a '%s' not toStringified.

    auto rowcol = "This screen has %d rows and %d columns\n".toStringz;
    mvprintw(row - 2, 0, rowcol, row + 1, col + 1);

    printw(
        toStringz("Try resizing your window(if possible) and then run this program again"));
    refresh();

    getch();
}
