# Class: fooacl
#
# Main class, to start managing ACLs with the fooacl module.
#
# Sample Usage :
#  include '::fooacl'
#
class fooacl ( $fooacl_noop = false ) {

  include '::concat::setup'

  $notify = $fooacl_noop ? {
    true  => undef,
    false => Exec['/usr/local/sbin/fooacl'],
  }

  # Main script, to apply ACLs when the configuration changes
  exec { '/usr/local/sbin/fooacl':
    refreshonly => true,
  }
  concat { '/usr/local/sbin/fooacl':
    mode   => '0755',
    notify => $notify,
  }
  concat::fragment { 'fooacl-header':
    target  => '/usr/local/sbin/fooacl',
    order   => 10,
    content => template("${module_name}/10.erb"),
  }
  concat::fragment { 'fooacl-footer':
    target  => '/usr/local/sbin/fooacl',
    order   => 30,
    content => template("${module_name}/30.erb"),
  }

}

