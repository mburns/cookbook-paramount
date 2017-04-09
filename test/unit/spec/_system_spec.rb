# encoding: UTF-8

# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'chefspec'
require_relative 'spec_helper'

describe 'paramount::_system' do
  before { stub_resources }

  let(:chef_run) { ChefSpec::ServerRunner.new.converge(described_recipe) }

  # sysctl
  %w(ntp build-essential packages ubuntu sudo rsyslog openssh).each do |recipe|
    it "Includes recipe: #{recipe}" do
      expect(chef_run).to include_recipe(recipe)
    end
  end

  it 'installs vim' do
    expect(chef_run).to install_package('vim')
  end

  it 'writes sshd config' do
    expect(chef_run).to render_file('/etc/ssh/sshd_config')
  end
end
