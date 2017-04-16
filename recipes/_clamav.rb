#
# Cookbook Name:: paramount
# Recipe:: clamav
#
# Copyright (C) 2016 Michael Burns
# License:: Apache License, Version 2.0
#

Chef::Log.info("[EMAIL] :: #{recipe_name}")

include_recipe 'paramount::_amavis'

node.default['clamav']['clamd']['enabled'] = true
node.default['clamav']['freshclam']['enabled'] = true
node.default['clamav']['scan']['script']['enable'] = true
node.default['clamav']['scan']['minimal']['enable'] = true

package 'clamav-daemon'

include_recipe 'clamav'

group 'amavis' do
  action :modify
  members ['clamav']
  append true
end

group 'clamav' do
  action :modify
  members %w[clamav amavis]
  append true
end

poise_service 'clamav' do
  service_name 'clamav-daemon'
  command 'amavisd'
  supports status: true, restart: true, reload: true
  action %i[enable start]
end
