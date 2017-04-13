# encoding: UTF-8

# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'rspec/expectations'
require 'chefspec'
require 'chefspec/berkshelf'
require 'chef/application'
require 'coveralls'
require 'fauxhai'

Coveralls.wear!

require 'simplecov'
SimpleCov.start

require 'codecov'
SimpleCov.formatter = SimpleCov::Formatter::Codecov

at_exit { ChefSpec::Coverage.report! }

RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.fail_fast = true
  config.filter_run :focus

  config.log_level = :error
  Ohai::Config[:log_level] = :error

  config.platform = 'ubuntu'
  config.version = '14.04'
end

def stub_resources
  stub_command('which sudo').and_return '/usr/bin/sudo'
  stub_command('which nginx').and_return '/usr/sbin/nginx'

  stub_command('test -d /etc/php5/fpm/pool.d || mkdir -p /etc/php5/fpm/pool.d').and_return false

  stub_command('ls /var/lib/postgresql/9.3/main/recovery.conf').and_return true

  stub_command("psql -c 'SELECT lanname FROM pg_catalog.pg_language' postfix | grep '^ plpgsql$'").and_return true
end
