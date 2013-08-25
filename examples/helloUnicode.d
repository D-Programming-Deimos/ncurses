#!/usr/bin/rdmd -L-lncursesw
/**  hello_unicode.d
 *
 * This is a demonstration of Unicode output with ncurses in D.
 * The functionality of this code is otherwise identical to hello_world.d
 *
 * Requirements for Unicode in ncurses:
 *  - You need to link against ncursesw instead of ncurses.  If you don't have ncursesw, rebuild
 *    ncurses with --enable-widec (and file a bug with your distro where applicable).
 *  - You need to be using a Unicode locale. If your $LANG looks something like `en_US.utf8`,
 *    then you're in good shape.  Keep in mind that users don't like when you force a locale; do
 *    it only if you think it's really necessary.
 *
 * Modified by: Wyatt
 */
import std.string:  toStringz;
import std.c.locale;    // Need setlocale()
import deimos.ncurses.ncurses;

void main()
{
    setlocale(LC_CTYPE,""); // You need to set the empty locale to use upper-plane glyphs
                            // This sets the locale based on local variables. On most Unix-
                            // like systems, you can use the `locale` command to show the 
                            // current settings for your environment.

    auto hello = toStringz("日本語からの「Hello World!」");

    initscr();              //initialize the screen
    printw(hello);          //prints the char[] hello to the screen
    refresh();              //actually does the writing to the physical screen
    getch();                //gets a single character from the screen.
    endwin();               //Routine to call before exiting, or leaving curses mode temporarily
}
