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

  file { "${kibana::install_path}/kibana/config.js":
    ensure  => 'present',
    mode    => '0644',
    owner   => 'root',
    group   => 'root',
    content => template("${module_name}/config.js.erb"),
  }

  if $kibana::apache_conf_dir != undef {

    file { "${kibana::apache_conf_dir}/kibana.conf":
      ensure  => 'present',
      mode    => '0644',
      owner   => 'root',
      group   => 'root',
      content => template("${module_name}/etc/apache2/kibana.conf.erb"),
    }

  }

}
