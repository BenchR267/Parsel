# Sequential operators

.PHONY: clean docs

NUMBER_OF_SEQUENTIAL_OPERATORS = 10
SEQUENTIAL_OPERATORS_PATH = ./Scripts/SequentialOperators.swift
SEQUENTIAL_OPERATORS_SWIFT_PATH = ./Sources/Parsel/Core/Operators+Sequential.swift

initial:
	swift package update
	make generate

clean:
	rm -rf .build
	rm -rf build
	rm -f Parsel.json
	rm -f $(SEQUENTIAL_OPERATORS_SWIFT_PATH)
	rm -rf Parsel.xcodeproj

docs:
	swift build
	sourcekitten doc --spm-module Parsel > Parsel.json
	jazzy \
	  --clean \
	  --author "Benjamin Herzog" \
	  --author_url "https://blog.benchr.de" \
	  --github_url "https://github.com/BenchR267/Parsel" \
	  --sourcekitten-sourcefile Parsel.json \
	  --output docs/

generate:
	chmod +x $(SEQUENTIAL_OPERATORS_PATH)
	swift $(SEQUENTIAL_OPERATORS_PATH) $(NUMBER_OF_SEQUENTIAL_OPERATORS) > $(SEQUENTIAL_OPERATORS_SWIFT_PATH)
	swift package generate-xcodeproj --enable-code-coverage

test:
	swift build
	swift test

travis:
	make initial
	pod lib lint Parsel.podspec
	make test
