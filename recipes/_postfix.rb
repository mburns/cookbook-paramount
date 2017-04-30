#
# Cookbook Name:: paramount
# Recipe:: postfix
#
# Copyright (C) 2015 Michael Burns
# License:: Apache License, Version 2.0
#

Chef::Log.info("[EMAIL] :: #{recipe_name}")

opendkim_port = node['paramount']['dkim_port']

# Configure Postfix
node.default['postfix']['main']['milter_protocol'] = 2
node.default['postfix']['main']['milter_default_action'] = 'accept'
node.default['postfix']['main']['smtpd_milters'] = "inet:localhost:#{opendkim_port}"
node.default['postfix']['main']['non_smtpd_milters'] = "inet:localhost:#{opendkim_port}"

Chef::Recipe.send(:include, OpenSSLCookbook::RandomPassword)

postgres_passwd = random_password
node.default['paramount']['postgres_passwd'] = postgres_passwd

Chef::Log.info("Postgres password: #{postgres_passwd}")

package 'sendmail' do
  action :remove
end

user 'postfix' do
  shell '/bin/false'
  manage_home true
  system true
end

group 'postfix' do
  members ['postfix']
  system true
  append true
end

connection_info = {
  host: '127.0.0.1',
  port: '5432',
  username: 'postgres',
  password: postgres_passwd
}

postgresql_database_user 'postfix' do
  connection connection_info
  password postgres_passwd
  action :create
end

postgresql_database 'postfix' do
  connection connection_info
  owner 'postfix'
  # login true
  action :create
end

smtp_sasl_passwd = random_password
node.normal['postfix']['sasl']['smtp_sasl_passwd'] = smtp_sasl_passwd
Chef::Log.info("SMTP SASL password: #{smtp_sasl_passwd}")

# TODO : postscreen

node.normal['postfix']['master']['maildrop']['active'] = true
node.normal['postfix']['master']['cyrus']['active'] = true
node.normal['postfix']['sender_canonical_map_entries'] = [] # TODO : remove
node.normal['postfix']['smtp_generic_map_entries'] = [] # TODO : remove

include_recipe 'postfix'

# include_recipe 'paramount::_postfixadmin'
include_recipe 'paramount::_dkim'
