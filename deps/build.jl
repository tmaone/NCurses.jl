using BinDeps

@BinDeps.setup

# The intention is to, where available, use the 'tw' version so in most cases we will compile a local library.

const nc_major = 5
const nc_minor = 9
const nc_patch = 20150214

const nc_version = "$(nc_major).$(nc_minor)"
const nc_version_patch = "$(nc_version)-$(nc_patch)"

const nc_lib = ["libcurses", "libncurses"]
const nctw_lib = ["libncursestw", "libncursest", "libncursesw"]

const nc_panel_lib = ["libpanel", "libpaneltw"]
const nc_form_lib = ["libform", "libformtw"]
const nc_menu_lib = ["libmenu", "libmenutw"]

const suffixes = ["", ".6", "-5.9", ".5.9", ".5.4", ".5", ".$(nc_version)"]

const options = [""]

const extensions = ["", ".$(BinDeps.shlib_ext)" ]

const installed_file = "installed_version"

const NCURSES_MODE = get(ENV, "NCURSES_MODE", "")

aliases_ncurses = vec(nc_lib.*transpose(suffixes).*reshape(options,(1,1,length(options))).*reshape(extensions,(1,1,1,length(extensions))))

aliases_ncursestw = vec(nctw_lib.*transpose(suffixes).*reshape(options,(1,1,length(options))).*reshape(extensions,(1,1,1,length(extensions))))

alias_nc_panel = [nc_panel_lib[1]*""*extensions[2]]
alias_nc_paneltw = [nc_panel_lib[2]*""*extensions[2]]
alias_nc_form = [nc_form_lib[1]*""*extensions[2]]
alias_nc_formtw = [nc_form_lib[2]*""*extensions[2]]
alias_nc_menu = [nc_menu_lib[1]*""*extensions[2]]
alias_nc_menutw = [nc_menu_lib[2]*""*extensions[2]]

if NCURSES_MODE == "tw" || NCURSES_MODE == "w" || NCURSES_MODE == "t"

  info("NCurses-extra library enabled. [$NCURSES_MODE]")
  # Now we define build steps for our tuned version. The idea
  # is to start with one build target, with os differentiation coming
  # to place upon necessity
  ncurses = library_dependency("ncurses", aliases = aliases_ncursestw)

  provides(Sources, URI("http://invisible-mirror.net/archives/ncurses/current/ncurses-$(nc_version_patch).tgz"), SHA="c88fecbf91b94faa1de7dc3192ad2fd227eeed1648c5daa736119b9a7ff08e07", ncurses)

  prefix = BinDeps.usrdir(ncurses)
  provides( BuildProcess,
  Autotools(
  libtarget = [ "lib/libncursestw.$(BinDeps.shlib_ext)",
  "lib/libformtw.$(BinDeps.shlib_ext)",
  "lib/libmenutw.$(BinDeps.shlib_ext)",
  "lib/libpaneltw.$(BinDeps.shlib_ext)" ],
  configure_options = [
  "--prefix=$(prefix)",
  "--without-ada",
  "--without-cxx",
  "--without-cxx-binding",
  "--without-manpages",
  # "--with-manpage-format=normal",
  "--enable-dependency-linking",
  # "--enable-pc-files",
  "--enable-sigwinch",
  "--enable-symlinks",
  "--enable-rpath",
  "--enable-widec",
  "--with-shared",
  # "--with-normal",
  "--enable-ext-colors",
  "--enable-ext-mouse",
  "--enable-getcap",
  "--enable-hard-tabs",
  "--enable-term-driver",
  "--enable-interop",
  "--enable-reentrant",
  "--with-pthread",
  "--enable-termcap",
  "--with-sysmouse",
  "--enable-sp-funcs",
  "--enable-term-driver",
  "--enable-tcap-names",
  "--enable-const"
  ],
  prefix = prefix
  ), ncurses,
  onload =
  """
  function __init__()
    ENV["NCURSES_MODE"] = "tw"
  end
  """)

  if !(joinpath(prefix, "lib") in DL_LOAD_PATH)
      push!(DL_LOAD_PATH, joinpath(prefix, "lib") )
  end

  panel = library_dependency("panel", aliases = alias_nc_paneltw)
  form = library_dependency("form", aliases = alias_nc_formtw)
  menu = library_dependency("menu", aliases = alias_nc_menutw)

  @BinDeps.install Dict([(:ncurses => :ncurses), (:panel => :panel), (:form => :form), (:menu => :menu)])
  # @BinDeps.install Dict([(:ncurses => :ncurses), (:panel => :panel), (:form => :form), (:menu => :menu)])
else
  info("Using system ncurses library.")
  # We start adding the standard ncurses library, :win then :linux then :darwin
  @windows_only begin
    using WinRPM
    ncurses = library_dependency("ncurses", aliases = aliases_ncurses, os = :Windows)
    panel = library_dependency("panel", aliases = alias_nc_panel)
    form = library_dependency("form", aliases = alias_nc_form)
    menu = library_dependency("menu", aliases = alias_nc_menu)
    # find out if current build method works on Win.
    provides(WinRPM.RPM,"ncurses", ncurses, os = :Windows)
    # TODO: remove me when upstream is fixed
    warn("Not supported yet!")
  end
  @linux_only begin
    ncurses = library_dependency("ncurses", aliases = aliases_ncurses, os = :Linux)
    panel = library_dependency("panel", aliases = alias_nc_panel)
    form = library_dependency("form", aliases = alias_nc_form)
    menu = library_dependency("menu", aliases = alias_nc_menu)
    # TODO: Not sure, check if they are valid
    provides(AptGet, "ncurses", ncurses)
    provides(Pacman, "ncurses", ncurses)
    provides(Yum, "ncurses-devel", ncurses)
  end
  @osx_only begin
    # in osx a really old ncurses library resides in /usr/lib.
    # homebrew has ncurses in dupes, atm building through
    # homebrew is not an option threrefore we just add
    # this old ncurses lib for now by default
    ncurses = library_dependency("ncurses", aliases = aliases_ncurses, os = :Dawrin)
    panel = library_dependency("panel", aliases = alias_nc_panel)
    form = library_dependency("form", aliases = alias_nc_form)
    menu = library_dependency("menu", aliases = alias_nc_menu)
  end
  @BinDeps.install Dict([(:ncurses => :ncurses), (:panel => :panel), (:form => :form), (:menu => :menu)])
end
#
# # Now we define build steps for our tuned version. The idea
# # is to start with one build target, with os differentiation coming
# # to place upon necessity
#
# ncursestw = library_dependency("ncursestw", aliases = aliases_ncursestw)
#
# provides(Sources, URI("http://invisible-mirror.net/archives/ncurses/current/ncurses-$(ncurses_version)-$(nc_patch).tgz"), SHA="c88fecbf91b94faa1de7dc3192ad2fd227eeed1648c5daa736119b9a7ff08e07", ncursestw)
#
# prefix = BinDeps.usrdir(ncursestw)
#
# provides( BuildProcess,
#           Autotools(
#           libtarget = [ "lib/libncursestw.$(BinDeps.shlib_ext)",
#                         "lib/libformtw.$(BinDeps.shlib_ext)",
#                         "lib/libmenutw.$(BinDeps.shlib_ext)",
#                         "lib/libpaneltw.$(BinDeps.shlib_ext)" ],
#             configure_options = [
#                                 "--prefix=$(prefix)",
#                                 "--without-ada",
#                                 "--without-cxx",
#                                 "--without-cxx-binding",
#                                 "--without-manpages",
#                                 # "--with-manpage-format=normal",
#                                 "--enable-dependency-linking",
#                                 # "--enable-pc-files",
#                                 "--enable-sigwinch",
#                                 "--enable-symlinks",
#                                 "--enable-rpath",
#                                 "--enable-widec",
#                                 "--with-shared",
#                                 # "--with-normal",
#                                 "--enable-ext-colors",
#                                 "--enable-ext-mouse",
#                                 "--enable-getcap",
#                                 "--enable-hard-tabs",
#                                 "--enable-term-driver",
#                                 "--enable-interop",
#                                 "--enable-reentrant",
#                                 "--with-pthread",
#                                 "--enable-termcap",
#                                 "--with-sysmouse",
#                                 "--enable-sp-funcs",
#                                 "--enable-term-driver",
#                                 "--enable-tcap-names"
#                               ],
#                               force_rebuild = true,
#                               prefix = prefix
#           ), ncursestw)
#
# println(NCURSES_MODE)
#
# @BinDeps.install Dict([(:ncurses => :ncurses),(:ncursestw => :ncursestw)])

# Old build steps, will delete when current build script matures

# prefix = BinDeps.usrdir(ncursestw)
# srcdir = BinDeps.srcdir(ncursestw)
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

# ncurses = library_dependency("ncurses", aliases = aliases_ncurses)
# ncursestw = library_dependency("ncursestw", aliases = aliases_ncursestw)

# provides(Sources, {URI("http://invisible-mirror.net/archives/ncurses/current/ncurses-5.9-20150214.tgz") => ncursestw})
#
# ncurses_home = get(ENV, "NCURSES_HOME", "") # If NCURSES_HOME is defined, add to library search path
#
# if !isempty(ncurses_home)
#   push!(DL_LOAD_PATH, ncurses_home)
#   push!(DL_LOAD_PATH, joinpath(ncurses_home,"lib"))
# end

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
