#
# Cookbook Name:: paramount
# Attributes:: postfix
#
# Copyright 2015, Michael Burns
# License:: Apache License, Version 2.0
#

include_attribute 'paramount::default'

default['postfix']['mail_type'] = 'master'

domain = begin
  "mail.#{node['paramount']['domain']}"
rescue
  'example.com'
end

default['postfix']['main']['mydomain'] = domain
default['postfix']['main']['myorigin'] = domain
default['postfix']['main']['inet-interfaces'] = 'all'
default['postfix']['main']['relayhost'] = "[smtp.#{node['postfix']['main']['mydomain']}]"
default['postfix']['main']['smtp_use_tls'] = 'yes'

default['postfix']['main']['smtp_sasl_auth_enable'] = 'yes'

default['postfix']['sasl']['smtp_sasl_user_name'] = node['paramount']['user']
