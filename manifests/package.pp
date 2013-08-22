# == Class: kibana::package
#
# This class exists to coordinate all software package management related
# actions, functionality and logical units in a central place.
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
#   class { 'kibana::package': }
#
# It is not intended to be used directly by external resources like node
# definitions or other modules.
#
#
# === Authors
#
# * Richard Pijnenburg <mailto:richard@ispavailability.com>
#
class kibana::package {

  #### Package management

  # set params: in operation
  if $kibana::ensure == 'present' {

    # action
    file { "${kibana::install_path}/${kibana::pkg_name}":
      ensure   => $kibana::ensure,
      source   => "puppet:///modules/${module_name}/${kibana::pkg_name}",
    }

    file { $kibana::install_path:
      ensure => 'directory',
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
    }

    exec { "unzip_${kibana::pkg_name}":
      cwd     => $kibana::install_path,
      command => "/bin/tar xfj ${kibana::install_path}/${kibana::pkg_name}",
      creates => "${kibana::install_path}/kibana",
      require => [ File[$kibana::install_path], File["${kibana::install_path}/${kibana::pkg_name}"] ],
    }

  }
}
