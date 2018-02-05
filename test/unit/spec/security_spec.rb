# encoding: UTF-8

# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'chefspec'
require_relative 'spec_helper'

describe 'paramount::security' do
  before { stub_resources }

  cached(:chef_run) { ChefSpec::ServerRunner.new.converge(described_recipe) }

  it 'creates ssl directory with an explicit action' do
    expect(chef_run).to create_directory('/etc/nginx/ssl')
  end

  # selinux_state[SELinux Permissive]
  # openssl_x509[/etc/nginx/ssl/example.com.pem]
end
