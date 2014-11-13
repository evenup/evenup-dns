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
# Copyright 2013 EvenUp.
#
define dns::peerdns (
  $present  = false,
){

  if $present {
    file_line { "ifcfg-${name}-peerdns-n":
      ensure => 'absent',
      path   => "/etc/sysconfig/network-scripts/ifcfg-${name}",
      line   => 'PEERDNS=no',
    }

    file_line { "ifcfg-${name}-peerdns-y":
      ensure => 'present',
      path   => "/etc/sysconfig/network-scripts/ifcfg-${name}",
      line   => 'PEERDNS=yes',
    }
  } else {
    file_line { "ifcfg-${name}-peerdns-y":
      ensure => 'absent',
      path   => "/etc/sysconfig/network-scripts/ifcfg-${name}",
      line   => 'PEERDNS=yes',
    }

    file_line { "ifcfg-${name}-peerdns-n":
      ensure => 'present',
      path   => "/etc/sysconfig/network-scripts/ifcfg-${name}",
      line   => 'PEERDNS=no',
    }
  }

}
