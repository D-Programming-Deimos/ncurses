//This does NOT loop properly.
import deimos.ncurses;
import std.conv : to;

enum WIDTH = 30;
enum HEIGHT = 10;

int startx = 0;
int starty = 0;

immutable choices = ["Choice 1", "Choice 2", "Choice 3", "Choice 4", "Exit"];

int main()
{
    scope (failure)
        endwin();
    scope (exit)
        endwin();

    WINDOW* menu_win;
    int highlight = 1;
    int choice = 0;
    int c;

    initscr();
    clear();
    noecho();
    cbreak(); /* Line buffering disabled. pass on everything */
    startx = (80 - WIDTH) / 2;
    starty = (24 - HEIGHT) / 2;

    menu_win = newwin(HEIGHT, WIDTH, starty, startx);
    keypad(menu_win, true);
    mvprintw(0, 0, "Use arrow keys to go up and down, Press enter to select a choice");
    refresh();
    print_menu(menu_win, highlight);
    while (1)
    {
        c = wgetch(menu_win);
        switch (c)
        {
        case KEY_UP:
            if (highlight == 1)
                highlight = choices.length.to!int;
            else
                --highlight;
            break;
        case KEY_DOWN:
            if (highlight == choices.length)
                highlight = 1;
            else
                ++highlight;
            break;
        case 10:
            choice = highlight;
            break;
        default:
            mvprintw(24, 0,
                "Character pressed is = %3d Hopefully it can be printed as '%c'", c,
                c);
            refresh();
            break;
        }
        print_menu(menu_win, highlight);
        if (choice != 0) /* User did a choice come out of the infinite loop */
            break;
    }
    mvprintw(23, 0, "You chose choice %d with choice string %s\n", choice,
        (choices[choice - 1] ~ '\0').ptr);
    clrtoeol();
    getch();
    refresh();
    return 0;
}

void print_menu(WINDOW* menu_win, int highlight)
{
    int x, y, i;

    x = 2;
    y = 2;
    box(menu_win, 0, 0);
    for (i = 0; i < choices.length; ++i)
    {
        if (highlight == i + 1) /* High light the present choice */
        {
            wattron(menu_win, A_REVERSE);
            mvwprintw(menu_win, y, x, "%s", (choices[i] ~ '\0').ptr);
            wattroff(menu_win, A_REVERSE);
        }
        else
            mvwprintw(menu_win, y, x, "%s", (choices[i] ~ '\0').ptr);
        ++y;
    }
    wrefresh(menu_win);
}
