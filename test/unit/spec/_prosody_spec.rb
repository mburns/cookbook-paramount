# encoding: UTF-8

# -*- mode: ruby -*-
# vi: set ft=ruby :

require_relative 'spec_helper'

describe 'paramount::_prosody' do
  before { stub_resources }

  cached(:chef_run) { ChefSpec::ServerRunner.new.converge(described_recipe) }

  it 'includes prosody' do
    expect(chef_run).to include_recipe('prosody')
  end

  # prosody_vhost[example.com]
  # prosody_user[admin]
  # prosody_module[roster]
  # prosody_module[saslauth]
end