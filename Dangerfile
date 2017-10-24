# Make it more obvious that a PR is a work in progress and shouldn't be merged yet
warn("PR is classed as Work in Progress") if github.pr_title.include? "[WIP]"

fail "Please provide a summary in the Pull Request description" if github.pr_body.length < 5

warn "#{github.html_link("Package.swift")} was edited." if git.modified_files.include? "Package.swift"
warn "#{github.html_link("Makefile")} was edited." if git.modified_files.include? "Makefile"

# Check if tests were written for swift files
def isTest?(file)
  file.start_with? "Tests/"
end

def isSwiftFile?(file)
	file.end_with? ".swift"
end

def shouldEvaluate?(file)
	!file.start_with? "parsel.playground"
end

(git.added_files + git.modified_files).each do |file|
	next unless file.end_with? "Tests.swift"
	warn "Test files should end with _TestCase.swift, not Tests.swift. Please rename #{github.html_link(file)}"
end

files = (git.added_files + git.modified_files).select{ |file| isSwiftFile?(file) && !isTest?(file) && shouldEvaluate?(file) }
tests = (git.added_files + git.modified_files).select{ |file| isSwiftFile?(file) && isTest?(file) && shouldEvaluate?(file) }

# Check for test case of added/modified files
files.each do |file|
	name = File.basename(file, ".swift")
	test = Dir.glob("Tests/**/#{name}_TestCase.swift").first.to_s
  	fail "Please add a test case for #{file}." if test == ''
end
