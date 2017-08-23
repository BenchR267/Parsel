# Sequential operators

.PHONY: clean docs

ifeq ($(RELEASE), 1)
    OPERATOR_COUNT=25
else
    OPERATOR_COUNT=10
endif

clean:
	rm -rf .build
	rm -rf build
	rm -f Parsel.json
	rm -f $(SEQUENTIAL_OPERATORS_SWIFT_PATH)
	rm -rf Parsel.xcodeproj

coverage:
	make initial
	xcodebuild -version
	xcodebuild -scheme Parsel-Package -sdk macosx -skipUnavailableActions build test
	curl -s https://codecov.io/bash | bash

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
	swift ./Scripts/SequentialOperators.swift $(OPERATOR_COUNT) > ./Sources/Parsel/Core/Operators+Sequential.swift
	swift package generate-xcodeproj --enable-code-coverage

initial:
	swift package update
	make generate

test:
	swift build
	swift test

travis:
	make initial
	pod lib lint Parsel.podspec
	make test

travisosx:
	make initial
	swiftlint lint
	make coverage
