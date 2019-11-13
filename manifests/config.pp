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
  String               $project_inactivity_timeout = '',
  String               $project_dangling_timeout = '',
  String               $projects_root = '',
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
      'ci'                         => $ci,
      'native'                     => $native_docker,
      'katacoda'                   => $katacoda,
      'stats_optout'               => $stats_optout,
      'env'                        => $env,
      'uuid'                       => fqdn_uuid($name),
      'project_inactivity_timeout' => $project_inactivity_timeout,
      'project_dangling_timeout'   => $project_dangling_timeout,
      'projects_root'              => $projects_root
    }),
    owner   => $name,
    group   => $name,
    require => File[$config_dir]
  }

  exec { "initial_update_fin_for_${name}":
    command     => '/usr/local/fin update --stack',
    cwd         => $home_directory,
    environment => "HOME=${home_directory}",
    user        => $name,
    creates     => "${config_dir}/stacks",
  }

  exec { "reset_fin_system_for_${name}":
    command     => '/usr/local/fin system reset',
    cwd         => $home_directory,
    environment => "HOME=${home_directory}",
    user        => $name,
    subscribe   => File["${config_dir}/docksal.env"],
    refreshonly => true,
  }
}
