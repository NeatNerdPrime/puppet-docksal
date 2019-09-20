# Configure docksal for an individual user.
#
# @summary manage the .docksal/docksal.env file for individual users.
#
# @example
#   docksal::config { 'username': }
#
# @param home_directory
#   The directory within which the config files for docksal live. Defaults to `/home/$name`.
#
# @param ci
#   Whether to add "CI=1" to the docksal env file.
#
# @param native_docker
#   Whether to add "NATIVEDOCKER=1" to the docksal env file.
#
# @param katacoda
#   Whether to add "KATACODA=1" to the docksal env file.
define docksal::config(
  Boolean              $ci,
  Boolean              $native_docker,
  Boolean              $katacoda,
  Boolean              $stats_optout,
  String               $home_directory = "/home/${name}",
  Hash[String, String] $env = {}
) {
  $config_dir = "${home_directory}/.docksal"
  file { $config_dir:
    ensure => directory,
    owner  => $name,
    group  => $name,
    mode   => '0755'
  }

  file { "${config_dir}/docksal.env":
    ensure  => file,
    content => epp('docksal/docksal.env.epp', {
      'ci'           => $ci,
      'native'       => $native_docker,
      'katacoda'     => $katacoda,
      'stats_optout' => $stats_optout,
      'env'          => $env,
      'uuid'         => fqdn_uuid($name),
    }),
    owner   => $name,
    group   => $name,
    require => File[$config_dir]
  }

  exec { "update_fin_for_${name}":
    command     => '/usr/local/fin update',
    cwd         => $home_directory,
    environment => "HOME=${home_directory}",
    user        => $name
  }
}
