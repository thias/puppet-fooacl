# Class: fooacl
#
# Main class, to start managing ACLs with the fooacl module.
#
# Sample Usage :
#  include '::fooacl'
#
class fooacl ( $noop = false ) {

  include '::concat::setup'

  $notify = $noop ? {
    true  => undef,
    false => Exec['/usr/local/sbin/fooacl.php'],
  }

  # Main script, to apply ACLs when the configuration changes
  exec { '/usr/local/sbin/fooacl.php':
    refreshonly => true,
  }
  concat { '/usr/local/sbin/fooacl.php':
    mode   => '0755',
    notify => $notify,
  }
  concat::fragment { 'fooacl-header':
    target  => '/usr/local/sbin/fooacl.php',
    order   => 10,
    content => template("${module_name}/10.erb"),
  }
  concat::fragment { 'fooacl-footer':
    target  => '/usr/local/sbin/fooacl.php',
    order   => 30,
    content => template("${module_name}/30.erb"),
  }

}

