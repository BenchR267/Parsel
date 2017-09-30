import parsel

let input = """
val a = 5
var b = 4
"""

let res = lexer.parse(input).flatMap({ tokens, _ in parser.parse(tokens) })
dump(try res.unwrap())
