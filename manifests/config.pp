# A description of what this defined type does
#
# @summary A short summary of the purpose of this defined type.
#
# @example
#   docksal::config { 'namevar': }
define docksal::config(
  String $user_home = "/home/${name}",
  Boolean $ci = false,
  Boolean $native_docker = false,
  Boolean $katacoda = false
) {
  $config_dir = "${user_home}/.docksal"
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
