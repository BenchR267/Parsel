# Sequential operators

NUMBER_OF_SEQUENTIAL_OPERATORS = 10
SEQUENTIAL_OPERATORS_PATH = ./Scripts/SequentialOperators.swift
SEQUENTIAL_OPERATORS_SWIFT_PATH = ./Sources/ParserCombinator/Operators+Sequential.swift

initial:
	make generate && swift package update && swift package generate-xcodeproj

clean:
	rm -rf .build

generate:
	chmod +x $(SEQUENTIAL_OPERATORS_PATH) && swift $(SEQUENTIAL_OPERATORS_PATH) $(NUMBER_OF_SEQUENTIAL_OPERATORS) > $(SEQUENTIAL_OPERATORS_SWIFT_PATH)

test:
	swift build && swift test
