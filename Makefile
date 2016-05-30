.PHONY: default bootstrap start build

BIN = ./node_modules/.bin

default: bootstrap build

bootstrap:
	npm install
	$(BIN)/elm package install

start:
	npm start

build:
	npm run build
