//Modified by: 1100110

import std.string;
import ncurses;						/* ncurses.h includes stdio.h */  
 
void main()
{
	string mesg = "Just a string...";		//message to appear on the screen 
	int row, col;							//to store the number of rows and 
											//the number of colums of the screen
	initscr();								//start the curses mode 
	getmaxyx(stdscr, row, col);				//get the number of rows and columns
	//print the message at the center of the screen 
	mvprintw(row/2, (col-(mesg.length - 1))/2, "%s", toStringz(mesg));
	//Did you notice? there is a '%s' not toStringified.
	//In one of those great weird blips, D2 will pass small characters
	//like that, and yet will choke on larger strings.
	//This is where implicit rules make things unexpected happen.
								
	auto rowcol = toStringz("This screen has %d rows and %d columns\n");
	mvprintw(row-2, 0, rowcol, row+1, col+1);
	printw(toStringz("Try resizing your window(if possible) and then run this program again"));
	refresh();
	getch();
	endwin();
}
