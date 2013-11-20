require 'rake/testtask'
require 'rubygems/tasks'

namespace :test do
  suites = [:end_to_end, :unit, :integration]

  desc "Run all test suites"
  task :all => suites

  suites.each do |suite|
    Rake::TestTask.new suite do |t|
      t.libs << 'lib'
      t.libs << 'test'
      t.pattern = "test/#{suite}/**/*.rb"
      t.verbose = true
    end
  end
end

Gem::Tasks.new

task :default => "test:all"

