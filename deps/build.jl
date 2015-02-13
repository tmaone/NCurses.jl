using BinDeps

@BinDeps.setup

const ncurses_install_version = "5.9"

libnames = ["libncursess", "libncursesw", "libncursestw"]
suffixes = ["", "-5.9", "5.9", "5.4", "6", ".6."]
options = [""]
extensions = ["", ".a", ".so.5", ".dylib"]
aliases = vec(libnames.*transpose(suffixes).*reshape(options,(1,1,length(options))).*reshape(extensions,(1,1,1,length(extensions))))

deps = [
  ncurses = library_dependency("ncurses", aliases = aliases)
]

provides(Sources, {
URI("http://ftp.gnu.org/pub/gnu/ncurses/ncurses-5.9.tar.gz") => ncurses
})

ncurses_home = get(ENV, "NCURSES_HOME", "") # If MAGICK_HOME is defined, add to library search path

if !isempty(ncurses_home)
    push!(DL_LOAD_PATH, ncurses_home)
    push!(DL_LOAD_PATH, joinpath(ncurses_home,"lib"))
end

@linux_only begin
    provides(AptGet, "ncurses", ncurses)
    provides(AptGet, "ncurses", ncurses)
    provides(Pacman, "ncurses", ncurses)
    provides(Yum, "ncurses", ncurses)
end

@windows_only begin
    const OS_ARCH = (WORD_SIZE == 64) ? "x64" : "x86"
end

@osx_only begin
    # if Pkg.installed("Homebrew") === nothing
    #         error("Homebrew package not installed, please run Pkg.add(\"Homebrew\")")
    # end
    # using Homebrew
    # provides( Homebrew.HB, "imagemagick", libwand, os = :Darwin, onload =
    # """
    # function __init__()
    #     ENV["MAGICK_CONFIGURE_PATH"] = joinpath("$(Homebrew.prefix("imagemagick"))","lib","ImageMagick","config-Q16")
    #     ENV["MAGICK_CODER_MODULE_PATH"] = joinpath("$(Homebrew.prefix("imagemagick"))", "lib","ImageMagick","modules-Q16","coders")
    #     ENV["PATH"] *= ":" * joinpath("$(Homebrew.prefix("imagemagick"))", "bin")
    # end
    # """ )
end


prefix = BinDeps.depsdir(ncurses)
ncurses_install_name = "ncurses-5.9"
srcdir = joinpath(BinDeps.depsdir(ncurses), ncurses_install_name)
patch_dir   = joinpath(srcdir, "c++")
patch_file = joinpath(patch_dir, "c++", "ncurses-5.9.patch")
patch_file_src = "https://trac.macports.org/export/103963/trunk/dports/devel/ncurses/files/constructor_types.diff"

provides(BuildProcess,
        (@build_steps begin
          CreateDirectory(srcdir)
          GetSources(ncurses)
          @build_steps begin
              ChangeDirectory(srcdir)
              @osx_only begin
                ChangeDirectory(patch_dir)
                run(download_cmd(patch_file_src, patch_file))
                ChangeDirectory(joinpath(srcdir, "c++"))
                run(`patch -p1 --dry-run` < `ncurses-5.9.patch`)
              end
              `./configure --prefix=$prefix --enable-dependency-linking --enable-pc-files --enable-sigwinch --enable-symlinks --enable-widec --with-manpage-format=normal --with-shared --enable-ext-colors --enable-ext-mouse --enable-getcap --enable-hard-tabs --enable-interop --enable-reentrant --with-pthread --enable-symlinks --enable-termcap --with-sysmouse --with-tlib=ncurses`
            `make`
            `make install`
            end
        end), ncurses)

@BinDeps.install Dict([(:ncurses => :ncurses)])

module CheckVersion
include("deps.jl")
if isdefined(:__init__)
    __init__()
end
nc_ver = ccall((:curses_version, ncurses), Ptr{UInt8}, ())
if nc_ver == C_NULL
    ver_str = split(bytestring(nc_ver), ' ')
    ver_str_name = ver_str[1]
    ver_str_num  = ver_str[2]
    ver_num = split(ver_str_num, '.')
    major = ver_num[1]
    minor = ver_num[2]
    build = ver_num[3]
    vstr = string("v\"", join([major,minor,build], '.'), "\"")
    open(joinpath(dirname(@__FILE__),"versioninfo.jl"), "w") do file
        write(file, "const libversion = $vstr\n")
    end
    NCURSES_VERSION = vstr
    println("NCurses Library Found, Version [$(vstr)")
end

# vstr = string("v\"", join(split(bytestring(p), ',')[1:3], '.'), "\"")
# open(joinpath(dirname(@__FILE__),"versioninfo.jl"), "w") do file
    # write(file, "const libversion = $vstr\n")
# end
end

# prefix=joinpath(BinDeps.depsdir(libncurses),"usr")
# ncurses-5.9
# ncurses_src_dir = joinpath(BinDeps.depsdir(libncurses),"src","ncurses-$ncurses_version")
# # ncurses_build_dir = joinpath(BinDeps.depsdir(libncurses),"build","libpng-$png_version")
#
# prefix=joinpath(BinDeps.depsdir(libpng),"usr")
# uprefix = replace(replace(prefix,"\\","/"),"C:/","/c/")
# pngsrcdir = joinpath(BinDeps.depsdir(libpng),"src","ncurses-$ncurses_version")
# pngbuilddir = joinpath(BinDeps.depsdir(libpng),"builds","libpng-$png_version")
# provides(BuildProcess,
#   (@build_steps begin
#     GetSources(libpng)
#     CreateDirectory(pngbuilddir)
#     @build_steps begin
#       ChangeDirectory(pngbuilddir)
#       FileRule(joinpath(prefix,"lib","libpng15.dll"),@build_steps begin
#         `cmake -DCMAKE_INSTALL_PREFIX="$prefix" -G"MSYS Makefiles" $pngsrcdir`
#         `make`
#         `cp libpng*.dll $prefix/lib`
#         `cp libpng*.a $prefix/lib`
#         `cp libpng*.pc $prefix/lib/pkgconfig`
#         `cp pnglibconf.h $prefix/include`
#         `cp $pngsrcdir/png.h $prefix/include`
#         `cp $pngsrcdir/pngconf.h $prefix/include`
#       end)
#     end
#   end),libpng, os = :Windows)
