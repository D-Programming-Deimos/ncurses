/**  hello_unicode.d
 *
 * This is a demonstration of Unicode output with ncurses in D.
 *
 * The functionality of this code is otherwise identical to hello_world.d
 *
 * Modified by: Wyatt
 */
import std.string: toStringz;
import std.c.locale; // Need setlocale()
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
