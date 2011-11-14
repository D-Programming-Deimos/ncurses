//Modified by: 1100110
//exercise: make "Press F1" not disappear.

import std.string: toStringz;
import ncurses;

struct WIN_BORDER
{
	chtype 	ls, rs, ts, bs, tl, tr, bl, br;
}//struct WIN_BORDER

struct WIN
{
	int startx, starty;
	int height, width;
	WIN_BORDER border;
}

void main()
{	WIN win;
	int ch;

	initscr();				//Start curses mode
	start_color();			//Start the color functionality
	cbreak();				//Line buffering disabled, Pass on everty thing to me
	
	keypad(stdscr, true);	//I need that nifty F1
	noecho();
	scope(exit) endwin();	//End curses mode
	init_pair(1, COLOR_CYAN, COLOR_BLACK);


	//Initialize the window parameters
	init_win_params(&win);
	print_win_params(&win);

	attron(COLOR_PAIR(1));
	printw(toStringz("Press F1 to exit"));
	refresh();
	attroff(COLOR_PAIR(1));
	
	create_box(&win, true);
	while((ch = getch()) != KEY_F(1))
	{
		switch(ch)
		{
			case KEY_LEFT:
				create_box(&win, false);
				--win.startx;
				create_box(&win, true);
				break;
			case KEY_RIGHT:
				create_box(&win, false);
				++win.startx;
				create_box(&win, true);
				break;
			case KEY_UP:
				create_box(&win, false);
				--win.starty;
				create_box(&win, true);
				break;
			case KEY_DOWN:
				create_box(&win, false);
				++win.starty;
				create_box(&win, true);
				break;	
			default:
				break;
		}//switch-case()
	}//while()
}//main()

void init_win_params(WIN *p_win)
{
	p_win.height = 3;
	p_win.width = 10;
	p_win.starty = (LINES - p_win.height)/2;	
	p_win.startx = (COLS - p_win.width)/2;

	p_win.border.ls = '|';
	p_win.border.rs = '|';
	p_win.border.ts = '-';
	p_win.border.bs = '-';
	p_win.border.tl = '+';
	p_win.border.tr = '+';
	p_win.border.bl = '+';
	p_win.border.br = '+';
}//void init_win_params()

void print_win_params(WIN *p_win)
{
	debug
	{
		mvprintw(25, 0, toStringz("%d %d %d %d"), p_win.startx, p_win.starty, 
					p_win.width, p_win.height);
		refresh();
	}
}//void print_win_params

void create_box(WIN *p_win, bool flag)
{
	int i, j;
	int x = p_win.startx;
	int y = p_win.starty;
	int w = p_win.width;
	int h = p_win.height;
	
	if(flag == true)
	{
		mvaddch(y, x, p_win.border.tl);
		mvaddch(y, x + w, p_win.border.tr);
		mvaddch(y + h, x, p_win.border.bl);
		mvaddch(y + h, x + w, p_win.border.br);
		mvhline(y, x + 1, p_win.border.ts, w - 1);
		mvhline(y + h, x + 1, p_win.border.bs, w - 1);
		mvvline(y + 1, x, p_win.border.ls, h - 1);
		mvvline(y + 1, x + w, p_win.border.rs, h - 1);
	}//if
	else
		for(j = y; j <= y + h; ++j)
			for(i = x; i <= x + w; ++i)
				mvaddch(j, i, ' ');
				
	refresh();
}//void create_box
