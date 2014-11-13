# == Class: dns
#
# This class configures local dns resolution.
#
# === Parameters
#
# [*dns_search*]
#   String.  Default search domain
#   Default: $::domain
#
# [*nameservers*]
#   Array of strings.  Nameservers to query for DNS requests
#   Default: [ '127.0.0.1']
#
# === Examples
#
# * Installation:
#     class { 'dns': }
#
# === Authors
#
# * Justin Lambert <mailto:jlambert@letsevenup.com>
#
# === Copyright
#
# Copyright 2013 EvenUp.
#
class dns (
  $dns_search = $::domain,
  $nameservers = [ '127.0.0.1'],
  $resolv = true,
) {

  package { 'bind-utils':
    ensure  => 'latest',
  }

  if ( $resolv ) {
    file { '/etc/resolv.conf':
      owner   => 'root',
      group   => 'root',
      mode    => '0444',
      content => template('dns/resolv.conf.erb'),
    }
  }

  file { '/etc/hosts':
    owner   => 'root',
    group   => 'root',
    mode    => '0444',
    require => File['/etc/resolv.conf'],
    content => template('dns/hosts.erb'),
  }

}
