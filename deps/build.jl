using BinDeps

@BinDeps.setup


# The intention is to, where available, use the 'tw' version so in most cases we will compile a local library.

const nc_major = 5
const nc_minor = 9
const nc_patch = 20150214

const ncurses_version = "$(nc_major).$(nc_minor)"
const ncursestw_version = "$(ncurses_version)-$(nc_patch)"

lib_ncurses_names = ["libcurses", "libncurses"]
lib_ncursestw_names = ["libncursestw", "libncursest", "libncursesw"]

suffixes = ["", ".6", "-5.9", ".5.9", ".5.4", ".5"]

options = [""]

extensions = ["", ".$(BinDeps.shlib_ext)" ]

installed_file = "installed_version"

aliases_ncurses = vec(lib_ncurses_names.*transpose(suffixes).*reshape(options,(1,1,length(options))).*reshape(extensions,(1,1,1,length(extensions))))

aliases_ncursestw = vec(lib_ncursestw_names.*transpose(suffixes).*reshape(options,(1,1,length(options))).*reshape(extensions,(1,1,1,length(extensions))))

@windows_only begin
  using WinRPM
  const OS_ARCH = (WORD_SIZE == 64) ? "x64" : "x86"
  provides(WinRPM.RPM,"ncurses", ncurses, os = :Windows)
  # find out if current build method works on Win.
  # TODO: remove me when upstream is fixed
  warn("Not supported yet!")
end

@unix_only begin

    ncurses = library_dependency("ncurses", aliases = aliases_ncurses)
    ncursestw = library_dependency("ncursestw", aliases = aliases_ncursestw)

    @linux_only begin

    end

    @osx_only begin

    end

end

# provides(Sources, {URI("http://invisible-mirror.net/archives/ncurses/current/ncurses-5.9-20150214.tgz") => ncursestw})
#
# ncurses_home = get(ENV, "NCURSES_HOME", "") # If NCURSES_HOME is defined, add to library search path
#
# if !isempty(ncurses_home)
#   push!(DL_LOAD_PATH, ncurses_home)
#   push!(DL_LOAD_PATH, joinpath(ncurses_home,"lib"))
# end
#
#
#
# @linux_only begin # TODO: Not sure, check if they are valid
#   provides(AptGet, "ncurses", ncurses)
#   provides(AptGet, "ncurses", ncurses)
#   provides(Pacman, "ncurses", ncurses)
#   provides(Yum, "ncurses", ncurses)
# end
#
# @windows_only begin
#   const OS_ARCH = (WORD_SIZE == 64) ? "x64" : "x86"
#   # TODO: remove me when upstream is fixed
#   error("Not supported")
# end
#
# @osx_only begin # if library functionality is satisfied using core calls then use classic HB package for ncurses
# # if Pkg.installed("Homebrew") === nothing
# #         error("Homebrew package not installed, please run Pkg.add(\"Homebrew\")")
# # end
# # using Homebrew
# # provides( Homebrew.HB, "ncurses", ncurses, os = :Darwin )
# end
#
# @osx_only begin # but try this custom build method (replicates brew formula patch) during initial module development
#
#   prefix = BinDeps.usrdir(ncursestw)
#   srcdir = BinDeps.srcdir(ncursestw)
#   srcdirnc = joinpath(srcdir, "ncurses-5.9")
#   dldir = BinDeps.downloadsdir(ncursestw)
#
#   lib_url = "http://ftp.gnu.org/pub/gnu/ncurses/ncurses-5.9.tar.gz"
#   lib_src_dl = joinpath(dldir, "ncurses-5.9.tar.gz")
#
#   patch_file_url = "https://trac.macports.org/export/103963/trunk/dports/devel/ncurses/files/constructor_types.diff"
#   patch_file_dl = joinpath(dldir, "ncurses-5.9.patch")
#
#   target = joinpath(prefix,"lib/libncursestw.$(BinDeps.shlib_ext)")
#
#   provides(SimpleBuild,(
#     @build_steps begin
#       GetSources(ncursestw)
#       FileDownloader(lib_url, lib_src_dl)
#       FileDownloader(patch_file_url, patch_file_dl)
#       CreateDirectory(srcdir, true)
#       FileUnpacker(lib_src_dl, srcdir, "ncurses-5.9")
#       @build_steps begin
#           ChangeDirectory(srcdirnc)
#           `patch -p0 c++/cursesf.h $patch_file_dl`
#       end
#       @build_steps begin
#           ChangeDirectory(srcdirnc)
#           `./configure --prefix=$prefix --without-cxx --without-cxx-binding --enable-dependency-linking --enable-pc-files --enable-sigwinch --enable-symlinks --enable-rpath --enable-widec --with-manpage-format=normal --with-shared --with-normal --enable-ext-colors --enable-ext-mouse --enable-getcap --enable-hard-tabs --enable-term-driver --enable-interop --enable-reentrant --with-pthread --enable-termcap --with-sysmouse`
#       end
#       @build_steps begin
#         ChangeDirectory(srcdirnc)
#         MakeTargets(["install"]) #`make install`
#       end
#   end), ncursestw, os = :Darwin)

# end

# @BinDeps.install Dict([(:ncursestw => :ncursestw)])

# module CheckVersion
#
# include("deps.jl")
#
# if isdefined(:__init__)
#   __init__()
# end
#
# nc_ver = ccall((:curses_version, ncurses), Ptr{UInt8}, ())
#
# if nc_ver != C_NULL
#   ver_str = split(bytestring(nc_ver), ' ')
#   ver_str_name = ver_str[1]
#   ver_str_num  = ver_str[2]
#   ver_num = split(ver_str_num, '.')
#   major = ver_num[1]
#   minor = ver_num[2]
#   build = ver_num[3]
#   vstr = string("v\"", join([major,minor,build], '.'), "\"")
#   open(joinpath(dirname(@__FILE__),"versioninfo.jl"), "w") do file
#   write(file, "const libversion = $vstr\n")
#   NCURSES_VERSION = vstr
#   println("NCurses Library Found, Version [$(vstr)]")
# end
#
# end
