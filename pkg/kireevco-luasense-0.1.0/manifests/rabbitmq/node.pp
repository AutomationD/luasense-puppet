class luasense::rabbitmq::node (
  $cluster_nodes = $::luasense::rabbitmq::config::cluster_nodes,
  $cluster_node_type = $::luasense::rabbitmq::config::cluster_node_type,
  $erlang_cookie = $::luasense::rabbitmq::config::erlang_cookie
) inherits luasense::rabbitmq::config {

  $node_name = 'luasense'
  $password = 'LuaS4ngspbw'

##  ->
##
##  file {'/etc/rabbitmq/enabled_plugins':
##    ensure => present,
##    mode => 644,
##  # notify => Service['rabbitmq-server'],
##  }
#
#  ->

  class { 'rabbitmq':
    config_cluster    => true,
    cluster_nodes     => $cluster_nodes,
    cluster_node_type => $cluster_node_type,
    #  config_mirrored_queues => true,
    wipe_db_on_cookie_change => true,
    erlang_cookie => $erlang_cookie,
    plugin_dir => '/etc/rabbitmq/enabled_plugins',
    #erlang_enable => true,
    admin_enable => true,
    environment_variables   => {
      'RABBITMQ_NODENAME'     => $node_name,
      'RABBITMQ_SERVICENAME'  => 'RabbitMQ',
    },
    require => Package['erlang'],
  }

  ->
  rabbitmq_plugin {['rabbitmq_stomp','rabbitmq_mqtt','rabbitmq_web_stomp','rabbitmq_shovel']:
    ensure => present,
  }
  
#  ->
  
#  rabbitmq_user { $node_name:
#    admin    => true,
#    password => $password,
#  }
#
#  ->
#  rabbitmq_vhost { $node_name:
#    ensure => present,
#  }
#  ->
#  rabbitmq_user_permissions { "$node_name@$node_name":
#    configure_permission => '.*',
#    read_permission      => '.*',
#    write_permission     => '.*',
#  }

  package { "erlang":
    ensure => installed,
  }

}