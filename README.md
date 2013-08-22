## Usage:

Clone the kibana3 git repo

    git clone git@github.com:elasticsearch/kibana.git                        
    Cloning into 'kibana'...
    remote: Counting objects: 3825, done.
    remote: Compressing objects: 100% (2130/2130), done.
    remote: Total 3825 (delta 2024), reused 3378 (delta 1648)
    Receiving objects: 100% (3825/3825), 12.67 MiB | 2.91 MiB/s, done.
    Resolving deltas: 100% (2024/2024), done.
    

OPTIONAL: If you want to use logstash interface as default:

    mv kibana/dashboards/{logstash.json,default.json}

Create the archive:

    tar cfj kibana-3.0.0m3pre.tar.bz2 kibana/ --exclude=.git

Move the archive to the kibana puppet module under files

## Puppet config:

    class { 'kibana':
      pkg_name             => 'kibana-3.0.0m3pre.tar.bz2', # your kibana file name
      install_path         => '/usr/share/kibana', # where to extract kibana
      apache_conf_dir      => '/etc/apache2/sites-enabled', # if this is set it will place a simple vhost file into this dir
      vhost_name           => 'kibana', # defaults to $::fqdn
      elasticsearch_server => 'logstash.server.lan:9200', # gets inserted in the config.js
    }
