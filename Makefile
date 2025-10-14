name := $(shell jq -r .name config.json)
version := $(shell jq -r .version config.json)

sources := $(wildcard src/*.c)
target := build/$(name)

input := $(wildcard test/*.txt)
test := $(patsubst %.txt, %.test, $(input))

all: $(target)

$(target): $(sources) config.json
	mkdir -p build
	gcc -DNAME='"$(name)"' -DVERSION='"$(version)"' $(sources) -o $@

check: $(target) $(test)

test/%.test: test/%.txt test/%.expected
	@$(target) test/$*.txt > test/$*.out
	@diff test/$*.expected test/$*.out
	@rm test/$*.out

clean:
	rm -rf build

.PHONY: all check clean 