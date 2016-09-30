//Modified by: 1100110
import std.conv:        to;
import std.stdio:       writeln;
import std.string:      toStringz;
import deimos.ncurses.ncurses;


int main() {
    initscr();
    scope(failure)  endwin();
    scope(exit)     endwin();


    if(has_colors() == false) {
        endwin();
        writeln("Your terminal does not support color... Goodbye");
        return 1;
    }
    start_color();

    init_pair(1, COLOR_RED, COLOR_BLACK);

    attron(COLOR_PAIR(1));
    print_in_middle(stdscr,  "Voila !!! In color...  =)", LINES/2, 0, 0,);
    attroff(COLOR_PAIR(1));

    getch();

    return 0;
}


void print_in_middle(WINDOW *win, string str, int starty = LINES/2, int startx=0, int width=0)
{
    int length, x, y;

    if(win == null)
        win = stdscr;

    getyx(win, y, x);
    if(startx != 0)
        x = startx;

    if(starty != 0)
        y = starty;

    if(width == 0)
        width = 80;

    //int already takes the floor, we can change temp to int.
    float temp = (width - str.length)/ 2;
    x = startx + temp.to!int;

    mvwprintw(win, y, x, "%s", toStringz(str));

    refresh();
}

