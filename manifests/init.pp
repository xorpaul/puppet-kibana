# == Class: kibana::standalone
#
# This class is able to install or remove kibana on a node.
# It manages the status of the related service.
#
# === Parameters
#
# [*ensure*]
#   String. Controls if the managed resources shall be <tt>present</tt> or
#   <tt>absent</tt>. If set to <tt>absent</tt>:
#   * The managed software packages are being uninstalled.
#   * Any traces of the packages will be purged as good as possible. This may
#     include existing configuration files. The exact behavior is provider
#     dependent. Q.v.:
#     * Puppet type reference: {package, "purgeable"}[http://j.mp/xbxmNP]
#     * {Puppet's package provider source code}[http://j.mp/wtVCaL]
#   * System modifications (if any) will be reverted as good as possible
#     (e.g. removal of created users, services, changed log settings, ...).
#   * This is thus destructive and should be used with care.
#   Defaults to <tt>present</tt>.
#
# [*autoupgrade*]
#   Boolean. If set to <tt>true</tt>, any managed package gets upgraded
#   on each Puppet run when the package provider is able to find a newer
#   version than the present one. The exact behavior is provider dependent.
#   Q.v.:
#   * Puppet type reference: {package, "upgradeable"}[http://j.mp/xbxmNP]
#   * {Puppet's package provider source code}[http://j.mp/wtVCaL]
#   Defaults to <tt>false</tt>.
#
# [*status*]
#   String to define the status of the service. Possible values:
#   * <tt>enabled</tt>: Service is running and will be started at boot time.
#   * <tt>disabled</tt>: Service is stopped and will not be started at boot
#     time.
#   * <tt>running</tt>: Service is running but will not be started at boot time.
#     You can use this to start a service on the first Puppet run instead of
#     the system startup.
#   * <tt>unmanaged</tt>: Service will not be started at boot time and Puppet
#     does not care whether the service is running or not. For example, this may
#     be useful if a cluster management software is used to decide when to start
#     the service plus assuring it is running on the desired node.
#   Defaults to <tt>enabled</tt>. The singular form ("service") is used for the
#   sake of convenience. Of course, the defined status affects all services if
#   more than one is managed (see <tt>service.pp</tt> to check if this is the
#   case).
#
# [*version*]
#   String to set the specific version you want to install.
#   Defaults to <tt>false</tt>.
#
# The default values for the parameters are set in kibana::params. Have
# a look at the corresponding <tt>params.pp</tt> manifest file if you need more
# technical information about them.
#
#
# === Examples
#
# * Installation, make sure service is running and will be started at boot time:
#     class { 'kibana': }
#
# * Removal/decommissioning:
#     class { 'kibana':
#       ensure => 'absent',
#     }
#
# * Install everything but disable service(s) afterwards
#     class { 'kibana':
#       status => 'disabled',
#     }
#
#
# === Authors
#
# * Richard Pijnenburg <mailto:richard@ispavailability.com>
#

class kibana(
  $ensure                   = $kibana::params::ensure,
  $pkg_name                 = undef,
  $install_path             = $kibana::params::install_path,
  $apache_conf_dir          = $kibana::params::apache_conf_dir,
  $vhost_name               = $kibana::params::vhost_name,
  $serveradmin              = $kibana::serveradmin,
  $elasticsearch_server     = $kibana::params::elasticsearch_server,
) inherits kibana::params {

  #### Validate parameters

  # ensure
  if ! ($ensure in [ 'present', 'absent', 'unmanaged' ]) {
    fail("\"${ensure}\" is not a valid ensure parameter value")
  }

  #### Manage actions

  # package(s)
  class { 'kibana::package': }

  # configuration
  class { 'kibana::config': }

  #### Manage relationships

  if $ensure == 'present' {
    # we need the software before configuring it
    Class['kibana::package'] -> Class['kibana::config']

  }

}
