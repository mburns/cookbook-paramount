#
# Cookbook Name:: paramount
# Recipe:: email
#
# Copyright (C) 2015 Michael Burns
# License:: Apache License, Version 2.0
#

include_recipe 'openssl::upgrade'
Chef::Recipe.send(:include, OpenSSLCookbook::RandomPassword)
node.default['paramount']['encfs_passwd'] = random_password(length: 50, mode: :base64, encoding: 'ASCII')

directory '/data/'

# encfs '/data/encrypted-mail' do
#   password node['paramount']['encfs_passwd']
#   action :mount
# end

include_recipe 'database::postgresql'

user 'vmail' do
  shell '/bin/false'
  supports manage_home: true
  system true
end

group 'vmail' do
  members ['vmail']
  system true
  append true
end

include_recipe 'paramount::dovecot'
# TODO : z-push
include_recipe 'paramount::spamassassin'
include_recipe 'paramount::postfix'
# TODO : postgrey
include_recipe 'paramount::dkim'
# include_recipe 'paramount::roundcube'
