# Encoding: utf-8
name 'sovereign'
maintainer 'Michael Burns'
maintainer_email 'michael@mirwin.net'
license 'Apache 2.0'
description 'Installs/Configures a Sovereign software stack'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.0'

depends 'chef-sugar'
depends 'ark'
depends 'hostsfile'
depends 'build-essential'

depends 'ubuntu'
depends 'apt'
depends 'yum'
depends 'sysctl'
depends 'locales'
depends 'packages'
depends 'users'

depends 'rackspace_monitoring'
depends 'chef-client'
depends 'openssh'
depends 'database'
depends 'fail2ban'
depends 'sudo'
depends 'rsyslog'
depends 'firewall'
depends 'logstash'
# depends 'selinux'
# depends 'rkhunter'
# depends 'os-hardening'
# depends 'ssh-hardening'
# depends 'dovecot'
# depends 'spamassassin'
# depends 'nginx'
# depends 'roundcube'
# depends 'owncloud'
