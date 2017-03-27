require 'rake/testtask'

# Rake::TestTask.new do |t|
#   t.libs << "tests"
#   t.test_files = FileList['tests/test*.rb']
#   t.verbose = true
# end

begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec)

  task :default => :spec
rescue LoadError
  # no rspec available
end