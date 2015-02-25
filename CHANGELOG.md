* Add 'set -e' for exit status to be non-zero for any error (#9, @ngiger).
* No longer include concat::setup as it is deprecated.

#### 2014-09-09 - 1.0.0
* Install required packages for acl functionality (#6, @Slashbunny).
* Fix 20.erb template parse error (#8).

#### 2014-04-29 - 0.1.3
* Enable permissions to be nested arrays.
* Rename 'noop' to 'fooacl_noop' because of reserved metaparameter name.

#### 2014-03-14 - 0.1.2
* Fix puppetlabs/concat requirement syntax causing librarian-puppet to fail.

#### 2014-02-11 - 0.1.1
* Sort so that sub-directory ACLs get applied after parent directory ACLs.

#### 2013-12-16 - 0.1.0
* Initial module release.

