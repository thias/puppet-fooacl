# Define: fooacl::conf
#
# Configure the Posix ACLs set by the script from the fooacl class.
#
define fooacl::conf (
  $target      = $name,
  $order       = 20,
  $permissions,
) {

  include '::fooacl'

  concat::fragment { $title:
    target  => '/usr/local/sbin/fooacl',
    order   => $order,
    content => template("${module_name}/20.erb"),
  }

}

