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
  String $home_directory = "/home/${name}",
  Boolean $ci = false,
  Boolean $native_docker = false,
  Boolean $katacoda = false
) {
  $config_dir = "${home_directory}/.docksal"
  file { $config_dir:
    ensure => directory,
    owner  => 'root',
    group  => 'root',
    mode   => '0755'
  }

  file { "${config_dir}/docksal.env":
    ensure  => file,
    content => epp('docksal/docksal.env.epp', {'ci' => $ci, 'native' => $native_docker, 'katacoda' => $katacoda}),
    require => File[$config_dir]
  }
}
