//Modified by: 1100110

import std.stdio: writeln;
import std.string: toStringz;
import ncurses;



int main()
{
	initscr();								//Start curses mode
	if(has_colors() == false)
	{
		endwin();
		writeln("Your terminal does not support color...");
		return 1;							//ends the program
	}
	start_color();							// Start color
	init_pair(1, COLOR_RED, COLOR_BLACK);

	attron(COLOR_PAIR(1));
	print_in_middle(stdscr, LINES/2, 0, 0, "Voila !!! In color...  =)");
	attroff(COLOR_PAIR(1));

    getch();
	endwin();

    return 0;
}

//you know what? I don't even know.  I'll get back to you when I'm done
//translating all of the files to D2...
void print_in_middle(WINDOW *win, int starty, int startx, int width, string str)
{
	int length, x, y;
	float temp;

	if(win == null)
		win = stdscr;

	getyx(win, y, x);
	if(startx != 0)
		x = startx;

	if(starty != 0)
		y = starty;

	if(width == 0)
		width = 80;

	//int already takes the floor, we can change temp to int.
	temp = (width - str.length)/ 2;
	x = startx + cast(int)temp;
	mvwprintw(win, y, x, "%s", toStringz(str));
	refresh();
}

