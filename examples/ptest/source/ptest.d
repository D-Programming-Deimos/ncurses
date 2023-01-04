import core.stdc.stdlib : exit;
import std.conv : to;
import std.string : toStringz;

import deimos.ncurses;
import deimos.panel;

string[] mod = ["test ", "TEST ", "(**) ", "*()* ", "<--> ", "LAST "];

void pflush()
{
    update_panels();
    doupdate();
}

void backfill()
{
    erase();

    foreach (immutable y; 0 .. LINES - 1)
        foreach (immutable x; 0 .. COLS)
            printw("%d", (y + x) % 10);
}

void wait_a_while(int msec)
{
    if (msec != 1)
        timeout(msec);

    int c = getch();

    if (c == 'q')
    {
        endwin();
        exit(1);
    }
}

void saywhat(immutable string text)
{
    mvprintw(LINES - 1, 0, "%-30.30s", toStringz(text));
}

/* mkpanel - alloc a win and panel and associate them */

PANEL* mkpanel(int rows, int cols, int tly, int tlx)
{
    WINDOW* win = newwin(rows, cols, tly, tlx);
    PANEL* pan;

    if (win)
    {
        pan = new_panel(win);

        if (!pan)
            delwin(win);
    }

    return pan;
}

void rmpanel(PANEL* pan)
{
    WINDOW* win = pan.win;

    del_panel(pan);
    delwin(win);
}

void fill_panel(PANEL* pan)
{
    char num = *cast(char*)(pan.user + 1);
    int maxy, maxx;

    box(pan.win, 0, 0);
    mvwprintw(pan.win, 1, 1, "-pan%c-", num);
    getmaxyx(pan.win, maxy, maxx);

    foreach (immutable y; 2 .. maxy)
        foreach (immutable x; 1 .. maxx)
            mvwaddch(pan.win, y, x, num);
}

int main(string[] args)
{
    PANEL* p1, p2, p3, p4, p5;
    WINDOW* w4, w5;

    int nap_msec = 1;

    if (args.length > 1 && to!int(args[1]))
        nap_msec = to!int(args[1]);

    initscr();
    curs_set(false);
    backfill();

    foreach (immutable y; 0 .. 5)
    {
        p1 = mkpanel(10, 10, 0, 0);
        set_panel_userptr(p1, toStringz("p1"));

        p2 = mkpanel(14, 14, 5, 5);
        set_panel_userptr(p2, toStringz("p2"));

        p3 = mkpanel(6, 8, 12, 12);
        set_panel_userptr(p3, toStringz("p3"));

        p4 = mkpanel(10, 10, 10, 30);
        w4 = panel_window(p4);
        set_panel_userptr(p4, toStringz("p4"));

        p5 = mkpanel(10, 10, 13, 37);
        w5 = panel_window(p5);
        set_panel_userptr(p5, toStringz("p5"));

        fill_panel(p1);
        fill_panel(p2);
        fill_panel(p3);
        fill_panel(p4);
        fill_panel(p5);
        hide_panel(p4);
        hide_panel(p5);
        pflush();
        wait_a_while(nap_msec);

        saywhat("hide 3, show 1, show 2, show 4, show 5;");
        move_panel(p1, 0, 0);
        hide_panel(p3);
        show_panel(p1);
        show_panel(p2);
        show_panel(p4);
        show_panel(p5);
        pflush();
        wait_a_while(nap_msec);

        saywhat("show 1;");
        show_panel(p1);
        pflush();
        wait_a_while(nap_msec);

        saywhat("show 2;");
        show_panel(p2);
        pflush();
        wait_a_while(nap_msec);

        saywhat("move 2;");
        move_panel(p2, 10, 10);
        pflush();
        wait_a_while(nap_msec);

        saywhat("show 3;");
        show_panel(p3);
        pflush();
        wait_a_while(nap_msec);

        saywhat("move 3;");
        move_panel(p3, 5, 5);
        pflush();
        wait_a_while(nap_msec);

        saywhat("bottom 3;");
        bottom_panel(p3);
        pflush();
        wait_a_while(nap_msec);

        saywhat("show 4;");
        show_panel(p4);
        pflush();
        wait_a_while(nap_msec);

        saywhat("show 5;");
        show_panel(p5);
        pflush();
        wait_a_while(nap_msec);

        saywhat("top 3;");
        top_panel(p3);
        pflush();
        wait_a_while(nap_msec);

        saywhat("top 1;");
        top_panel(p1);
        pflush();
        wait_a_while(nap_msec);

        saywhat("top 2;");
        top_panel(p2);
        pflush();
        wait_a_while(nap_msec);

        saywhat("top 3;");
        top_panel(p3);
        pflush();
        wait_a_while(nap_msec);

        saywhat("top 4;");
        top_panel(p4);
        pflush();
        wait_a_while(nap_msec);

        foreach (immutable itmp; 0 .. 6)
        {
            saywhat("move 4;");
            mvwaddstr(w4, 3, 1, toStringz(mod[itmp]));
            move_panel(p4, 4, itmp * 10);
            mvwaddstr(w5, 4, 1, toStringz(mod[itmp]));
            pflush();
            wait_a_while(nap_msec);

            saywhat("move 5;");
            mvwaddstr(w4, 4, 1, toStringz(mod[itmp]));
            move_panel(p5, 7, itmp * 10 + 6);
            mvwaddstr(w5, 3, 1, toStringz(mod[itmp]));
            pflush();
            wait_a_while(nap_msec);
        }

        saywhat("move 4;");
        move_panel(p4, 4, 60);
        pflush();
        wait_a_while(nap_msec);

        saywhat("top 5;");
        top_panel(p5);
        pflush();
        wait_a_while(nap_msec);

        saywhat("top 2;");
        top_panel(p2);
        pflush();
        wait_a_while(nap_msec);

        saywhat("top 1;");
        top_panel(p1);
        pflush();
        wait_a_while(nap_msec);

        saywhat("delete 2;");
        rmpanel(p2);
        pflush();
        wait_a_while(nap_msec);

        saywhat("hide 3;");
        hide_panel(p3);
        pflush();
        wait_a_while(nap_msec);

        saywhat("delete 1;");
        rmpanel(p1);
        pflush();
        wait_a_while(nap_msec);

        saywhat("delete 4; ");
        rmpanel(p4);
        pflush();
        wait_a_while(nap_msec);

        saywhat("delete 5; ");
        rmpanel(p5);
        pflush();
        wait_a_while(nap_msec);

        if (nap_msec == 1)
            break;

        nap_msec = 100L;
    }

    endwin();

    return 0;
} /* end of main */
