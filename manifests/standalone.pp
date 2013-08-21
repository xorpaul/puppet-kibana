# == Class: kibana::standalone
#
# This class is able to install or remove kibana on a node.
# It manages the status of the related service.
#
#
#
# === Parameters
#
#
#
# === Examples
#
#
#
# === Authors
#
# * Richard Pijnenburg <mailto:richard@ispavailability.com>
#
class kibana::standalone( )
inherits kibana::params {

  if $kibana::standalone == true {

    ## Get the init file we provide
    case $::operatingsystem {
      'RedHat', 'CentOS', 'Fedora', 'Scientific', 'Amazon': {
        $initscript = template("${module_name}/etc/init.d/kibana.init.RedHat.erb")
      }
      'Debian', 'Ubuntu': {
        $initscript = template("${module_name}/etc/init.d/kibana.init.Debian.erb")
      }
      default: {
        fail("\"${module_name}\" provides no default init file
              for \"${::operatingsystem}\"")
      }

    }

    file { '/etc/init.d/kibana':
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      mode    => '0755',
      content => $initscript,
    }

  }


}
