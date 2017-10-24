//: [Go back](@previous)
//: ## parsel playground 🤹‍♂️

let parser = L.string("Hello, ") ~> L.char.atLeastOne ^^ { String($0) }

let input = "Hello, parsel"
try parser.parse(input).unwrap()

