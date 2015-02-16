export NCurses

module NCurses

using BinDeps

# loads "../deps/build.jl" and forces re-install of library
# this explains why other modules prefer to load deps.jl instead.
# @BinDeps.load_dependencies "../deps/deps.jl" [:ncurses]

if isfile(joinpath(Pkg.dir("NCurses"),"deps","deps.jl"))
  include("../deps/deps.jl")
else
  error("NCurses not properly installed. Please run Pkg.build(\"NCurses\")")
end

const COLOR_BLACK   = 0
const COLOR_RED     = 1
const COLOR_GREEN   = 2
const COLOR_YELLOW  = 3
const COLOR_BLUE    = 4
const COLOR_MAGENTA = 5
const COLOR_CYAN    = 6
const COLOR_WHITE   = 7

export COLOR_BLACK, COLOR_RED, COLOR_GREEN, COLOR_YELLOW, COLOR_BLUE, COLOR_MAGENTA, COLOR_CYAN, COLOR_WHITE

chtype = UInt8
export chtype

COLOR_PAIR( n ) = NCURSES_BITS(n, 0)
export COLOR_PAIR

const NCURSES_ATTR_SHIFT =8
function NCURSES_BITS( m, shf)
    m << (shf + NCURSES_ATTR_SHIFT)
end
export NCURSES_BITS

const A_NORMAL     = uint32(0)
const A_ATTRIBUTES = ~uint32(0)
const A_CHARTEXT   = (NCURSES_BITS(uint32(1),0) - uint32(1))
const A_COLOR      = NCURSES_BITS((uint32(1) << 8) - uint32(1),0)
const A_STANDOUT   = NCURSES_BITS(uint32(1),8)
const A_UNDERLINE  = NCURSES_BITS(uint32(1),9)
const A_REVERSE    = NCURSES_BITS(uint32(1),10)
const A_BLINK      = NCURSES_BITS(uint32(1),11)
const A_DIM        = NCURSES_BITS(uint32(1),12)
const A_BOLD       = NCURSES_BITS(uint32(1),13)
const A_ALTCHARSET = NCURSES_BITS(uint32(1),14)
const A_INVIS      = NCURSES_BITS(uint32(1),15)
const A_PROTECT    = NCURSES_BITS(uint32(1),16)
const A_HORIZONTAL = NCURSES_BITS(uint32(1),17)
const A_LEFT       = NCURSES_BITS(uint32(1),18)
const A_LOW        = NCURSES_BITS(uint32(1),19)
const A_RIGHT      = NCURSES_BITS(uint32(1),20)
const A_TOP        = NCURSES_BITS(uint32(1),21)
const A_VERTICAL   = NCURSES_BITS(uint32(1),22)

export A_NORMAL, A_ATTRIBUTES, A_CHARTEXT, A_COLOR, A_STANDOUT, A_UNDERLINE, A_REVERSE, A_BLINK, A_DIM, A_BOLD, A_ALTCHARSET, A_INVIS, A_PROTECT, A_HORIZONTAL, A_LEFT, A_LOW, A_TOP, A_VERTICAL

# not really used. See getmouse() hack in ccall.jl
NCURSES_MOUSE_MASK(b,m) = m<<((b-1)*6) # NCURSES_MOUSE_VERSION=1
const NCURSES_BUTTON_PRESSED = uint32(2)
const BUTTON1_PRESSED = NCURSES_MOUSE_MASK( 1, NCURSES_BUTTON_PRESSED )
const BUTTON2_PRESSED = NCURSES_MOUSE_MASK( 2, NCURSES_BUTTON_PRESSED )
const BUTTON3_PRESSED = NCURSES_MOUSE_MASK( 3, NCURSES_BUTTON_PRESSED )
const BUTTON4_PRESSED = NCURSES_MOUSE_MASK( 4, NCURSES_BUTTON_PRESSED )
const REPORT_MOUSE_POSITION = NCURSES_MOUSE_MASK( 5, 8 ) # NCURSES_MOUSE_VERSION=1

export NCURSES_MOUSE_MASK, NCURSES_BUTTON_PRESSED, BUTTON1_PRESSED, BUTTON2_PRESSED, BUTTON3_PRESSED, BUTTON4_PRESSED, REPORT_MOUSE_POSITION

function version()
    nc_ver = ccall((:curses_version, ncurses) , Ptr{UInt8}, ())
    if nc_ver != C_NULL
        NCURSES_VERSION = bytestring(nc_ver)
    end
    NCURSES_VERSION
end

function __init__()
  version()
end

function initscr()
    ccall((:initscr, ncurses ), Ptr{Void}, () )
end

function endwin()
    ccall((:endwin, ncurses), Int, () )
end

function isendwin()
    ccall((:isendwin, ncurses), Bool, () )
end

function newwin( lines::Int, cols::Int, origy::Int, origx::Int )
    ccall((:newwin, ncurses), Ptr{Void}, ( Int, Int, Int, Int ),
        lines, cols, origy, origx )
end

function subwin(win::Ptr{Void}, lines::Int, cols::Int, origy::Int, origx::Int )
    ccall((:subwin, ncurse ), Ptr{Void}, ( Ptr{Void}, Int, Int, Int, Int ),
        win, lines, cols, origy, origx )
end

function derwin( win, lines::Int, cols::Int, origy::Int, origx::Int )
    ccall((:derwin, ncurses ), Ptr{Void}, ( Ptr{Void}, Int, Int, Int, Int ),
        win, lines, cols, origy, origx )
end

function delwin( win::Ptr{Void} )
    ccall((:delwin, ncurses ), Void, ( Ptr{Void}, ), win )
end

function mvwaddch( win, y::Int, x::Int, c )
    ccall((:mvwaddch, ncurses), Void,
        ( Ptr{Void}, Int, Int, Int ), win, y, x, c )
end

function mvwprintw( win::Ptr{Void}, row::Int, height::Int, fmt::String, str::String )
    ccall((:mvwprintw, ncurses), Void,
        ( Ptr{Void}, Int, Int, Ptr{Uint8}, Ptr{Uint8}),
        win, row, height, fmt, str )
end

function printw( str::String )
    ccall((:printw, ncurses, ncurses), Void, (Ptr{Uint8},), str )
end

function mvprintw( row::Int, height::Int, str::String )
    ccall((:printw, ncurses), Void, (Int, Int, Ptr{Uint8}), row, height, str )
end

function wprintw( win::Ptr{Void} , str::String )
    ccall((:printw, ncurses), Void, (Ptr{Void}, Ptr{Uint8}), win, str )
end

function wmove( win, y::Int, x::Int )
    ccall((:wmove, ncurses), Int, ( Ptr{Void}, Int, Int ), win, y, x )
end

function wrefresh( win::Ptr{Void} )
    ccall((:wrefresh, ncurses ), Void, ( Ptr{Void}, ), win )
end

function touchwin( win::Ptr{Void} )
    ccall((:touchwin, ncurses ), Void, ( Ptr{Void}, ), win )
end

function refresh()
    ccall((:refresh, ncurses ), Void, ( ) )
end

function erase()
    ccall((:erase, ncurses ), Void, () )
end

function werase( win::Ptr{Void} )
    ccall((:werase, ncurses ), Void, (Ptr{Void},), win )
end

function wclear( win::Ptr{Void} )
    ccall((:wclear, ncurses ), Void, (Ptr{Void},), win )
end

function box( win, vchr, hchr )
    ccall((:box, ncurses ), Void, (Ptr{Void}, Char, Char), win, vchr, hchr )
end

function wgetch( win::Ptr{Void } )
    ccall((:wgetch, ncurses ), Uint32, (Ptr{Void},), win )
end

function keypad( win, bf )
    ccall((:keypad, ncurses ), Int, (Ptr{Void}, Bool), win, bf )
end

function cbreak()
    ccall((:cbreak, ncurses), Void, ( ) )
end

function nocbreak()
    ccall((:nocbreak, ncurses), Void, ( ) )
end

function echo()
    ccall((:echo, ncurses), Void, ( ) )
end

function noecho()
    ccall((:noecho, ncurses), Void, ( ) )
end

function nodelay( win, bf )
    ccall((:nodelay, ncurses ), Int, (Ptr{Void}, Bool), win, bf )
end

function raw()
    ccall((:raw, ncurses ), Int, () )
end

function noraw()
    ccall((:noraw, ncurses ), Int, () )
end

function notimeout( win, bf )
    ccall((:notimeout, ncurses ), Int, (Ptr{Void}, Bool), win, bf )
end

function timeout( delay::Int )
    ccall((:timeout, ncurses ), Void, (Int,), delay )
end

function wtimeout( win, delay::Int )
    ccall((:wtimeout, ncurses ), Void, (Ptr{Void}, Int), win, delay )
end

# not standard but convenient
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

function mvwin( win, y::Int, x::Int )
    ccall((:mvwin, ncurses), Int, ( Ptr{Void}, Int, Int ), win, y, x )
end

function beep()
    ccall((:beep, ncurses ), Void, () )
end

function flash()
    ccall((:flash, ncurses), Void, () )
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

function start_color()
    ccall((:start_color, ncurses), Void, () )
end

function init_pair( pair, f, b )
    ccall((:init_pair, ncurses), Int, ( Int16, Int16, Int16 ), pair, f, b )
end

function init_color( color, r,g,b )
    ccall((:init_color, ncurses), Int, ( Int16, Int16, Int16, Int16 ),
        color, r,g,b )
end

function has_colors()
    ccall((:has_colors, ncurses), Bool, () )
end

function wattroff( win, attrs )
    ccall((:wattroff, ncurses), Int, ( Ptr{Void}, Uint32 ), win, attrs )
end

function wattron( win, attrs )
    ccall((:wattron, ncurses), Int, ( Ptr{Void}, Uint32 ), win, attrs )
end

function wattrset( win, attrs )
    ccall((:wattrset, ncurses), Int, ( Ptr{Void}, Uint32 ), win, attrs )
end

function wbkgdset( win, ch )
    ccall((:wbkgdset, ncurses ), Void, ( Ptr{Void}, Uint32 ), win, ch )
end

function wbkgd( win, ch )
    ccall((:wbkgd, ncurses ), Void, ( Ptr{Void}, Uint32 ), win, ch )
end

function curs_set( vis )
    ccall((:curs_set, ncurses), Int, ( Int, ), vis )
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

function baudrate()
    ccall((:baudrate, ncurses), Int, () )
end

function clearok( win, bf )
    ccall((:clearok, ncurses), Int, ( Ptr{Void}, Bool ), win, bf )
end

function immedok( win, bf )
    ccall((:immedok, ncurses), Int, ( Ptr{Void}, Bool ), win, bf )
end

function napms( ms::Int )
    ccall((:napms, ncurses), Int, (Int, ), ms )
end

#===== PANEL library ====#

function update_panels()
    ccall((:update_panels, npanel), Void, () )
end

function doupdate()
    ccall((:doupdate, npanel ), Void, () )
end

function new_panel( win::Ptr{Void} )
    ccall((:new_panel, npanel ), Ptr{Void}, ( Ptr{Void}, ), win )
end

function top_panel( pan::Ptr{Void} )
    ccall((:top_panel, npanel ), Int, ( Ptr{Void}, ), pan )
end

function bottom_panel( pan::Ptr{Void} )
    ccall((:bottom_panel, npanel ), Int, ( Ptr{Void}, ), pan )
end

function move_panel( pan::Ptr{Void}, starty::Int, startx::Int )
    ccall((:move_panel, npanel ), Ptr{Void}, ( Ptr{Void}, Int, Int ), pan, starty, startx )
end

function del_panel( panel::Ptr{Void} )
    ccall((:del_panel, npanel ), Void, (Ptr{Void}, ), panel )
end

function show_panel( panel::Ptr{Void} )
    ccall((:show_panel, npanel ), Int, (Ptr{Void}, ), panel )
end

function hide_panel( panel::Ptr{Void} )
    ccall((:hide_panel ), Int, (Ptr{Void}, ), panel )
end

function panel_hidden( panel::Ptr{Void } )
    ccall((:panel_hidden, npanel ), Int, (Ptr{Void}, ), panel ) != 0
end

function replace_panel( panel::Ptr{Void}, window::Ptr{Void} )
    ccall((:replace_panel ), Void, (Ptr{Void}, Ptr{Void} ), panel, window )
end

function set_panel_userptr( p1::Ptr{Void}, p2::Ptr{Void} )
    ccall((:set_panel_userptr), Void, (Ptr{Void}, Ptr{Void}), p1, p2 )
end

function wborder( win::Ptr{Void},ls::chtype,rs::chtype,ts::chtype,bs::chtype,tl::chtype,tr::chtype,bl::chtype,br::chtype)
    ccall((:wborder, npanel), Int, (Ptr{Void}, Uint8, Uint8, Uint8, Uint8, Uint8, Uint8, Uint8, Uint8), ls, rs,ts, bs, tl, tr, bl, br)
end

export initscr, endwin, isendwin, newwin, subwin, delwin, derwin, werase, erase, refresh, mvwaddch, wclear, mvwprintw, touchwin, wmove, box, wrefresh, wgetch, nocbreak, keypad, nodelay, noecho, cbreak, echo, raw, noraw, timeout, notimeout, mvwin, getwinbegyx, beep, wtimeout, flash, getwinmaxyx, is_term_resized, wresize, getcuryx, start_color, init_pair, init_color, has_colors, wattroff, wattron, wattrset, wbkgdset, wbkgd, curs_set, has_mouse, mousemask, mouseinterval, getmouse, mouseByteString, baudrate, clearok, immedok, napms, update_panels, doupdate, new_panel, top_panel, bottom_panel, hide_panel, move_panel, del_panel, show_panel, panel_hidden, replace_panel, set_panel_userptr

end

# end # module
#
# module nc

# add_lib(Library(:ncurses,"libncursestw"))
# add_lib(Library(:form, "libformtw"))
# add_lib(Library(:menu, "libmenutw"))
# add_lib(Library(:panel, "libpaneltw"))
# add_lib(Library(:cdk, "libcdk.dylib.6.0.4"))

# ncurses = get_lib(:ncurses)
# panel = get_lib(:panel)
# form = get_lib(:form)
# menu = get_lib(:menu)
# cdk = get_lib(:cdk)

# NCURSES_VERSION = ""

# export panel, form, menu, NCURSES_VERSION
