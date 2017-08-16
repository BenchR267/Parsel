Pod::Spec.new do |s|
  s.name             = 'ParserCombinator'
  s.version          = '0.1.0'
  s.summary          = 'Parser combinator library in Swift'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Parsing is a very common task, it does not always mean to parse source code or JSON strings. Parsing means to transform an unstructured input to a structured output. In case of source code this means to parse a raw string to an AST (abstract syntax tree), in case of an addition it means to parse the result of adding two numbers out of a string. Parsing can always fail, if the input does not match the needed grammer. If the input string in the above example would have been 1+, it would have been failed because the second number is missing. The advantage of parser combinators is that you start with a very basic parser. In the above example digit parses only one digit. But it is not hard, to add a parser that parses more than one digit. A number is a repetition of mulitple digits. For repetition, we can use rep, which tries to apply the parser until it fails and collects the result as an array.
                       DESC

  s.homepage         = 'https://github.com/BenchR267/ParserCombinator'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Benjamin Herzog' => 'mail@benchr.de' }
  s.source           = { :git => 'https://github.com/BenchR267/ParserCombinator.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/benchr'

  s.ios.deployment_target = '8.0'

  s.source_files = 'Sources/ParserCombinator/*.swift'

end
