  require 'rake/testtask'
  require 'rubocop/rake_task'

  Rake::TestTask.new do |task|
    task.libs << %w(test lib)
    task.pattern = 'test/test_*.rb'
  end

  desc 'Run rubocop'
  task :rubocop do
    RuboCop::RakeTask.new
  end

  task default: [:test, :rubocop]

