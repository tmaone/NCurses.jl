const NCURSES_VERSION_MAJOR = 5
const NCURSES_VERSION_MINOR = 9
const NCURSES_VERSION_PATCH = 20150214

const NCURSES_VERSION = "$(NCURSES_VERSION_MAJOR).$(NCURSES_VERSION_MINOR)"

const NCURSES_MOUSE_VERSION = 2
const NCURSES_OPAQUE = 1
const NCURSES_REENTRANT = 1
const NCURSES_INTEROP_FUNCS = 1
const NCURSES_TPARM_VARARGS = 1
const NCURSES_EVENT_VERSION	= 1
const NCURSES_EXT_COLORS = 20150214
const CCHARW_MAX	= 5
const TRUE	= 1
const FALSE	= 0
const NCURSES_WIDECHAR	= 1
const NCURSES_ATTR_SHIFT = 8

typealias NCURSES_COLOR_T Cshort
typealias NCURSES_PAIRS_T Cshort
typealias NCURSES_SIZE_T Cshort
typealias NCURSES_TPARM_ARG Clong
# typealias NCURSES_BOOL Cuchar
typealias NCURSES_BOOL Bool # should be compiler's option
typealias chtype Cuint
typealias	attr_t chtype
typealias mmask_t Culong

type cchar_t
  attr::Ptr{attr_t}
  # attr::attr_t
  chars::Array{Cwchar_t, CCHARW_MAX}
  ext_color::Cint
end

typealias NCURSES_CH_T cchar_t # cchar_t

# function NCURSES_CAST(type, value)
#   type(value)
# end
#

COLOR_PAIR( n ) = NCURSES_BITS(n, 0)

function NCURSES_BITS( m, shf)
    m << (shf + NCURSES_ATTR_SHIFT)
end

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
const A_ITALIC     = NCURSES_BITS(uint32(1),23)

const WA_ATTRIBUTES	= A_ATTRIBUTES
const WA_NORMAL	= A_NORMAL
const WA_STANDOUT	= A_STANDOUT
const WA_UNDERLINE	= A_UNDERLINE
const WA_REVERSE	= A_REVERSE
const WA_BLINK	=A_BLINK
const WA_DIM	=	A_DIM
const WA_BOLD	=	A_BOLD
const WA_ALTCHARSET=	A_ALTCHARSET
const WA_INVIS	=A_INVIS
const WA_PROTECT	=A_PROTECT
const WA_HORIZONTAL=	A_HORIZONTAL
const WA_LEFT=		A_LEFT
const WA_LOW	=	A_LOW
const WA_RIGHT=	A_RIGHT
const WA_TOP	=	A_TOP
const WA_VERTICAL=	A_VERTICAL
const WA_ITALIC=	A_ITALIC

const COLOR_BLACK   = 0
const COLOR_RED     = 1
const COLOR_GREEN   = 2
const COLOR_YELLOW  = 3
const COLOR_BLUE    = 4
const COLOR_MAGENTA = 5
const COLOR_CYAN    = 6
const COLOR_WHITE   = 7

# not really used. See getmouse() hack in ccall.jl
NCURSES_MOUSE_MASK(b,m) = m<<((b-1)*6)

const NCURSES_BUTTON_PRESSED = uint32(2)
const BUTTON1_PRESSED = NCURSES_MOUSE_MASK( 1, NCURSES_BUTTON_PRESSED )
const BUTTON2_PRESSED = NCURSES_MOUSE_MASK( 2, NCURSES_BUTTON_PRESSED )
const BUTTON3_PRESSED = NCURSES_MOUSE_MASK( 3, NCURSES_BUTTON_PRESSED )
const BUTTON4_PRESSED = NCURSES_MOUSE_MASK( 4, NCURSES_BUTTON_PRESSED )
const REPORT_MOUSE_POSITION = NCURSES_MOUSE_MASK( 5, 8 )

const ERR = -1
const OK  = 0

const _SUBWIN = 0x01
const _ENDLINE   = 0x02
const _FULLWIN   = 0x04
const _SCROLLWIN = 0x08
const _ISPAD	   = 0x10
const _HASMOVED  = 0x20
const _WRAPPED   = 0x40

const _NOCHANGE = -1
const _NEWINDEX = -1


type ldat

end

type pdat
  _pad_y::NCURSES_SIZE_T
  _pad_x::NCURSES_SIZE_T
  _pad_top::NCURSES_SIZE_T
  _pad_left::NCURSES_SIZE_T
  _pad_bottom::NCURSES_SIZE_T
  _pad_right::NCURSES_SIZE_T
end


type _win_st

  _cury::NCURSES_SIZE_T
  _curx::NCURSES_SIZE_T

  _maxy::NCURSES_SIZE_T
  _maxx::NCURSES_SIZE_T
  _begy::NCURSES_SIZE_T
  _begx::NCURSES_SIZE_T

  _flags::Cshort
  _attrs::attr_t
  _bkgd::chtype

  _notimeout::NCURSES_BOOL
  _clear::NCURSES_BOOL
  _leaveok::NCURSES_BOOL
  _scroll::NCURSES_BOOL
  _idlok::NCURSES_BOOL
  _idcok::NCURSES_BOOL
  _immed::NCURSES_BOOL
  _sync::NCURSES_BOOL
  _use_keypad::NCURSES_BOOL
  _delay::Cint

  _line::Ptr{ldat}

  _regtop::NCURSES_SIZE_T
  _regbottom::NCURSES_SIZE_T

  _parx::Cint
  _pary::Cint
  _parent::Ptr{Void}

  _pad::pdat
  _yoffset::NCURSES_SIZE_T
  _bkgrnd::cchar_t
  _color::Cint

end

typealias WINDOW _win_st

const _NC_EVENT_TIMEOUT_MSEC = 1
const _NC_EVENT_FILE = 2
const _NC_EVENT_FILE_READABLE = 2
#  Not supported yet... *
const _NC_EVENT_FILE_WRITABLE = 4
const _NC_EVENT_FILE_EXCEPTION = 8

type _nc_event
  _type::Cint
  type data
    timeout_msec::Clong
    type fev
        flags::Cuint
        fd::Cint
        result::Cuint
    end
  end
end

type _nc_eventlist
  count::Cint
  result_flags::Cint
  events::Ptr{Array{_nc_event, 1}}
end



# type SCREEN
#   # screen
# end

export NCURSES_VERSION_MAJOR, NCURSES_VERSION_MINOR, NCURSES_VERSION_PATCH, NCURSES_VERSION,NCURSES_MOUSE_VERSION, NCURSES_OPAQUE, NCURSES_REENTRANT, NCURSES_INTEROP_FUNCS, NCURSES_TPARM_VARARGS, NCURSES_EXT_COLORS, CCHARW_MAX, TRUE, FALSE, NCURSES_WIDECHAR, NCURSES_ATTR_SHIFT, NCURSES_COLOR_T, NCURSES_PAIRS_T, NCURSES_SIZE_T, NCURSES_TPARM_ARG, NCURSES_BOOL, chtype, attr_t, mmask_t, cchar_t, NCURSES_CH_T, COLOR_PAIR, A_NORMAL, A_ATTRIBUTES, A_CHARTEXT, A_COLOR, A_STANDOUT, A_UNDERLINE, A_REVERSE, A_BLINK, A_DIM, A_BOLD, A_ALTCHARSET, A_INVIS, A_PROTECT, A_HORIZONTAL, A_LEFT, A_LOW, A_RIGHT, A_TOP, A_VERTICAL, A_ITALIC, WA_ATTRIBUTES, WA_NORMAL, WA_STANDOUT, WA_UNDERLINE, WA_REVERSE, WA_BLINK, WA_DIM, WA_BOLD, WA_ALTCHARSET, WA_INVIS, WA_PROTECT, WA_HORIZONTAL, WA_LEFT, WA_LOW, WA_RIGHT, WA_TOP, WA_VERTICAL, WA_ITALIC, COLOR_BLACK, COLOR_RED, COLOR_GREEN, COLOR_YELLOW, COLOR_BLUE, COLOR_MAGENTA, COLOR_CYAN, COLOR_WHITE, NCURSES_MOUSE_MASK, NCURSES_BUTTON_PRESSED, BUTTON1_PRESSED, BUTTON2_PRESSED, BUTTON3_PRESSED, BUTTON4_PRESSED, REPORT_MOUSE_POSITION, ERR, OK, _SUBWIN, _ENDLINE, _FULLWIN, _SCROLLWIN, _ISPAD, _HASMOVED, _WRAPPED, _NOCHANGE, _NEWINDEX, ldat, pdat, _win_st, WINDOW, _NC_EVENT_TIMEOUT_MSEC, _NC_EVENT_FILE, _NC_EVENT_FILE_READABLE, _NC_EVENT_FILE_WRITABLE, _NC_EVENT_FILE_EXCEPTION, _nc_event, _nc_eventlist, wgetch_events, wgetch_events
