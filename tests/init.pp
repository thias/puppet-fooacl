#include '::fooacl'

fooacl::conf { 'foo':
  target => [
    '/var/test/a.a',
    '/var/test/b.b',
  ],
  permissions => [
    'user:sssd:rwX',
    'group:puppet:rwX',
  ],
}
