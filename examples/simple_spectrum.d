//Modified by: Wyatt

import std.stdio: writeln;
import std.conv;
import deimos.ncurses.ncurses;

int main()
{
    initscr();                              //Start curses mode
    if(has_colors() == false)
    {
        endwin();
        writeln("Your terminal does not support color...");
        return 1;                           //ends the program
    }
    start_color();                          // Start color
    foreach(ushort i; 0 .. 256){ // Define all the colours with the default palette
	init_pair(i, 0, i);      // We're only setting the background here;
    }                            // The space is rendered as nothing.
    auto w = COLS/9; // Let's just fill all the horizontal space
    foreach(ushort i; 0 .. 16){
	attron(COLOR_PAIR(i));
	mvwhline(stdscr, cast(int)(i%8),w*(i/8),to!size_t(' '),w);//chtype is a size_t by spec.
	attroff(COLOR_PAIR(i));
    }
    //foreach(ushort i; 8 .. 16){
	//attron(COLOR_PAIR(i));
	//mvwhline(stdscr, cast(int)(i-8),5,to!size_t(' '),5);
	//attroff(COLOR_PAIR(i));
    //}
    foreach(ushort i; 16 .. 232){
	attron(COLOR_PAIR(i));
	mvwhline(stdscr, cast(int)((i-16)%36),(2*w+w*((i-16)/36)),to!size_t(' '),w);
	attroff(COLOR_PAIR(i));
    }
    foreach(ushort i; 232 .. 256){
	attron(COLOR_PAIR(i));
	mvwhline(stdscr, cast(int)(i-232),(8*w),to!size_t(' '),w);
	attroff(COLOR_PAIR(i));
    }
    wmove(stdscr, LINES-1, COLS-1);
    getch();
    endwin();

    return 0;
}
