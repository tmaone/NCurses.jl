# Event (experimental functionality)

function wgetch_events()
  # extern NCURSES_EXPORT(int) wgetch_events (WINDOW *, _nc_eventlist *);
end

function wgetnstr_events()
  # extern NCURSES_EXPORT(int) wgetnstr_events (WINDOW *,char *,int,_nc_eventlist *)
end

# * Function prototypes.  This is the complete X/Open Curses list of required
# * functions.  Those marked `generated' will have sources generated from the
# * macro definitions later in this file, in order to satisfy XPG4.2
# * requirements.

###  addch

# extern NCURSES_EXPORT(int) addch (const chtype);			/* generated */
# extern NCURSES_EXPORT(int) addchnstr (const chtype *, int);		/* generated */
# extern NCURSES_EXPORT(int) addchstr (const chtype *);			/* generated */
# extern NCURSES_EXPORT(int) mvaddch (int, int, const chtype);		/* generated */
# extern NCURSES_EXPORT(int) mvaddchnstr (int, int, const chtype *, int);	/* generated */
# extern NCURSES_EXPORT(int) mvaddchstr (int, int, const chtype *);	/* generated */
# extern NCURSES_EXPORT(int) mvwaddch (WINDOW *, int, int, const chtype);	/* generated */
function mvwaddch( win, y::Int, x::Int, c )
    ccall((:mvwaddch, ncurses), Void,
        ( Ptr{Void}, Int, Int, Int ), win, y, x, c )
end
# extern NCURSES_EXPORT(int) mvwaddchnstr (WINDOW *, int, int, const chtype *, int);/* generated
# extern NCURSES_EXPORT(int) mvwaddchstr (WINDOW *, int, int, const chtype *);	/* generated */
# extern NCURSES_EXPORT(int) waddch (WINDOW *, const chtype);		/* implemented */
# extern NCURSES_EXPORT(int) waddchnstr (WINDOW *,const chtype *,int);	/* implemented */
# extern NCURSES_EXPORT(int) waddchstr (WINDOW *,const chtype *);		/* generated */

###  attr

# extern NCURSES_EXPORT(int) attroff (NCURSES_ATTR_T);			/* generated */
# extern NCURSES_EXPORT(int) attron (NCURSES_ATTR_T);			/* generated */
# extern NCURSES_EXPORT(int) attrset (NCURSES_ATTR_T);			/* generated */
# extern NCURSES_EXPORT(int) attr_get (attr_t *, NCURSES_PAIRS_T *, void *);
# extern NCURSES_EXPORT(int) attr_off (attr_t, void *);			/* generated */
# extern NCURSES_EXPORT(int) attr_on (attr_t, void *);			/* generated */
# extern NCURSES_EXPORT(int) attr_set (attr_t, NCURSES_PAIRS_T, void *);
# extern NCURSES_EXPORT(int) wattron (WINDOW *, int);			/* generated */
function wattron( win, attrs )
    ccall((:wattron, ncurses), Int, ( Ptr{Void}, Uint32 ), win, attrs )
end
# extern NCURSES_EXPORT(int) wattroff (WINDOW *, int);			/* generated */
function wattroff( win, attrs )
    ccall((:wattroff, ncurses), Int, ( Ptr{Void}, Uint32 ), win, attrs )
end
# extern NCURSES_EXPORT(int) wattrset (WINDOW *, int);			/* generated */
function wattrset( win, attrs )
    ccall((:wattrset, ncurses), Int, ( Ptr{Void}, Uint32 ), win, attrs )
end
# extern NCURSES_EXPORT(int) wattr_get (WINDOW *, attr_t *, NCURSES_PAIRS_T *, void *);
# extern NCURSES_EXPORT(int) wattr_on (WINDOW *, attr_t, void *);		/* implemented */
# extern NCURSES_EXPORT(int) wattr_off (WINDOW *, attr_t, void *);	/* implemented */
# extern NCURSES_EXPORT(int) wattr_set (WINDOW *, attr_t, NCURSES_PAIRS_T, void *);	/*

##### win

# extern NCURSES_EXPORT(WINDOW *) newwin (int,int,int,int);	       	/* implemented */
function newwin( lines::Int, cols::Int, origy::Int, origx::Int )
    ccall((:newwin, ncurses), Ptr{Void}, ( Int, Int, Int, Int ),
        lines, cols, origy, origx )
end
# extern NCURSES_EXPORT(bool) isendwin (void);				/* implemented */
function isendwin()
    ccall((:isendwin, ncurses), Bool, () )
end
# extern NCURSES_EXPORT(int) endwin (void);				/* implemented */
function endwin()
    ccall((:endwin, ncurses), Int, () )
end
# extern NCURSES_EXPORT(WINDOW *) subwin (WINDOW *, int, int, int, int);	/* implemented */
function subwin(win::Ptr{Void}, lines::Int, cols::Int, origy::Int, origx::Int )
    ccall((:subwin, ncurse ), Ptr{Void}, ( Ptr{Void}, Int, Int, Int, Int ),
        win, lines, cols, origy, origx )
end
# extern NCURSES_EXPORT(WINDOW *) derwin (WINDOW *,int,int,int,int);	/* implemented */
function derwin( win, lines::Int, cols::Int, origy::Int, origx::Int )
    ccall((:derwin, ncurses ), Ptr{Void}, ( Ptr{Void}, Int, Int, Int, Int ),
        win, lines, cols, origy, origx )
end
# extern NCURSES_EXPORT(int) delwin (WINDOW *);				/* implemented */
function delwin( win::Ptr{Void} )
    ccall((:delwin, ncurses ), Void, ( Ptr{Void}, ), win )
end
# extern NCURSES_EXPORT(int) copywin (const WINDOW*,WINDOW*,int,int,int,int,int,int,int);	/* implemented */
# extern NCURSES_EXPORT(WINDOW *) dupwin (WINDOW *);			/* implemented */
# extern NCURSES_EXPORT(WINDOW *) getwin (FILE *);			/* implemented */
# extern NCURSES_EXPORT(int) untouchwin (WINDOW *);			/* generated */
# extern NCURSES_EXPORT(int) touchwin (WINDOW *);				/* generated */
function touchwin( win::Ptr{Void} )
    ccall((:touchwin, ncurses ), Void, ( Ptr{Void}, ), win )
end
# extern NCURSES_EXPORT(int) redrawwin (WINDOW *);			/* generated */
# extern NCURSES_EXPORT(int) putwin (WINDOW *, FILE *);			/* implemented */
# extern NCURSES_EXPORT(int) mvderwin (WINDOW *, int, int);		/* implemented */
# extern NCURSES_EXPORT(int) mvwin (WINDOW *,int,int);			/* implemented */
function mvwin( win, y::Int, x::Int )
    ccall((:mvwin, ncurses), Int, ( Ptr{Void}, Int, Int ), win, y, x )
end


#### str

# extern NCURSES_EXPORT(int) addnstr (const char *, int);			/* generated */
# extern NCURSES_EXPORT(int) addstr (const char *);			/* generated */
# extern NCURSES_EXPORT(int) mvwaddnstr (WINDOW *, int, int, const char *, int);	/* generated */
# extern NCURSES_EXPORT(int) mvwaddstr (WINDOW *, int, int, const char *);	/* generated */
# extern NCURSES_EXPORT(int) mvwgetnstr (WINDOW *, int, int, char *, int);	/* generated */
# extern NCURSES_EXPORT(int) mvwgetstr (WINDOW *, int, int, char *);	/* generated */
# extern NCURSES_EXPORT(int) mvwin chnstr (WINDOW *, int, int, chtype *, int);	/* generated */
# extern NCURSES_EXPORT(int) mvwinchstr (WINDOW *, int, int, chtype *);		/* generated */
# extern NCURSES_EXPORT(int) mvwinnstr (WINDOW *, int, int, char *, int);		/* generated */
# extern NCURSES_EXPORT(int) mvwinsnstr (WINDOW *, int, int, const char *, int);	/* generated */
# extern NCURSES_EXPORT(int) mvwinsstr (WINDOW *, int, int, const char *);	/* generated */
# extern NCURSES_EXPORT(int) mvwinstr (WINDOW *, int, int, char *);		/* generated */
# extern NCURSES_EXPORT(int) mvinsnstr (int, int, const char *, int);	/* generated */
# extern NCURSES_EXPORT(int) mvinsstr (int, int, const char *);		/* generated */
# extern NCURSES_EXPORT(int) mvinstr (int, int, char *);			/* generated */
# extern NCURSES_EXPORT(int) mvinchnstr (int, int, chtype *, int);	/* generated */
# extern NCURSES_EXPORT(int) mvinchstr (int, int, chtype *);		/* generated */
# extern NCURSES_EXPORT(int) mvinnstr (int, int, char *, int);		/* generated */
# extern NCURSES_EXPORT(int) mvgetnstr (int, int, char *, int);		/* generated */
# extern NCURSES_EXPORT(int) mvgetstr (int, int, char *);			/* generated */
# extern NCURSES_EXPORT(int) mvaddnstr (int, int, const char *, int);	/* generated */
# extern NCURSES_EXPORT(int) mvaddstr (int, int, const char *);		/* generated */
# extern NCURSES_EXPORT(int) innstr (char *, int);			/* generated */
# extern NCURSES_EXPORT(int) inchnstr (chtype *, int);			/* generated */
# extern NCURSES_EXPORT(int) inchstr (chtype *);				/* generated */
# extern NCURSES_EXPORT(int) getnstr (char *, int);			/* generated */
# extern NCURSES_EXPORT(int) getstr (char *);				/* generated */
# extern NCURSES_EXPORT(int) insnstr (const char *, int);			/* generated */
# extern NCURSES_EXPORT(int) insstr (const char *);			/* generated */
# extern NCURSES_EXPORT(int) instr (char *);				/* generated */
# extern NCURSES_EXPORT(int) wgetnstr (WINDOW *,char *,int);		/* implemented */
# extern NCURSES_EXPORT(int) wgetstr (WINDOW *, char *);			/* generated */
# extern NCURSES_EXPORT(int) winchnstr (WINDOW *, chtype *, int);		/* implemented */
# extern NCURSES_EXPORT(int) winchstr (WINDOW *, chtype *);		/* generated */
# extern NCURSES_EXPORT(int) winnstr (WINDOW *, char *, int);		/* implemented */
# extern NCURSES_EXPORT(int) winsnstr (WINDOW *, const char *,int);	/* implemented */
# extern NCURSES_EXPORT(int) winsstr (WINDOW *, const char *);		/* generated */
# extern NCURSES_EXPORT(int) winstr (WINDOW *, char *);			/* generated */
# extern NCURSES_EXPORT(int) waddnstr (WINDOW *,const char *,int);	/* implemented */
# extern NCURSES_EXPORT(int) waddstr (WINDOW *,const char *);		/* generated */

### print/scan

# extern NCURSES_EXPORT(int) wprintw (WINDOW *, const char *,...)		/* implemented */
function wprintw( win::Ptr{Void} , str::String )
    ccall((:printw, ncurses), Void, (Ptr{Void}, Ptr{Uint8}), win, str )
end
# extern NCURSES_EXPORT(int) vwprintw (WINDOW *, const char *,va_list);	/* implemented */
# extern NCURSES_EXPORT(int) vw_printw (WINDOW *, const char *,va_list);	/* generated */
# extern NCURSES_EXPORT(int) printw (const char *,...)			/* implemented */å
function printw( str::String )
    ccall((:printw, ncurses, ncurses), Void, (Ptr{Uint8},), str )
end
# extern NCURSES_EXPORT(int) mvwprintw (WINDOW*,int,int, const char *,...)	/* implemented */
function mvwprintw( win::Ptr{Void}, row::Int, height::Int, fmt::String, str::String )
    ccall((:mvwprintw, ncurses), Void,
        ( Ptr{Void}, Int, Int, Ptr{Uint8}, Ptr{Uint8}),
        win, row, height, fmt, str )
end
# extern NCURSES_EXPORT(int) mvprintw (int,int, const char *,...)		/* implemented */
function mvprintw( row::Int, height::Int, str::String )
    ccall((:printw, ncurses), Void, (Int, Int, Ptr{Uint8}), row, height, str )
end
# extern NCURSES_EXPORT(int) wscanw (WINDOW *, NCURSES_CONST char *,...)	/* implemented */
# extern NCURSES_EXPORT(int) vwscanw (WINDOW *, NCURSES_CONST char *,va_list);	/* implemented */
# extern NCURSES_EXPORT(int) vw_scanw (WINDOW *, NCURSES_CONST char *,va_list);	/* generated */
# extern NCURSES_EXPORT(int) scanw (NCURSES_CONST char *,...)		/* implemented */
# extern NCURSES_EXPORT(int) mvwscanw (WINDOW *,int,int, NCURSES_CONST char *,...)
# extern NCURSES_EXPORT(int) mvscanw (int,int, NCURSES_CONST char *,...)	/* implemented */

#### Varia

# extern NCURSES_EXPORT(WINDOW *) initscr (void);				/* implemented */
function initscr()
    ccall((:initscr, ncurses ), Ptr{Void}, () )
end
# extern NCURSES_EXPORT(int) baudrate (void);				/* implemented */
function baudrate()
    ccall((:baudrate, ncurses), Int, () )
end
# extern NCURSES_EXPORT(int) beep  (void);				/* implemented */
function beep()
    ccall((:beep, ncurses ), Void, () )
end
# extern NCURSES_EXPORT(int) bkgd (chtype);				/* generated */
# extern NCURSES_EXPORT(void) bkgdset (chtype);				/* generated */
# extern NCURSES_EXPORT(int) border (chtype,chtype,chtype,chtype,chtype,chtype,chtype,chtype);	/* generated */
# extern NCURSES_EXPORT(int) box (WINDOW *, chtype, chtype);		/* generated */
function box( win, vchr, hchr )
    ccall((:box, ncurses ), Void, (Ptr{Void}, Char, Char), win, vchr, hchr )
end
# extern NCURSES_EXPORT(bool) can_change_color (void);			/* implemented */
# extern NCURSES_EXPORT(int) cbreak (void);				/* implemented */
function cbreak()
    ccall((:cbreak, ncurses), Void, ( ) )
end
# extern NCURSES_EXPORT(int) chgat (int, attr_t, NCURSES_PAIRS_T, const void *);	/* generated */
# extern NCURSES_EXPORT(int) clear (void);				/* generated */
# extern NCURSES_EXPORT(int) clearok (WINDOW *,bool);			/* implemented */
function clearok( win, bf )
    ccall((:clearok, ncurses), Int, ( Ptr{Void}, Bool ), win, bf )
end
# extern NCURSES_EXPORT(int) clrtobot (void);				/* generated */
# extern NCURSES_EXPORT(int) clrtoeol (void);				/* generated */
# extern NCURSES_EXPORT(int) color_content (NCURSES_COLOR_T,NCURSES_COLOR_T*,NCURSES_COLOR_T*,NCURSES_COLOR_T*);	/* implemented */
# extern NCURSES_EXPORT(int) color_set (NCURSES_PAIRS_T,void*);			/* generated */
# extern NCURSES_EXPORT(int) COLOR_PAIR (int);				/* generated */
# extern NCURSES_EXPORT(int) curs_set (int);				/* implemented */
function curs_set( vis )
    ccall((:curs_set, ncurses), Int, ( Int, ), vis )
end
# extern NCURSES_EXPORT(int) def_prog_mode (void);			/* implemented */
# extern NCURSES_EXPORT(int) def_shell_mode (void);			/* implemented */
# extern NCURSES_EXPORT(int) delay_output (int);				/* implemented */
# extern NCURSES_EXPORT(int) delch (void);				/* generated */
# extern NCURSES_EXPORT(void) delscreen (SCREEN *);			/* implemented */
# extern NCURSES_EXPORT(int) deleteln (void);				/* generated */
# extern NCURSES_EXPORT(int) doupdate (void);				/* implemented *
# extern NCURSES_EXPORT(int) echo (void);					/* implemented */
function echo()
    ccall((:echo, ncurses), Void, ( ) )
end
# extern NCURSES_EXPORT(int) echochar (const chtype);			/* generated */
# extern NCURSES_EXPORT(int) erase (void);				/* generated */
function erase()
    ccall((:erase, ncurses ), Void, () )
end
# extern NCURSES_EXPORT(char) erasechar (void);				/* implemented */
# extern NCURSES_EXPORT(void) filter (void);				/* implemented */
# extern NCURSES_EXPORT(int) flash (void);				/* implemented */
function flash()
    ccall((:flash, ncurses), Void, () )
end
# extern NCURSES_EXPORT(int) flushinp (void);				/* implemented */
# extern NCURSES_EXPORT(chtype) getbkgd (WINDOW *);			/* generated */
# extern NCURSES_EXPORT(int) getch (void);				/* generated */
# extern NCURSES_EXPORT(int) halfdelay (int);				/* implemented */
# extern NCURSES_EXPORT(bool) has_colors (void);				/* implemented */
function has_colors()
    ccall((:has_colors, ncurses), Bool, () )
end
# extern NCURSES_EXPORT(bool) has_ic (void);				/* implemented */
# extern NCURSES_EXPORT(bool) has_il (void);				/* implemented */
# extern NCURSES_EXPORT(int) hline (chtype, int);				/* generated */
# extern NCURSES_EXPORT(void) idcok (WINDOW *, bool);			/* implemented */
# extern NCURSES_EXPORT(int) idlok (WINDOW *, bool);			/* implemented */
# extern NCURSES_EXPORT(void) immedok (WINDOW *, bool);			/* implemented */
function immedok( win, bf )
    ccall((:immedok, ncurses), Int, ( Ptr{Void}, Bool ), win, bf )
end
# extern NCURSES_EXPORT(chtype) inch (void);				/* generated */
# extern NCURSES_EXPORT(int) init_color (NCURSES_COLOR_T,NCURSES_COLOR_T,NCURSES_COLOR_T,NCURSES_COLOR_T);	/* implemented */
function init_color( color, r,g,b )
    ccall((:init_color, ncurses), Int, ( Int16, Int16, Int16, Int16 ),
        color, r,g,b )
end
# extern NCURSES_EXPORT(int) init_pair (NCURSES_PAIRS_T,NCURSES_COLOR_T,NCURSES_COLOR_T);
function init_pair( pair, f, b )
    ccall((:init_pair, ncurses), Int, ( Int16, Int16, Int16 ), pair, f, b )
end
# extern NCURSES_EXPORT(int) insch (chtype);				/* generated */
# extern NCURSES_EXPORT(int) insdelln (int);				/* generated */
# extern NCURSES_EXPORT(int) insertln (void);				/* generated */
# extern NCURSES_EXPORT(int) intrflush (WINDOW *,bool);			/* implemented */
# extern NCURSES_EXPORT(bool) is_linetouched (WINDOW *,int);		/* implemented */
# extern NCURSES_EXPORT(bool) is_wintouched (WINDOW *);			/* implemented */
# extern NCURSES_EXPORT(NCURSES_CONST char *) keyname (int);		/* implemented */
# extern NCURSES_EXPORT(int) keypad (WINDOW *,bool);			/* implemented */
function keypad( win, bf )
    ccall((:keypad, ncurses ), Int, (Ptr{Void}, Bool), win, bf )
end
# extern NCURSES_EXPORT(char) killchar (void);				/* implemented */
# extern NCURSES_EXPORT(int) leaveok (WINDOW *,bool);			/* implemented */
# extern NCURSES_EXPORT(char *) longname (void);				/* implemented */
# extern NCURSES_EXPORT(int) meta (WINDOW *,bool);			/* implemented */
# extern NCURSES_EXPORT(int) move (int, int);				/* generated */
# extern NCURSES_EXPORT(int) mvchgat (int, int, int, attr_t, NCURSES_PAIRS_T, const void *);	/* generated */
# extern NCURSES_EXPORT(int) mvcur (int,int,int,int);			/* implemented */
# extern NCURSES_EXPORT(int) mvdelch (int, int);				/* generated */
# extern NCURSES_EXPORT(int) mvgetch (int, int);				/* generated */
# extern NCURSES_EXPORT(int) mvhline (int, int, chtype, int);		/* generated */
# extern NCURSES_EXPORT(chtype) mvinch (int, int);			/* generated */
# extern NCURSES_EXPORT(int) mvinsch (int, int, chtype);			/* generated */
# extern NCURSES_EXPORT(int) mvvline (int, int, chtype, int);		/* generated */
# extern NCURSES_EXPORT(int) mvwchgat (WINDOW *, int, int, int, attr_t, NCURSES_PAIRS_T, const void *);/* generated */
# extern NCURSES_EXPORT(int) mvwdelch (WINDOW *, int, int);		/* generated */
# extern NCURSES_EXPORT(int) mvwgetch (WINDOW *, int, int);		/* generated */
# extern NCURSES_EXPORT(int) mvwhline (WINDOW *, int, int, chtype, int);	/* generated */
# extern NCURSES_EXPORT(chtype) mvwinch (WINDOW *, int, int);			/* generated */
# extern NCURSES_EXPORT(int) mvwinsch (WINDOW *, int, int, chtype);		/* generated */
# extern NCURSES_EXPORT(int) mvwvline (WINDOW *,int, int, chtype, int);	/* generated */
# extern NCURSES_EXPORT(int) napms (int);					/* implemented */
function napms( ms::Int )
    ccall((:napms, ncurses), Int, (Int, ), ms )
end
# extern NCURSES_EXPORT(WINDOW *) newpad (int,int);		       	/* implemented */
# extern NCURSES_EXPORT(SCREEN *) newterm (NCURSES_CONST char *,FILE *,FILE *);	/* implemented */
# extern NCURSES_EXPORT(int) nl (void);					/* implemented */
# extern NCURSES_EXPORT(int) nocbreak (void);				/* implemented */
function nocbreak()
    ccall((:nocbreak, ncurses), Void, ( ) )
end
# extern NCURSES_EXPORT(int) nodelay (WINDOW *,bool);			/* implemented */
function nodelay( win, bf )
    ccall((:nodelay, ncurses ), Int, (Ptr{Void}, Bool), win, bf )
end
# extern NCURSES_EXPORT(int) noecho (void);				/* implemented */
function noecho()
    ccall((:noecho, ncurses), Void, ( ) )
end
# extern NCURSES_EXPORT(int) nonl (void);					/* implemented */
# extern NCURSES_EXPORT(void) noqiflush (void);				/* implemented */
# extern NCURSES_EXPORT(int) noraw (void);				/* implemented */
function noraw()
    ccall((:noraw, ncurses ), Int, () )
end
# extern NCURSES_EXPORT(int) notimeout (WINDOW *,bool);			/* implemented */
function notimeout( win, bf )
    ccall((:notimeout, ncurses ), Int, (Ptr{Void}, Bool), win, bf )
end
# extern NCURSES_EXPORT(int) overlay (const WINDOW*,WINDOW *);		/* implemented */
# extern NCURSES_EXPORT(int) overwrite (const WINDOW*,WINDOW *);		/* implemented */
# extern NCURSES_EXPORT(int) pair_content (NCURSES_PAIRS_T,NCURSES_COLOR_T*,NCURSES_COLOR_T*);		/* implemented */
# extern NCURSES_EXPORT(int) PAIR_NUMBER (int);				/* generated */
# extern NCURSES_EXPORT(int) pechochar (WINDOW *, const chtype);		/* implemented */
# extern NCURSES_EXPORT(int) pnoutrefresh (WINDOW*,int,int,int,int,int,int);/* implemented */
# extern NCURSES_EXPORT(int) prefresh (WINDOW *,int,int,int,int,int,int);	/* implemented */
# extern NCURSES_EXPORT(void) qiflush (void);				/* implemented */
# extern NCURSES_EXPORT(int) raw (void);					/* implemented */
function raw()
    ccall((:raw, ncurses ), Int, () )
end
# extern NCURSES_EXPORT(int) refresh (void);				/* generated */
function refresh()
    ccall((:refresh, ncurses ), Void, ( ) )
end
# extern NCURSES_EXPORT(int) resetty (void);				/* implemented */
# extern NCURSES_EXPORT(int) reset_prog_mode (void);			/* implemented */
# extern NCURSES_EXPORT(int) reset_shell_mode (void);			/* implemented */
# extern NCURSES_EXPORT(int) ripoffline (int, int (*)(WINDOW *, int));	/* implemented */
# extern NCURSES_EXPORT(int) savetty (void);				/* implemented */
# extern NCURSES_EXPORT(int) scr_dump (const char *);			/* implemented */
# extern NCURSES_EXPORT(int) scr_init (const char *);			/* implemented */
# extern NCURSES_EXPORT(int) scrl (int);					/* generated */
# extern NCURSES_EXPORT(int) scroll (WINDOW *);				/* generated */
# extern NCURSES_EXPORT(int) scrollok (WINDOW *,bool);			/* implemented */
# extern NCURSES_EXPORT(int) scr_restore (const char *);			/* implemented */
# extern NCURSES_EXPORT(int) scr_set (const char *);			/* implemented */
# extern NCURSES_EXPORT(int) setscrreg (int,int);				/* generated */
# extern NCURSES_EXPORT(SCREEN *) set_term (SCREEN *);			/* implemented */
# extern NCURSES_EXPORT(int) slk_attroff (const chtype);			/* implemented */
# extern NCURSES_EXPORT(int) slk_attr_off (const attr_t, void *);		/* generated:WIDEC */
# extern NCURSES_EXPORT(int) slk_attron (const chtype);			/* implemented */
# extern NCURSES_EXPORT(int) slk_attr_on (attr_t,void*);			/* generated:WIDEC */
# extern NCURSES_EXPORT(int) slk_attrset (const chtype);			/* implemented */
# extern NCURSES_EXPORT(attr_t) slk_attr (void);				/* implemented */
# extern NCURSES_EXPORT(int) slk_attr_set (const attr_t,NCURSES_PAIRS_T,void*);	/* implemented */
# extern NCURSES_EXPORT(int) slk_clear (void);				/* implemented */
# extern NCURSES_EXPORT(int) slk_color (NCURSES_PAIRS_T);				/* implemented */
# extern NCURSES_EXPORT(int) slk_init (int);				/* implemented */
# extern NCURSES_EXPORT(char *) slk_label (int);				/* implemented */
# extern NCURSES_EXPORT(int) slk_noutrefresh (void);			/* implemented */
# extern NCURSES_EXPORT(int) slk_refresh (void);				/* implemented */
# extern NCURSES_EXPORT(int) slk_restore (void);				/* implemented */
# extern NCURSES_EXPORT(int) slk_set (int,const char *,int);		/* implemented */
# extern NCURSES_EXPORT(int) slk_touch (void);	      	       		/* implemented */
# extern NCURSES_EXPORT(int) standout (void);				/* generated */
# extern NCURSES_EXPORT(int) standend (void);				/* generated */
# extern NCURSES_EXPORT(int) start_color (void);				/* implemented */
function start_color()
    ccall((:start_color, ncurses), Void, () )
end
# extern NCURSES_EXPORT(WINDOW *) subpad (WINDOW *, int, int, int, int);	/* implemented */
# extern NCURSES_EXPORT(int) syncok (WINDOW *, bool);			/* implemented */
# extern NCURSES_EXPORT(chtype) termattrs (void);				/* implemented */
# extern NCURSES_EXPORT(char *) termname (void);				/* implemented */
# extern NCURSES_EXPORT(void) timeout (int);				/* generated */
function timeout( delay::Int )
    ccall((:timeout, ncurses ), Void, (Int,), delay )
end
# extern NCURSES_EXPORT(int) touchline (WINDOW *, int, int);		/* generated */
# extern NCURSES_EXPORT(int) typeahead (int);				/* implemented */
# extern NCURSES_EXPORT(int) ungetch (int);				/* implemented */
# extern NCURSES_EXPORT(void) use_env (bool);				/* implemented */
# extern NCURSES_EXPORT(void) use_tioctl (bool);				/* implemented */
# extern NCURSES_EXPORT(int) vidattr (chtype);				/* implemented */
# extern NCURSES_EXPORT(int) vidputs (chtype, NCURSES_OUTC);		/* implemented */
# extern NCURSES_EXPORT(int) vline (chtype, int);				/* generated */
# extern NCURSES_EXPORT(int) wbkgd (WINDOW *, chtype);			/* implemented */
function wbkgd( win, ch )
    ccall((:wbkgd, ncurses ), Void, ( Ptr{Void}, Uint32 ), win, ch )
end
# extern NCURSES_EXPORT(void) wbkgdset (WINDOW *,chtype);			/* implemented */
function wbkgdset( win, ch )
    ccall((:wbkgdset, ncurses ), Void, ( Ptr{Void}, Uint32 ), win, ch )
end
# extern NCURSES_EXPORT(int) wborder (WINDOW*,chtype,chtype,chtype,chtype,chtype,chtype,chtype,chtype);	/* implemented */
# extern NCURSES_EXPORT(int) wchgat (WINDOW *, int, attr_t, NCURSES_PAIRS_T, const void *);/* implemented */
# extern NCURSES_EXPORT(int) wclear (WINDOW *);				/* implemented */
function wclear( win::Ptr{Void} )
    ccall((:wclear, ncurses ), Void, (Ptr{Void},), win )
end
# extern NCURSES_EXPORT(int) wclrtobot (WINDOW *);			/* implemented */
# extern NCURSES_EXPORT(int) wclrtoeol (WINDOW *);			/* implemented */
# extern NCURSES_EXPORT(int) wcolor_set (WINDOW*,NCURSES_PAIRS_T,void*);		/* implemented */
# extern NCURSES_EXPORT(void) wcursyncup (WINDOW *);			/* implemented */
# extern NCURSES_EXPORT(int) wdelch (WINDOW *);				/* implemented */
# extern NCURSES_EXPORT(int) wdeleteln (WINDOW *);			/* generated */
# extern NCURSES_EXPORT(int) wechochar (WINDOW *, const chtype);		/* implemented */
# extern NCURSES_EXPORT(int) werase (WINDOW *);				/* implemented */
function werase( win::Ptr{Void} )
    ccall((:werase, ncurses ), Void, (Ptr{Void},), win )
end
# extern NCURSES_EXPORT(int) wgetch (WINDOW *);				/* implemented */
function wgetch( win::Ptr{Void } )
    ccall((:wgetch, ncurses ), Uint32, (Ptr{Void},), win )
end
# extern NCURSES_EXPORT(int) whline (WINDOW *, chtype, int);		/* implemented */
# extern NCURSES_EXPORT(chtype) winch (WINDOW *);				/* implemented */
# extern NCURSES_EXPORT(int) winsch (WINDOW *, chtype);			/* implemented */
# extern NCURSES_EXPORT(int) winsdelln (WINDOW *,int);			/* implemented */
# extern NCURSES_EXPORT(int) winsertln (WINDOW *);			/* generated */
function wmove( win, y::Int, x::Int )
  # extern NCURSES_EXPORT(int) wmove (WINDOW *,int,int);			/* implemented */
  ccall((:wmove, ncurses), Int, ( Ptr{Void}, Int, Int ), win, y, x )
end
# extern NCURSES_EXPORT(int) wnoutrefresh (WINDOW *);			/* implemented *
# extern NCURSES_EXPORT(int) wredrawln (WINDOW *,int,int);		/* implemented */
# extern NCURSES_EXPORT(int) wrefresh (WINDOW *);				/* implemented */
function wrefresh( win::Ptr{Void} )
    ccall((:wrefresh, ncurses ), Void, ( Ptr{Void}, ), win )
end
# extern NCURSES_EXPORT(int) wscrl (WINDOW *,int);			/* implemented */
# extern NCURSES_EXPORT(int) wsetscrreg (WINDOW *,int,int);		/* implemented */
# extern NCURSES_EXPORT(int) wstandout (WINDOW *);			/* generated */
# extern NCURSES_EXPORT(int) wstandend (WINDOW *);			/* generated */
# extern NCURSES_EXPORT(void) wsyncdown (WINDOW *);			/* implemented */
# extern NCURSES_EXPORT(void) wsyncup (WINDOW *);				/* implemented */
# extern NCURSES_EXPORT(void) wtimeout (WINDOW *,int);			/* implemented */
function wtimeout( win, delay::Int )
    ccall((:wtimeout, ncurses ), Void, (Ptr{Void}, Int), win, delay )
end
# extern NCURSES_EXPORT(int) wtouchln (WINDOW *,int,int,int);		/* implemented */
# extern NCURSES_EXPORT(int) wvline (WINDOW *,chtype,int);		/* implemented */














































####  not standard but convenient TermWin

function getwinmaxyx( win )
    maxy = ccall((:getmaxy, ncurses), Int, ( Ptr{Void}, ), win )
    maxx = ccall((:getmaxx, ncurses), Int, ( Ptr{Void}, ), win )
    ( maxy, maxx )
end

function getwinbegyx( win )
    maxy = ccall((:getbegy, ncurses), Int, ( Ptr{Void}, ), win )
    maxx = ccall((:getbegx, ncurses), Int, ( Ptr{Void}, ), win )
    ( maxy, maxx )
end

function is_term_resized( lines::Int, cols::Int )
    ccall((:is_term_resized, ncurses ), Bool, (Int, Int), lines, cols )
end

function wresize( win, lines::Int, cols::Int )
    ccall((:wresize), Int, (Ptr{Void}, Int, Int), win, lines, cols )
end

function getcuryx( win )
    cury = ccall((:getcury, ncurses), Cint, ( Ptr{Void}, ), win )
    curx = ccall((:getcurx, ncurses), Cint, ( Ptr{Void}, ), win )
    ( cury, curx )
end

function has_mouse()
    ccall((:has_mouse, ncurses), Bool, () )
end

function mousemask( mask )
    oldmm = Array( Uint64, 1 )
    resultmm = ccall((:mousemask, ncurses), Uint64, (Uint64, Ptr{Uint64}), mask, oldmm )
    ( resultmm, oldmm[1] )
end

function mouseinterval( n::Int )
    ccall((:mouseinterval, ncurses), Int, (Int, ) , n)
end

#hack!
const mouseByteString = bytestring( Array( Uint8, 64 ) )
function getmouse()
    #=
    type Mouse_Event_t
        id::Int8 # short
        x::Int32 # int
        y::Int32 # int
        z::Int32 # int
        bstate::Uint64 # unsigned long
    end
    =#
    # the 5th byte is x, 9th byte is y
    # 19th byte is x08 if scroll up, 20th byte is x08 if scroll down
    # 17th byte is x02 if button 1 pressed
    # 17th byte is x01 if button 1 released
    # 17-18th is 0xfffd if mousewheel is pressed down
    ccall((:getmouse, ncurses), Int, (Ptr{Uint8}, ), mouseByteString )
    bs = mouseByteString
    x = uint8(bs[5])
    y = uint8(bs[9])
    state=:unknown
    println(bs, x, y, state)
    # if bs[17] & 0x02 != 0
    #     state = :button1_pressed
    # elseif bs[19] & 0x08 != 0
    #     state = :scroll_up
    # elseif bs[20] & 0x08 != 0
    #     state = :scroll_down
    # end
    ( state, x, y, bs )
end

export initscr, endwin, isendwin, newwin, subwin, delwin, derwin, werase, erase, refresh, mvwaddch, wclear, mvwprintw, touchwin, wmove, box, wrefresh, wgetch, nocbreak, keypad, nodelay, noecho, cbreak, echo, raw, noraw, timeout, notimeout, mvwin, getwinbegyx, beep, wtimeout, flash, getwinmaxyx, is_term_resized, wresize, getcuryx, start_color, init_pair, init_color, has_colors, wattroff, wattron, wattrset, wbkgdset, wbkgd, curs_set, has_mouse, mousemask, mouseinterval, getmouse, mouseByteString, baudrate, clearok, immedok, napms
