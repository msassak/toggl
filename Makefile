.PHONY: all test clean

all:
	./rebar compile

repl:
	erl -pa ebin

test: all
	./rebar ct verbose=1 skip_deps=true

clean:
	./rebar clean
