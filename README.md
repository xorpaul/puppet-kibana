## My changes:

Changed static init script to template with install\_path parameter.
Also tried to provide a Debian init script template.

Added new parameters and default values for KibanaConfig.rb config:


    # KibanaConfig.rb defaults
    $elasticsearch_servers = ['localhost']
    $elasticsearch_timeout = 500
    $listening_port = 5601
    $listening_ip = $::ipaddress
    $results_per_page = 100

## Usage:

    class { 'kibana':
      ensure                => 'unmanaged',
      status                => 'running',
      install_path          => '/data/kibana/',
      config_file           => true,
      elasticsearch_servers => ['myelasticsearchserver01:9200', 'myelasticsearchserver02:9200'],
    }

