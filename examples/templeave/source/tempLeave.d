#!/usr/bin/rdmd -L-lncursesw
//Modified by: 1100110

import std.string:  toStringz;
import deimos.ncurses.ncurses;

extern(C) int system(immutable char* command);

void main()
{	
	initscr();								//Start curses mode
        scope(failure)  endwin();
        scope(exit)     endwin();

	printw(toStringz("Hello World !!!\nJust hit any key to continue.."));	//Print Hello World
	refresh();			//Print it on to the real screen
        getch();

	def_prog_mode();		//Save the tty modes
	endwin();			//End curses mode temporarily
	system(toStringz("/bin/sh"));   //Do whatever you like in cooked mode
	reset_prog_mode();		//Return to the previous tty mode stored by def_prog_mode()
	refresh();			//Do refresh() to restore the screen contents

	printw(toStringz("Another String\n"));	//Back to curses use the full capabilities
	refresh();			
	getch();
}
