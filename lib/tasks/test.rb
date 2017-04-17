require 'rspec/core/rake_task'
require 'kitchen/rake_tasks'

require_relative '../rake_helper'

namespace :test do
  RSpec::Core::RakeTask.new(:unit) do |t|
    t.verbose = false if ENV['RSPEC_VERBOSE'].nil?
    t.rspec_opts = 'test/unit/'
  end

  namespace :integration do
    desc 'Run integration tests using Vagrant'
    task :vagrant do
      Kitchen.logger = Kitchen.default_file_logger
      Kitchen::Config.new.instances.each do |instance|
        instance.test(:always)
      end
    end

    desc 'Run integration tests using kitchen-docker'
    task :docker, %i[regexp action] do |_t, args|
      run_kitchen(args.action, args.regexp, local_config: '.kitchen.docker.yml')
    end

    desc 'Run integration tests using The Cloud(TM)'
    task :cloud do
      Kitchen.logger = Kitchen.default_file_logger

      loader = Kitchen::Loader::YAML.new(local_config: '.kitchen.cloud.yml')
      config = Kitchen::Config.new(loader: loader)

      concurrency = config.instances.size

      queue = Queue.new
      config.instances.each { |i| queue << i }
      concurrency.times { queue << nil }

      threads = []
      concurrency.times do
        threads << Thread.new do
          while (instance = queue.pop)
            instance.test(:always)
          end
        end
      end

      threads.map(&:join)
    end
  end

  desc 'Run all tests'
  task all: %i[unit test:integration:vagrant]
end
