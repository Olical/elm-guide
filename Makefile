.PHONY: install reactor repl

elm = ./node_modules/.bin/elm

install:
	npm install
	$(elm) package install -y

reactor:
	$(elm) reactor

repl:
	$(elm) repl
