// simple_spectrum: Sample of 256-colour ncurses output in D.
// Modified by: Wyatt

import deimos.ncurses;
import std.stdio : writeln;
import std.conv : to;

// Extended colour support was added in ncurses 5.5 for the wncurses
// library.  wncurses has generally been shipped by default in Linux
// distros for roughly the last decade as of this writing (often as the
// only version installed); if this doesn't work, check that your TERM
// is compatible with 256-colour modes, that your terminal emulator
// supports it, and that your copy of ncurses is built with
// --enable-ext-colors.  If the latter is false, you may wish to file a
// bug with your distro.

int main()
{
    scope (failure)
        endwin;
    scope (exit)
        endwin;
    initscr();
    if (has_colors() == false)
    {
        endwin();
        writeln("Your terminal does not support color...");
        return 1;           //ends the program
    }
    start_color();
    foreach (ushort i; 0 .. 256)
    {                       // Define all the colours with the default palette
        init_pair(i, 0, i); // We're only setting the background here;
    }                       // The space is rendered as nothing.

    auto w = COLS / 9; // Let's just fill all the horizontal space

    // Basic colours
    foreach (ushort i; 0 .. 16)
    {
        attron(COLOR_PAIR(i));
        mvwhline(stdscr, cast(int)(i % 8), w * (i / 8), to!chtype(' '), w);
        attroff(COLOR_PAIR(i));
    }

    // 6x6x6 cubemap
    foreach (ushort i; 16 .. 232)
    {
        attron(COLOR_PAIR(i));
        mvwhline(stdscr, cast(int)((i - 16) % 36), (2 * w + w * ((i - 16) / 36)),
            to!chtype(' '), w);
        attroff(COLOR_PAIR(i));
    }

    // Greyscale
    foreach (ushort i; 232 .. 256)
    {
        attron(COLOR_PAIR(i));
        mvwhline(stdscr, cast(int)(i - 232), (8 * w), to!chtype(' '), w);
        attroff(COLOR_PAIR(i));
    }

    wmove(stdscr, LINES - 1, COLS - 1); // Moving this out of the way
    getch();

    return 0;
}
