Pod::Spec.new do |s|
  s.name              = 'Parsel'
  s.version           = '3.0.0'
  s.summary           = 'parsel is a parser combinator library written in Swift'

  s.description       = <<-DESC
Parsing is a very common task, it does not always mean to parse source code or JSON strings. Parsing means to transform an unstructured input to a structured output. In case of source code this means to parse a raw string to an AST (abstract syntax tree), in case of an addition it means to parse the result of adding two numbers out of a string. Parsing can always fail, if the input does not match the needed grammer. If the input string in the above example would have been 1+, it would have been failed because the second number is missing. The advantage of parser combinators is that you start with a very basic parser. In the above example digit parses only one digit. But it is not hard, to add a parser that parses more than one digit. A number is a repetition of mulitple digits. For repetition, we can use rep, which tries to apply the parser until it fails and collects the result as an array.
                       DESC

  s.homepage          = 'https://github.com/BenchR267/parsel'
  s.license           = { :type => 'MIT', :file => 'LICENSE' }
  s.author            = { 'Benjamin Herzog' => 'mail@benchr.de' }
  s.source            = { :git => 'https://github.com/BenchR267/parsel.git', :tag => s.version.to_s }
  s.social_media_url  = 'https://twitter.com/benchr'
  s.documentation_url = 'https://benchr267.github.io/parsel'

  s.ios.deployment_target = '8.0'

  s.source_files = 'Sources/parsel/**/*.swift'

  s.prepare_command = <<-CMD
    make initial
  CMD

end
