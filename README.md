# puppet-fooacl

## Overview

Manage POSIX filesystem ACLs with Puppet. This module is a stab at managing
ACLs using puppet. Most existing ACL modules implement a type which can be
declared only once per file. This module takes an unusual approach, by
creating a single large concatenated script to purge/apply all ACLs
recursively to all paths managed by the module.

Features :
* Set ACLs for the same path from different parts of your puppet manifests.
* Automatic purging of ACLs on paths as long as at least one ACL is still
  being applied by the module.
* Automatic setting of both normal and default ACLs to the same values.
* Ability to set 'default' ACL permissions to be applied for all paths
  managed by the module.

Limitations :
* No purging once paths are no longer being managed by the module.
* Any ACL change triggers re-applying of all ACLs (fine for a few thousands
  files, but possibly an issue for millions of files).

* `fooacl` : Class to start managing ACLs with the module (`fooacl::conf`
  automatically includes it).
* `fooacl::conf`: Definition to manage ACLs configuration.

## Examples

From somewhere in your puppet manifests :
```puppet
fooacl { '/var/www/www.example.com':
  permissions => [
    'user:userA:rwX',
    'user:userB:rwX',
    'user:userX:r-X',
  ],
}
```

From anywhere else, you may set more ACLs for the `/var/www/www.example.com`,
as long as you don't use the same `$title` (that would cause a duplicate
declatation), so you would do :
```puppet
fooacl { 'www.example.com-other-team':
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
  directories managed by fooacl on the node. Useful for global access on
  certain nodes.

