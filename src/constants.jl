const NCURSES_VERSION_MAJOR = 5
const NCURSES_VERSION_MINOR = 9
const NCURSES_VERSION_PATCH = 20150214

const NCURSES_VERSION = "5.9"

const NCURSES_MOUSE_VERSION = 2

export NCURSES_VERSION_MAJOR, NCURSES_VERSION_MINOR, NCURSES_VERSION_PATCH, NCURSES_VERSION, NCURSES_MOUSE_VERSION

const NCURSES_OPAQUE = 1
const NCURSES_REENTRANT = 1
const NCURSES_INTEROP_FUNCS = 1
const NCURSES_TPARM_VARARGS = 1
const NCURSES_EXT_COLORS = 20150214
const CCHARW_MAX	= 5
const TRUE	= 1
const FALSE	= 0
const NCURSES_WIDECHAR	= 1

typealias NCURSES_COLOR_T Cshort
typealias NCURSES_PAIRS_T Cshort
typealias NCURSES_SIZE_T Cshort
typealias NCURSES_TPARM_ARG Clong
typealias chtype Cuint
typealias	attr_t chtype

type cchar_t
  attr::Ptr{attr_t}
  # attr::attr_t
  chars::Array{Cwchar_t, 5}
  ext_color::Cint
end

typealias NCURSES_CH_T cchar_t # cchar_t
typealias mmask_t Culong
typealias NCURSES_BOOL Cuchar

function NCURSES_CAST( type, value)
  (type)(value)
end

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



# const COLOR_BLACK   = 0
# const COLOR_RED     = 1
# const COLOR_GREEN   = 2
# const COLOR_YELLOW  = 3
# const COLOR_BLUE    = 4
# const COLOR_MAGENTA = 5
# const COLOR_CYAN    = 6
# const COLOR_WHITE   = 7
#
# export COLOR_BLACK, COLOR_RED, COLOR_GREEN, COLOR_YELLOW, COLOR_BLUE, COLOR_MAGENTA, COLOR_CYAN, COLOR_WHITE


#define	E_OK			(0)
#define	E_SYSTEM_ERROR	 	(-1)
#define	E_BAD_ARGUMENT	 	(-2)
#define	E_POSTED	 	(-3)
#define	E_CONNECTED	 	(-4)
#define	E_BAD_STATE	 	(-5)
#define	E_NO_ROOM	 	(-6)
#define	E_NOT_POSTED		(-7)
#define	E_UNKNOWN_COMMAND	(-8)
#define	E_NO_MATCH		(-9)
#define	E_NOT_SELECTABLE	(-10)
#define	E_NOT_CONNECTED	        (-11)
#define	E_REQUEST_DENIED	(-12)
#define	E_INVALID_FIELD	        (-13)
#define	E_CURRENT		(-14)

# typealias chtype UInt8
#
# COLOR_PAIR( n ) = NCURSES_BITS(n, 0)
# export COLOR_PAIR
#
# const NCURSES_ATTR_SHIFT = 8
# function NCURSES_BITS( m, shf)
#     m << (shf + NCURSES_ATTR_SHIFT)
# end
# export NCURSES_BITS
#
# const A_NORMAL     = uint32(0)
# const A_ATTRIBUTES = ~uint32(0)
# const A_CHARTEXT   = (NCURSES_BITS(uint32(1),0) - uint32(1))
# const A_COLOR      = NCURSES_BITS((uint32(1) << 8) - uint32(1),0)
# const A_STANDOUT   = NCURSES_BITS(uint32(1),8)
# const A_UNDERLINE  = NCURSES_BITS(uint32(1),9)
# const A_REVERSE    = NCURSES_BITS(uint32(1),10)
# const A_BLINK      = NCURSES_BITS(uint32(1),11)
# const A_DIM        = NCURSES_BITS(uint32(1),12)
# const A_BOLD       = NCURSES_BITS(uint32(1),13)
# const A_ALTCHARSET = NCURSES_BITS(uint32(1),14)
# const A_INVIS      = NCURSES_BITS(uint32(1),15)
# const A_PROTECT    = NCURSES_BITS(uint32(1),16)
# const A_HORIZONTAL = NCURSES_BITS(uint32(1),17)
# const A_LEFT       = NCURSES_BITS(uint32(1),18)
# const A_LOW        = NCURSES_BITS(uint32(1),19)
# const A_RIGHT      = NCURSES_BITS(uint32(1),20)
# const A_TOP        = NCURSES_BITS(uint32(1),21)
# const A_VERTICAL   = NCURSES_BITS(uint32(1),22)
#
# export A_NORMAL, A_ATTRIBUTES, A_CHARTEXT, A_COLOR, A_STANDOUT, A_UNDERLINE, A_REVERSE, A_BLINK, A_DIM, A_BOLD, A_ALTCHARSET, A_INVIS, A_PROTECT, A_HORIZONTAL, A_LEFT, A_LOW, A_TOP, A_VERTICAL
#
# # not really used. See getmouse() hack in ccall.jl
# NCURSES_MOUSE_MASK(b,m) = m<<((b-1)*6) # NCURSES_MOUSE_VERSION=1
# const NCURSES_BUTTON_PRESSED = uint32(2)
# const BUTTON1_PRESSED = NCURSES_MOUSE_MASK( 1, NCURSES_BUTTON_PRESSED )
# const BUTTON2_PRESSED = NCURSES_MOUSE_MASK( 2, NCURSES_BUTTON_PRESSED )
# const BUTTON3_PRESSED = NCURSES_MOUSE_MASK( 3, NCURSES_BUTTON_PRESSED )
# const BUTTON4_PRESSED = NCURSES_MOUSE_MASK( 4, NCURSES_BUTTON_PRESSED )
# const REPORT_MOUSE_POSITION = NCURSES_MOUSE_MASK( 5, 8 ) # NCURSES_MOUSE_VERSION=1
#
# export NCURSES_MOUSE_MASK, NCURSES_BUTTON_PRESSED, BUTTON1_PRESSED, BUTTON2_PRESSED, BUTTON3_PRESSED, BUTTON4_PRESSED, REPORT_MOUSE_POSITION
