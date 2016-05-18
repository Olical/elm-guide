.PHONY: default bootstrap build

BIN = ./node_modules/.bin

default: bootstrap build

bootstrap:
	npm install
	$(BIN)/elm package install

build:
	$(BIN)/webpack
