# encoding: UTF-8
# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'rspec/expectations'
require 'chefspec'
require 'chefspec/berkshelf'
require 'chef/application'
require 'coveralls'

Coveralls.wear!

# at_exit { ChefSpec::Coverage.report! }

RSpec.configure do |config|
  # Specify the Chef log_level (default: :warn)
  # config.log_level = :debug

  # Specify the path to a local JSON file with Ohai data (default: nil)
  # config.path = 'ohai.json'

  # Specify the operating platform to mock Ohai data from (default: nil)
  config.platform = 'ubuntu'

  # Specify the operating version to mock Ohai data from (default: nil)
  config.version = '14.04'
end
