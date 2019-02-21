# Install and update Docksal.
#
# @summary Install and update Docksal.
#
# @example
#   include docksal
#
# @param version
#   Specify the version of docksal to install. Can be any of a git tag, commit ref, or branch
class docksal (
  String $version,
  String $prefix
) {
  file { "${prefix}/fin":
    ensure => file,
    source => "https://raw.githubusercontent.com/docksal/docksal/${version}/bin/fin",
    mode   => '0755',
    owner  => 'root',
    group  => 'root'
  }
}
