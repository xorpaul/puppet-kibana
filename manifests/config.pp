# == Class: kibana::config
#
# This class exists to coordinate all configuration related actions,
# functionality and logical units in a central place.
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
#   class { 'kibana::config': }
#
# It is not intended to be used directly by external resources like node
# definitions or other modules.
#
#
# === Authors
#
# * Richard Pijnenburg <mailto:richard@ispavailability.com>
#
class kibana::config {

  #### Configuration

  #notify { "kibana::config_file: ${kibana::config_file} --": }
  #notify { "kibana::install_path: ${kibana::install_path} --": }

  if $kibana::config_file == true {

    file { 'kibana_config':
      ensure  => 'present',
      path    => "${kibana::install_path}/KibanaConfig.rb",
      mode    => '0644',
      owner   => 'root',
      group   => 'root',
      content => template("${module_name}/KibanaConfig.rb.erb"),
      notify  => Service['kibana'],
    }

  }

}
