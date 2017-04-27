require 'rspec/core/rake_task'
require 'kitchen/rake_tasks'

require_relative '../rake_helper'

desc 'Run unit tests using RSpec'
RSpec::Core::RakeTask.new(:unit) do |t|
  t.verbose = false if ENV['RSPEC_VERBOSE'].nil?
  t.rspec_opts = 'test/unit/'
end

desc 'Run unit tests (alias)'
task spec: %w[unit]