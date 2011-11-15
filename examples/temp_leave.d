//Modified by: 1100110
//Now THIS is interesting.

import std.string: toStringz;
import ncurses;

extern(C) int system(immutable char* command);

void main()
{	
	initscr();								//Start curses mode
	printw(toStringz("Hello World !!!\n"));	//Print Hello World
	refresh();						//Print it on to the real screen
	def_prog_mode();				//Save the tty modes
	endwin();						//End curses mode temporarily
	system(toStringz("/bin/sh"));				//Do whatever you like in cooked mode
	reset_prog_mode();				//Return to the previous tty mode
									//stored by def_prog_mode()
	refresh();						//Do refresh() to restore the
									//Screen contents
	printw(toStringz("Another String\n"));		//Back to curses use the full
	refresh();									//capabilities of curses
	getch();
	endwin();						//End curses mode
}
