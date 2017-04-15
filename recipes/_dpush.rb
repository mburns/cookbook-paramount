#
# Cookbook Name:: paramount
# Recipe:: _dpush
#
# Copyright (C) 2017 Michael Burns
# License:: Apache License, Version 2.0
#

Chef::Log.info("[EMAIL] :: #{recipe_name}")

package 'd-push'
# package 'php5-imap'

# php5enmod imap

# cookbook_file '/etc/apache2/conf-available/d-push.conf' do
#   source 'apache.dpush.conf'
# end

# a2enconf d-push.conf

template '/etc/d-push/config.php' do
  source 'dpush.php'
end

# z-push-admin.php z-push-top.php
