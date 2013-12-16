# puppet-fooacl

## Overview

Manage POSIX filesystem ACLs with Puppet.

* `fooacl` : Class to start managing ACLs with the module.
* `fooacl::conf`: Definition to manage ACLs configuration.

Either:
* $target is not specificed, in which case $title must be the target
* $target is specified, as a directory or an array of directories, in which
  case $title is ignored (this allows to work around duplicate declarations)

Note that the special $title of 'default' will apply permissions to all
directories managed by fooacl on the node. Useful for global access on
staging and development.

## Examples


