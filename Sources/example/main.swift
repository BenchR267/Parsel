import parsel

let input = """
val a = 5
val b = 4
val c = a + b
"""

let res = lexer.parse(input)
print(try res.unwrap())
