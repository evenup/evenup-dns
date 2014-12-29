# == Define: dns::peerdns
#
# This define removes (or adds) PEERDNS settings to RHEL network config files.
#
# === Parameters
#
# [*name/title*]
#   String.  Interface name
#
# [*present*]
#   Boolean.  Should the PEERDNS line be present?
#   Default: false
#
# === Examples
#
# dns::peerdns { 'eth0': }
#
# === Authors
#
# * Justin Lambert <mailto:jlambert@letsevenup.com>
#
# === Copyright
#
# Copyright 2014 EvenUp.
#
define dns::peerdns (
  $present  = false,
){

  if ! defined(Class['dns']) {
    fail('You must include the dns base class before using any dns defined resources')
  }

  # ensure quoted params are absent
  file_line { "ifcfg-${name}-peerdns-quoted-n":
    ensure => 'absent',
    path   => "/etc/sysconfig/network-scripts/ifcfg-${name}",
    line   => 'PEERDNS="no"',
    notify => Service['network'],
  }

  file_line { "ifcfg-${name}-peerdns-quoted-y":
    ensure => 'absent',
    path   => "/etc/sysconfig/network-scripts/ifcfg-${name}",
    line   => 'PEERDNS="yes"',
    notify => Service['network'],
  }

  if $present {
    file_line { "ifcfg-${name}-peerdns-n":
      ensure => 'absent',
      path   => "/etc/sysconfig/network-scripts/ifcfg-${name}",
      line   => 'PEERDNS=no',
      notify => Service['network'],
    }

    file_line { "ifcfg-${name}-peerdns-y":
      ensure => 'present',
      path   => "/etc/sysconfig/network-scripts/ifcfg-${name}",
      line   => 'PEERDNS=yes',
      notify => Service['network'],
    }
  } else {
    file_line { "ifcfg-${name}-peerdns-y":
      ensure => 'absent',
      path   => "/etc/sysconfig/network-scripts/ifcfg-${name}",
      line   => 'PEERDNS=yes',
      notify => Service['network'],
    }

    file_line { "ifcfg-${name}-peerdns-n":
      ensure => 'present',
      path   => "/etc/sysconfig/network-scripts/ifcfg-${name}",
      line   => 'PEERDNS=no',
      notify => Service['network'],
    }
  }

}
