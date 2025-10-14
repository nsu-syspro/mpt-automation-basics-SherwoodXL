name := $(shell jq -r .name config.json)
version := $(shell jq -r .version config.json)
sources := $(wildcard src/*.c)
target := build/$(name)

all: $(target)

$(target): $(sources) config.json
	mkdir -p build
	gcc -DNAME='"$(name)"' -DVERSION='"$(version)"' $(sources) -o $@


clean:
	rm -rf build

.PHONY: all clean 