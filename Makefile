# Sequential operators

.PHONY: clean docs

NUMBER_OF_SEQUENTIAL_OPERATORS = 10
SEQUENTIAL_OPERATORS_PATH = ./Scripts/SequentialOperators.swift
SEQUENTIAL_OPERATORS_SWIFT_PATH = ./Sources/ParserCombinator/Core/Operators+Sequential.swift

initial:
	swift package update
	make generate

clean:
	rm -rf .build
	rm -f $(SEQUENTIAL_OPERATORS_SWIFT_PATH)
	rm -rf ParserCombinator.xcodeproj

docs:
	sourcekitten doc --spm-module ParserCombinator > ParserCombinator.json
	jazzy \
	  --clean \
	  --author "Benjamin Herzog" \
	  --author_url "https://blog.benchr.de" \
	  --github_url "https://github.com/BenchR267/ParserCombinator" \
	  --sourcekitten-sourcefile ParserCombinator.json
	  --output docs/

generate:
	chmod +x $(SEQUENTIAL_OPERATORS_PATH)
	swift $(SEQUENTIAL_OPERATORS_PATH) $(NUMBER_OF_SEQUENTIAL_OPERATORS) > $(SEQUENTIAL_OPERATORS_SWIFT_PATH)
	swift package generate-xcodeproj --enable-code-coverage

release:
	test $(TAG)
	swift build --configuration release --static-swift-stdlib
	path=`swift build --configuration release --show-bin-path`

test:
	swift build --build-tests
	swift test --skip-build

travis:
	make initial
	pod lib lint SwiftParserCombinator.podspec
	make test
