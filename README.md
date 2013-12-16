# puppet-fooacl

## Overview

Manage POSIX filesystem ACLs with Puppet.

Most (all?) other ACL modules implement a type which can be declared only once
per file, which isn't flexible. This module takes the unusual approach of
creating a single large concatenated script to manage all ACLs recursively in
a single run. Ugly, yet very efficient and flexible since ACLs aren't tied to
the `file` type in any way.

Features :
* Set ACLs for the same path from different parts of your puppet manifests
  (flexible).
* Set global ACL permissions to be applied for all paths managed by the module
  (flexible).
* Automatic purging of ACLs on paths as long as at least one ACL is still
  being applied by the module (remove users easily and reliably).
* Automatic setting of both normal and default ACLs to the same values
  (shortens declarations, increases code readability).

Limitations :
* No purging once paths are no longer being managed by the module.
* Any ACL changes trigger re-applying all ACLs (fine for a few thousands
  files, but typically an issue for millions of files).

Module content :
* `fooacl` : Class to start managing ACLs with the module (`fooacl::conf`
  automatically includes it).
* `fooacl::conf`: Definition to manage ACLs configuration.

## Examples

A typical declaration from anywhere in your puppet manifests :
```puppet
fooacl::conf { '/var/www/www.example.com':
  permissions => [
    'user:userA:rwX',
    'user:userB:rwX',
    'user:userX:r-X',
  ],
}
```

From anywhere else, you may set more ACLs for the same
`/var/www/www.example.com` directory as long as you don't use the same
`$title` (that would cause a duplicate declatation), so you would do :
```puppet
fooacl::conf { 'www.example.com-other-team':
  target      => '/var/www/www.example.com',
  permissions => [
    'user:userC:rwX',
    'user:userY:r-X',
  ],
}
```

Parameter requirements :
* If `$target` is not specificed, `$title` must be the target.
* If `$target` is specified, as a directory or an array of directories,
  `$title` is ignored (this allows to work around duplicate declarations)
* The special `$title` of `'default'` will apply permissions to all
  directories managed by this module on the node. Useful for global access on
  certain nodes.

If you need to order some of your resources with the execution of the script
contained in the module (e.g. refresh when you modify uid or gid values), use :

```puppet
foo { 'bar':
  ...
  notify => Class['::fooacl'],
}
```

More advanced example :
```puppet
# Global webmasters
fooacl::conf { 'default':
  permissions => [
    'user:userA:rwX',
    'user:userB:rwX',
  ],
}
# Frontend website webmasters
fooacl::conf { 'frontend':
  target => [
    '/var/www/frontend.example.com',
    '/var/www/frontend.example.org',
  ],
  permissions => [
    'user:userX:rwX',
    'user:userY:rwX',
  ],
}
# Backend website webmasters
fooacl::conf { 'backend':
  target => [
    '/var/www/backend.example.com',
    '/var/www/backend.example.org',
  ],
  permissions => [
    'user:userZ:rwX',
  ],
}
```

