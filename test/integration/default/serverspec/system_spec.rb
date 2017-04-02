# encoding: UTF-8

# License:: Apache License, Version 2.0
#

require_relative 'spec_helper'

describe service('sshd') do
  it { should be_running }
end

describe package('htop') do
  it { should be_installed }
end

describe file('/etc/ssh/sshd_config') do
  its(:content) { should match(/^PermitRootLogin.*no/) }
end
