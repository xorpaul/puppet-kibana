# == Class: kibana::service
#
# This class exists to coordinate all service management related actions,
# functionality and logical units in a central place.
#
# <b>Note:</b> "service" is the Puppet term and type for background processes
# in general and is used in a platform-independent way. E.g. "service" means
# "daemon" in relation to Unix-like systems.
#
#
# === Parameters
#
# This class does not provide any parameters.
#
#
# === Examples
#
# This class may be imported by other classes to use its functionality:
#   class { 'kibana::service': }
#
# It is not intended to be used directly by external resources like node
# definitions or other modules.
#
#
# === Authors
#
# * Richard Pijnenburg <mailto:richard@ispavailability.com>
#
class kibana::service {

  #### Service management

  # Only when we are running stand-alone we will configure the service
  if $kibana::standalone == true {

    # set params: in operation
    if $kibana::ensure == 'present' or $kibana::ensure == 'unmanaged' {

    #notify { "kibana::ensure: ${kibana::ensure}": }

      case $kibana::status {
        # make sure service is currently running, start it on boot
        'enabled': {
          $service_ensure = 'running'
          $service_enable = true
        }
        # make sure service is currently stopped, do not start it on boot
        'disabled': {
          $service_ensure = 'stopped'
          $service_enable = false
        }
        # make sure service is currently running, do not start it on boot
        'running': {
          $service_ensure = 'running'
          $service_enable = false
        }
        # do not start service on boot, do not care whether currently running or not
        'unmanaged': {
          $service_ensure = undef
          $service_enable = false
        }
        # unknown status
        # note: don't forget to update the parameter check in init.pp if you
        #       add a new or change an existing status.
      default: {
        fail("\"${kibana::status}\" is an unknown service status value")
      }
    }

    # set params: removal
    } else {

      # make sure the service is stopped and disabled (the removal itself will be
      # done by package.pp)
      $service_ensure = 'stopped'
      $service_enable = false

    }

    #notify { "ensure: $service_ensure -- enable: $service_enable --": }
    # action
    service { 'kibana':
      ensure     => $service_ensure,
      enable     => $service_enable,
      name       => $kibana::params::service_name,
      hasstatus  => $kibana::params::service_hasstatus,
      hasrestart => $kibana::params::service_hasrestart,
      pattern    => $kibana::params::service_pattern,
    }

  }

}
