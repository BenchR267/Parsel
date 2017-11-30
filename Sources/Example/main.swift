import Parsel

let input = """
val a = 5
var b = 4
val c = "hello world"
"""

let res = lexer.parse(input).flatMap({ tokens, _ in parser.parse(tokens) })
dump(res)

