# julia ncurses interface
# TODO:
# - examine the option to use Clang.jl's C wrapper generator
#   * so far I can spot a few reasons why this option wouldn't work

module NCurses

using Base
using BinDeps
using Compat

# The following loads "../deps/build.jl" and forces re-install of library
# this explains why other modules prefer to load deps.jl instead.
# @BinDeps.load_dependencies "../deps/deps.jl" [:ncurses] # not working as expected

if isfile(joinpath(dirname(dirname(@__FILE__)),"deps","deps.jl"))
  include("../deps/deps.jl")
else
  error("NCurses not properly installed. Please run Pkg.build(\"NCurses\")")
end

# think if it is needed to do this, or should we leave it to each application
function __init__()
    err = ccall((:initscr, ncurses), Ptr{Void}, ())
    err != C_NULL || error("error initializing NCurses module")
    atexit() do
        ccall((:endwin, ncurses), Ptr{Void}, ())
    end
end

include("constants.jl")
include("curses.jl")
include("form.jl")
include("menu.jl")
include("panel.jl")

function version()
    nc_ver = ccall((:curses_version, ncurses) , Ptr{UInt8}, ())
    if nc_ver != C_NULL
        return bytestring(nc_ver)
      else
        return ""
    end
end

end

# end # module
