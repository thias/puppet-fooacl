# Class: fooacl::params
#
# Per-platform parameters for fooacl class
#
class fooacl::params {
  case $facts['os']['family'] {
    'gentoo': {
      $acl_package_name = 'sys-apps/acl'
    }
    default: {
      $acl_package_name = 'acl'
    }
  }
}
