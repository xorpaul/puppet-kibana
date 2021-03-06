# == Class: kibana::params
#
# This class exists to
# 1. Declutter the default value assignment for class parameters.
# 2. Manage internally used module variables in a central place.
#
# Therefore, many operating system dependent differences (names, paths, ...)
# are addressed in here.
#
#
# === Parameters
#
# This class does not provide any parameters.
#
#
# === Examples
#
# This class is not intended to be used directly.
#
#
# === Links
#
# * {Puppet Docs: Using Parameterized Classes}[http://j.mp/nVpyWY]
#
#
# === Authors
#
# * Richard Pijnenburg <mailto:richard@ispavailability.com>
#
class kibana::params {

  #### Default values for the parameters of the main module class, init.pp

  # ensure
  $ensure = 'present'

  $elasticsearch_server = 'localhost'
  $install_path = '/usr/local'
  $apache_conf_dir = '/tmp'
  $vhost_name = $::fqdn
  $serveradmin = 'root@localhost'

}
