What is it?
===========

A puppet module that configures the resolv.conf and hosts on a Linux machine.
It also includes a definition (dns::peerdns) which will remove RHEL's DHCP
configuration that pulls DNS config from DHCP.

Usage:
------

Generic install
<pre>
  class { 'dns': }
</pre>

Remove PEERDNS from eth0
<pre>
  dns::peerdns { 'eth0': }
</pre>

Known Issues:
-------------
Only tested on CentOS 6

License:
_______

Released under the Apache 2.0 licence


Contribute:
-----------
* Fork it
* Create a topic branch
* Improve/fix (with spec tests)
* Push new topic branch
* Submit a PR
* Enjoy your awesomeness
