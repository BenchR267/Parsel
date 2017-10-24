/*:
 One of the missing feature in the calculator we built in the [previous](@previous) page was that it only could process two operands per operation.
 
 In this page we are going to use operators that allow us to produce more values at once!
 
 ## Sequences 👩‍👩‍👧‍👧
 
 Imagine you would like to parse an input string that contains comma separated numbers.
 
 `rep` tries to parse the parser as long as it succeeds and returns all produced values in an array. You can also give it an optional separator.
 */
let csn = L.decimalNumber.rep(sep: L.char(","))
try csn.parse("1,2,3,4,5,6,7,8,9").unwrap()
/*:
 To avoid empty lists you can use the `atLeastOne` or `atLeastOnce(sep:)` functions:
*/
let digits = L.digit.atLeastOne
try digits.parse("123").unwrap()
try digits.parse("a").error()
/*:
 If you need an exact count of successes you can use the `exactly(count:)` function.
 */
let zipCode = L.digit.exactly(count: 5)
try zipCode.parse("01259").unwrap()
try zipCode.parse("12").error()
/*:
 ## Optionals ?
 
 Since every parsing operation could fail, we can also provide a fallback if that happens:
 */
let couldFail = L.digit.fallback(0)
try couldFail.parse("a").unwrap()
try couldFail.parse("3").unwrap()
/*:
 To avoid magic numbers that represent the absence of a value Swift provides the `Optional` type. The success of a parser is sometimes optional as well:
 */
let optionalNumber = L.digit.optional
try optionalNumber.parse("a").unwrap()
try optionalNumber.parse("3").unwrap()

//: Use the [next](@next) page for experiments with the framework. Use the documentation if you need any help! If you find any bug or you can think about any functionality that should be added, do not hesitate to open an issue [here](https://github.com/BenchR267/parsel/issues). Thanks for using parsel!
