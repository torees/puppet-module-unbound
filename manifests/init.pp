# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include unbound
class unbound {

  File {
    owner   => 'root',
    group   => 'unbound',
    mode    => '0644',
    require => Package['unbound'],
    notify  => [Service['unbound'], Exec['unbound-checkconf']],
  }

  package { 'unbound':
    ensure   => 'present',
  }

  file { '/etc/unbound/unbound.conf':
    content => template('unbound/unbound.conf.epp'),
  }

  file { '/etc/unbound/root.hints':
    source  => 'puppet:///modules/unbound/root.hints',
  }

  file{'/etc/unbound/conf.d':
    ensure  => directory,
    recurse => true,
    purge   => true,
  }

  service {'unbound':
    ensure  => 'running',
    require => Package['unbound'],
  }

  exec {'unbound setup':
    command => '/usr/sbin/unbound-control-setup',
    creates => '/etc/unbound/unbound_server.pem',
    notify  => Service['unbound'],

  }
  exec {'unbound-checkconf':
    before      => Service['unbound'],
    path        => ['/usr/sbin'],
    refreshonly => true,


  }
}
