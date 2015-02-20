using Clang

find_llvm_config() = begin
    if haskey(ENV, "LLVM_CONFIG")
        return readchomp(`which $(LLVM_CONFIG)`)
    end
    tmp = joinpath(JULIA_HOME, "llvm-config")
    isfile(tmp) && return tmp
    tmp = readchomp(`which llvm-config`)
    isfile(tmp) && return tmp
end

if !haskey(ENV, "LLVM_CONFIG") ENV["LLVM_CONFIG"] = find_llvm_config() end

clang_include_path = readchomp(`$(ENV["LLVM_CONFIG"]) --includedir`)
ncurses_include_path = joinpath(Pkg.dir("Ncurses"), "deps", "usr", "include")

indexh = joinpath(clang_include_path, "clang-c/Index.h")

_clang_includes = ASCIIString[]
push!(_clang_includes, "/usr/local/include")
push!(_clang_includes, clang_include_path)
push!(_clang_includes, dirname(indexh))
push!(_clang_includes, ncurses_include_path)
# joinpath("/usr/local", "include"), joinpath(clang_include_path), dirname(indexh), ncurses_include_path]

headers = ["ncurses.h"]
# headers = ["ncurses.h", "form.h", "menu.h", "panel.h"]
headers = [joinpath(ncurses_include_path, "ncursestw", h) for h in headers]

out_path = joinpath(Pkg.dir("Ncurses"), "test")
out_file = joinpath(out_path, "gen_ncurses.jl")
out_common = joinpath(out_path, "gen_ncurses_h.jl")

clang_extraargs = ["-D", "__STDC_LIMIT_MACROS", "-D", "__STDC_CONSTANT_MACROS", "-D", "NCURSES_WIDECHAR", "-D", "NCURSES_TPARM_VARARGS", "-D", "NCURSES_INTEROP_FUNCS", "-D", "NCURSES_REENTRANT", "-D", "NCURSES_OPAQUE"]

context=wrap_c.init(
                    headers = headers,
                    output_file="gen_ncurses.jl",
                    common_file="gen_ncurses_h.jl",
                    header_library="ncurses",
                    clang_includes=_clang_includes,
                    clang_diagnostics=true
                    # header_wrapped=(x,y)->contains(x,"cuda"),
                    # header_wrapped=(x,y)->true
                    # ,
                    # rewriter=rewriter)
                    )

context.options = wrap_c.InternalOptions(true,true)  # wrap structs, too
context.options.wrap_structs = true

# wrap_c.wrap_c_headers(wc, ["/usr/include/curl/curl.h"])

# Execute the wrap
run(context)





# push!(DL_LOAD_PATH, readchomp(`$(ENV["LLVM_CONFIG"]) --libdir`))
#
# cd(joinpath(Pkg.dir(), "Clang", "deps", "src") )
# run(`make`)
# if (!ispath("../usr"))
#   run(`mkdir ../usr`)
# end
# if (!ispath("../usr/lib"))
#   run(`mkdir ../usr/lib`)
# end
#
# run(`mv libwrapclang.$(Base.Sys.shlib_ext) ../usr/lib`)
