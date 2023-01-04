import std.conv : to;
import deimos.menu;

enum CTRLD = 4;
immutable char[][] choices = [  "Choice 1",
                                "Choice 2",
                                "Choice 3",
                                "Choice 4",
                                "Exit"  ];

void main()
{
    ITEM*[] my_items;
    int c;
    MENU* my_menu;
    size_t n_choices;
    ITEM* cur_item;

    initscr();
    scope (exit)
        endwin();
    cbreak();
    noecho();
    keypad(stdscr, true);

    n_choices = choices.length;
    my_items.length = n_choices + 1;

    foreach (i; 0 .. n_choices)
        my_items[i] = new_item((choices[i] ~ '\0').ptr, (choices[i] ~ '\0').ptr);

    my_items[n_choices] = null;

    my_menu = new_menu(my_items.ptr);
    mvprintw(LINES - 2, 0, "F1 to Exit");
    post_menu(my_menu);
    refresh();

    while ((c = getch()) != KEY_F(1))
    {
        switch (c)
        {
        case KEY_DOWN:
            menu_driver(my_menu, REQ_DOWN_ITEM);
            break;
        case KEY_UP:
            menu_driver(my_menu, REQ_UP_ITEM);
            break;
        default:
            break;
        }
    }

    free_item(my_items[0]);
    free_item(my_items[1]);
    free_menu(my_menu);
}
