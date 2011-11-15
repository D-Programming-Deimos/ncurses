//pager functionality by Joseph Spainhour" <spainhou@bellsouth.net>
//Modified by: 1100110
//I believe that this relies on deprecated features..
//Gonna have to be rewritten I believe.

import std.stdio: writefln;
import std.string: toStringz;
import std.c.stdio;
import ncurses;


int main(char[][] args)	
{
	//um...can you put a char into an int?  will that work?
	//I think that is the problem...
	int ch, prev, row, col;
	prev = EOF;
	FILE* fp;
	int y, x;

	if(args.length != 2)
	{
		writefln("Usage: %s <a c file name>\n", args[0]);
		return 1;		//Exit
	}//if

	fp = fopen(toStringz(args[1]), "r");
	if(fp == null)
	{
		perror("Cannot open input file");
		return 1;
	}//if
	initscr();						//start curses mode
	getmaxyx(stdscr, row, col);		//find the boundaries of the screeen
	while((ch = fgetc(fp)) != EOF)	//read the file till we reach the end
	{
		getyx(stdscr, y, x);		//get the current curser position
		if(y == (row - 1))			//are we are at the end of the screen
		{
			printw(toStringz("<-press any key->"));	//tell the user to press a key
			getch();
			clear();						//clear the screen
			move(0, 0);						//start at the beginning of the screen 
		}//if
		if(prev == '/' && ch == '*')    	//if it is / and * then only switch bold on
		{
			attron(A_BOLD);					//cut bold on
			getyx(stdscr, y, x);			//get the current curser position
			move(y, x - 1);					//back up one space
			printw("%c%c", '/', ch); 		//the actual printing is done here
		}//if
		else
			printw("%c", ch);
		refresh();
		if(prev == '*' && ch == '/')
			attroff(A_BOLD);        		//switch it off once we got * and then / 
		prev = ch;
	}//while
	getch();
	endwin();                       		//end curses mode
	fclose(fp);
	
	return 0;
}//main
