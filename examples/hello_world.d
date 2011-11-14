/**  hello_world.d
 *
 * I'm assuming that you are starting here, so I've included
 * lots of info.  These build, so I won't explain everything over and over.
 *
 * You will either need to use the makefile (now fixed)
 * or fix the import path manually.
 *
 * Also see http://d-programming-language.org/arrays.html for more info
 * on strings and char[]s
 *
 * Modified by: 1100110
 */
import std.string: toStringz;   //I don't need anything but toStringz()
import ncurses;         //Your inport path might(will) be different

void main()
{   //toStringz returns immutable char*   Which is what most of these
    //functions expect.  I had to modify things a bit to get that to
    //work as nicely as it does.
    //D string d = "stuff" will never work with these functions.
    //they expect char*  see below.
    auto hello = toStringz("Hello ncurses World!\nPress any key to continue...");

    /* D char[]s are not 0 terminated, so you'll probably want to do that manually
     * with hello ~= '\0';
     * char[] hello = ['h','e','l','l','o',' ','w','o','r','l','d','!'];
     * hello ~= '\0';
     * Or use toStringz() like the example above. just make sure there are no
     * embedded 0's in the string already.
     */

    initscr();              //initialize the screen
    printw(hello);          //prints the char[] hello to the screen
    refresh();              //actually does the writing to the physical screen
    getch();                //gets a single character from the screen.
                            //here it is just used to hold the terminal open.
                            //remove it and see what happens.
    endwin();               //Routine to call before exiting, or leaving curses mode temporarily
    //failure to endwin() seems to clear all terminal history
    //as well as other bad things.  just endwin().
    //Your terminal might be left in an unusable state if you don't.
    //Mine certainly was.
}
