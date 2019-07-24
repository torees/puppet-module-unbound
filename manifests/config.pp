# @summary A short summary of the purpose of this defined type.
#
# A description of what this defined type does
#
# @example
#   unbound::config { 'namevar': }
define unbound::config (
    String $content,
) {

  include unbound

  file{"/etc/unbound/conf.d/${title}.conf":
    ensure  => present,
    content => $content,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    notify  => [Exec['unbound-checkconf'],Service['unbound']],
    require => Package['unbound'],
  }
}
