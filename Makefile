# Sequential operators

NUMBER_OF_SEQUENTIAL_OPERATORS = 10
SEQUENTIAL_OPERATORS_PATH = ./Scripts/SequentialOperators.swift
SEQUENTIAL_OPERATORS_SWIFT_PATH = ./Sources/Parsers/Operators+Sequential.swift

generate:
	chmod +x $(SEQUENTIAL_OPERATORS_PATH) && swift $(SEQUENTIAL_OPERATORS_PATH) $(NUMBER_OF_SEQUENTIAL_OPERATORS) > $(SEQUENTIAL_OPERATORS_SWIFT_PATH)

test:
	make generate && swift build && swift test
