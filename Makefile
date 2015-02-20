.PHONY: build clean gen

build:
	@julia -e "Pkg.build(\"NCurses\")"

gen:
	@julia deps/generate.jl

clean:
	@rm -rfv deps/builds
	@rm -rfv deps/downloads
	@rm -rfv deps/src
	@rm -rfv deps/usr
	@rm -rfv deps/deps.jl
	@find . -name .DS_Store -delete
