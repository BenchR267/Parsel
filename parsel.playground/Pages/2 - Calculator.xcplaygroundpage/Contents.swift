//: In the [previous](@previous) page we defined a parser to parse a `Character` from a given `String`. This parser is actually pre-defined in parsel in the `Lexical` namespace *(or short `L`)*.
try L.char.parse("foo").unwrap()
/*:
 ## Calculator 1️⃣➕1️⃣
 
 There are many more very useful parsers defined in `L`, so let's use some of them to build a very limited and easy **calculator**!

 Before we can start, here is a very useful function we need.
 
 It is called `map`. It takes a function as input and transforms the parsed value with that function if the parse operation succeeded. If not, nothing else will happen.
 
 * Parser<S, A>.map(f: (A) -> B) -> Parser<S, B>
 */
let digitPlusOne = L.digit.map { $0 + 1 }
try digitPlusOne.parse("1").unwrap()
/*:
 There exists also a custom operator `^^` that does the same as `map`, but you do not need to specify annoying brackets.
 
 We also need a way to combine multiple parsers. We use `~` to combine two parsers and get both results as a tuple result in a new parser:
 */
let twoDigits = L.digit ~ L.digit
try twoDigits.parse("12").unwrap()
/*:
 
 With `map` and `~` on our side we can start to define the multiply arithmetic operation:
 */
let multiply = L.decimalNumber ~ L.multiply ~ L.decimalNumber ^^ { n1, _, n2 in n1 * n2 }
try multiply.parse("42*5").unwrap()
/*:
 Since we could potentially also declare division as an parser we would like to define point arithmetics as an own parser that we can use in lower prioritized ones.
 
 We decide that just a number is also a valid point arithmetic. `|` helps us with an or-combination of two parsers, the first that succeeds defines the result.
 */
let point = multiply | L.decimalNumber
/*:
 
 At next, we define plus and minus operations. Since we always ignore the sign character, we can also use `<~` *(needs both parsers to succeed, but ignores the right result)* and `~>` *(also needs both parsers to succeed, but ignores the left result)*.
 */
let plus = point <~ L.plus ~ point ^^ (+)
try plus.parse("4*3+5").unwrap()

let minus = point <~ L.minus ~ point ^^ (-)
try minus.parse("4*3-5").unwrap()
/*:
 Line calculations are lower prioritized, that is the reason we used point as the operands. We also define `line` as the summary of all line calculations, a single number included as well.
 */
let line = plus | minus | L.decimalNumber
try line.parse("3*5-10").unwrap()
try line.parse("3*5+10").unwrap()
/*:
 As you can see, the parsers already get very nice to read and to understand. That is the whole part behind parser combinators: you define them explicitly on low level and combine those easy ones to get complex ones.
 
 Our calculator is very limited, it can only calculate `Int`s , only the operations `+`, `-` and `*` and it can only process two operands per operation. Check out [**Calculator**](https://github.com/BenchR267/Calculator) for a working example project with more functionality built with parsel.
 
 In the [next](@next) page we take a look on sequences which we can use to produce multiple values.
 */
