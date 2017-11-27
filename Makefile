# Sequential operators

.PHONY: clean docs

ifndef VERSION
    OPERATOR_COUNT=10
else
    OPERATOR_COUNT=25
endif

# clean the project folder from generated files
clean:
	$(info Cleaning all generated files.)
	rm -rf .build
	rm -rf build
	rm -f Parsel.json
	rm -f $(SEQUENTIAL_OPERATORS_SWIFT_PATH)
	rm -rf Parsel.xcodeproj
	rm -rf Parsel.playground/Sources/*
	rm -rf *.coverage.txt

# OSX only: build and run tests + measure code coverage and upload to codecov
coverage:
	$(info Build and run tests + measure coverage afterwards.)
	make initial
	xcodebuild -version
	xcodebuild -scheme Parsel-Package -sdk macosx -skipUnavailableActions build test
	curl -s https://codecov.io/bash | bash

# OSX only: generate documentation
docs:
	$(info generate documentation)
	rm -rf docs
	mkdir docs
	swift build
	sourcekitten doc --spm-module Parsel > Parsel.json
	jazzy \
	  --clean \
	  --author "Benjamin Herzog" \
	  --author_url "https://blog.benchr.de" \
	  --github_url "https://github.com/BenchR267/Parsel" \
	  --sourcekitten-sourcefile Parsel.json \
	  --use-safe-filenames \
	  --no-download-badge \
	  --output docs/
	touch docs/.nojekyll

# generates xcode project and sequential operators
# depends on OPERATOR_COUNT!
generate:
	$(info generate Swift source files…)
	swift ./Scripts/SequentialOperators.swift $(OPERATOR_COUNT) > ./Sources/Parsel/Core/Operators+Sequential.swift
	swift package generate-xcodeproj --enable-code-coverage
	make playground

# first command to execute on every machine
initial:
	swift package update
	make generate

# copy content sources into playground
playground:
	mkdir -p ./Parsel.playground/Sources
	cp -r ./Sources/Parsel/* ./Parsel.playground/Sources

# run tests
test:
	swift build
	swift test --parallel

# call this on travis linux machines
travis:
	make initial
	pod lib lint Parsel.podspec --skip-tests
	make test

# OSX only: call this on travis osx machines
travisosx:
	make initial
	swiftlint lint
	make coverage

# release a new version!
ifndef VERSION
release:
	$(error VERSION is not set to version. Aborting…)
else 
ifneq ($(shell git rev-parse --abbrev-ref HEAD), master)
release:
	$(error You can only release while master is checked out, sorry.)
else
release:
	make generate
	$(info Set version in podspec)
	sed -i "" "s/\(.*s\.version[[:space:]]*=[[:space:]]*\'\).*\\('.*\)/\1${VERSION}\2/g" Parsel.podspec
	$(info Set version in README)
	sed -i "" "s/\(.*\.package.*, from: \"\).*\(\".*\)/\1${VERSION}\2/g" README.md
	git add Parsel.podspec
	git add README.md
	git commit -m "Release version ${VERSION}"
	git tag $(VERSION)
	git push origin $(VERSION)
	git push origin master
	pod trunk push Parsel.podspec
	git checkout HEAD -- ./Sources/Parsel/Core/Operators+Sequential.swift
	$(info Do not forget to add playground to release!)
endif
endif
