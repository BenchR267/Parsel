# Make it more obvious that a PR is a work in progress and shouldn't be merged yet
warn("PR is classed as Work in Progress") if github.pr_title.include? "[WIP]"

fail "Please provide a summary in the Pull Request description" if github.pr_body.length < 5

warn "#{github.html_link("Package.swift")} was edited." if git.modified_files.include? "Package.swift"
warn "#{github.html_link("Makefile")} was edited." if git.modified_files.include? "Makefile"

# Check if tests were written for swift files
def isTest?(file)
  file.end_with? "_TestCase.swift"
end

files = (git.added_files + git.modified_files).select{ |file| isTest?(file) }
tests = (git.added_files + git.modified_files).select{ |file| !isTest?(file) }

files.each do |file|
	next if tests.any? { |e| e.contains? file }
	fail("Please add a test case for #{file}.")
end
