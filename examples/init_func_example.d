/* This is rather interesting, it prints the bold version
 * of whatever you type on the screen.
 *
 * Today's exercise: put all of this in a while loop,
 * so that you can keep typing stuff in until you get bored.
 * Might be harder than you think.  ;)
 * Modified by: 1100110
 */ 

import std.string: toStringz;
import ncurses;

void main()
{
	int ch;

	initscr();					//Start curses mode
	raw();						//Line buffering disabled
	keypad(stdscr, true);		//We want to get F1, F2 etc..
	noecho();					//Don't echo() while we do getch

    printw(toStringz("Type any character to see it in bold!\n"));
	ch = getch();				//If raw() hadn't been called
								//we have to press enter before it
								//gets to the program 	

	if(ch == KEY_F(1))	//Without keypad enabled this will not get to us either
		printw(toStringz("F1 Key pressed"));	
								//Without noecho() some ugly escape
								//charachters might have been printed
								//to the screen
	else
	{	printw(toStringz("The pressed key is: "));
		attron(A_BOLD);
		printw("%c", ch);		//again with the implicit conversion...
		attroff(A_BOLD);
	}
	refresh();					//Actually print it on the screen
    getch();					//Wait for user input/Hold the terminal open
	endwin();					//End curses mode
}

