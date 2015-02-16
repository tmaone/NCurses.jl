.PHONY: build clean

build:
	@mkdir -p deps/usr
	@julia -e "Pkg.build(\"NCurses\")"

clean:
	@rm -rfv deps/downloads
	@rm -rfv deps/builds
	@rm -rfv deps/src
	@rm -rfv deps/usr
	@rm -rfv deps/deps.jl
	@find . -name .DS_Store -delete
