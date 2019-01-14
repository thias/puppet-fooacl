# Class: fooacl
#
# Main class, to start managing ACLs with the fooacl module.
#
# Sample Usage :
#  include '::fooacl'
#
class fooacl (
  $acl_opts_global    = '-R -b',
  $fooacl_noop        = false,
  $acl_package_ensure = 'present',
  $acl_package_name   = $::fooacl::params::acl_package_name,
) inherits ::fooacl::params {

  if $acl_package_name {
    package { $acl_package_name:
      ensure => $acl_package_ensure,
    }
  }

  $notify = $fooacl_noop ? {
    true  => undef,
    false => Exec['/usr/local/sbin/fooacl'],
  }

  # Main script, to apply ACLs when the configuration changes
  exec { '/usr/local/sbin/fooacl':
    refreshonly => true,
    require     => Package[$acl_package_name],
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
