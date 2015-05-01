# == Class: puppet
#
# Full description of class puppet here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { puppet:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class luasense {
  class { 'apt':
    always_apt_update => false,
  }

  include luasense::rabbitmq::node

  file { "/etc/apt/apt.conf.d/99auth":
    owner     => root,
    group     => root,
    content   => "APT::Get::AllowUnauthenticated yes;",
    mode      => 644;
  }
  ->

  file {"luasense_apt_repo":
    path => '/etc/apt/sources.list.d/luasense.list',
    ensure => present,
    content => "deb http://dl.bintray.com/kireevco/deb /",
  }
  ->

#  package {"lua5.2":
#    ensure => installed,
#  }

#  package {"mosquitto":
#    ensure => installed,
#  }

  package {"openresty":
    ensure => installed,
    require => File['luasense_apt_repo'],
  }
}