# Install and update Docksal.
#
# @summary Install and update Docksal.
#
# @example
#   include docksal
class docksal (
  String $version,
) {
  file { '/usr/local/fin':
    ensure => file,
    source => "https://raw.githubusercontent.com/docksal/docksal/${version}/bin/fin",
    mode   => '0755',
    owner  => 'root',
    group  => 'root'
  }
}
