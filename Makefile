.PHONY: bootstrap

BIN = ./node_modules/.bin

bootstrap:
	npm install
	$(BIN)/elm package install
