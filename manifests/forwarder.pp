# == Class: dns::forwarder
#
# This class is for a simple bind configuration to act as a DNS forwarder.
# There are more powerful bind modules for those who want a full bind configuration
#
# === Parameters
#
# [*allow_query*]
#   String.  Bind ACL of networks to forward for
#   Default: 'any;'
#
# [*forwarders*]
#   String.  DNS servers to send requests to
#   Default: '8.8.8.8; 8.8.4.4;'
#
# === Examples
#
# * Installation:
#     class { 'dns::forwarder': }
#
# === Authors
#
# * Justin Lambert <mailto:jlambert@letsevenup.com>
#
# === Copyright
#
# Copyright 2014 EvenUp.
#
class dns::forwarder (
  $allow_query = 'any;',
  $forwarders  = '8.8.8.8; 8.8.4.4;'
) {

  package { 'bind':
    ensure => 'installed',
  }

  file { '/etc/named.conf':
    owner   => 'root',
    group   => 'named',
    mode    => '0440',
    content => template('dns/named.conf.erb'),
    require => Pachage['bind'],
  }

  service { 'named':
    ensure  => 'running',
    enable  => true,
    require => File['/etc/named.conf'],
  }

}
