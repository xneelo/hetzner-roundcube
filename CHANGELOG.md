##2022-03-24 - Release 1.2.1
###Summary

* Removed PHP versioning to enable default php install

##2020-06-30 - Release 1.2.0
###Summary

* Bump version to match supported Roundcube version
* Update PostgreSQL schema to version 2015111100
* Bump Dependencies

##2019-01-15 - Release 0.2.1
###Summary

* Support RoundCube 1.2.X
* Default config changes
  - HTML editor infavour of text editor
  - Junk mailbox to defaults to spambucket mailbox
  - always ask before downloading images
  - replies place cursor above original message (top posting)
  - log successful/failed logins
* Add support for pspell
* License and ReadMe updated

##2017-02-23 - Release 0.1.35
###Summary

* Fix apache module references for puppet 4

##2017-02-20 - Release 0.1.33
###Summary

* Bump apt module support to 2.3.0
* Bump apache module support to 1.11.0 to fix concat warning
* Update default params for Puppet 4

##2017-02-08 - Release 0.1.30
###Summary

* Fix syntax error in roundcubeweb.pp

##2017-02-07 - Release 0.1.29
###Summary

* Extend support for passing params to populate main.inc.php file
  - default_host
  - des_key
  - imap_auth_type
  - log_logins
  - skin
  - smtp_server
  - smtp_port
  - smtp_user
  - smtp_pass
  - smtp_auth_type
  - timezone

##2017-02-07 - Release 0.1.28
###Summary

* Add plugin parameter option

##2016-10-24 - Release 0.1.27
###Summary

* Parametrize the roundcube-core reconfigure to support Puppet 3.7

##2016-06-02 - Release 0.1.26
###Summary

* Remove manage_firewall parameter, to allow support for postgresql module version > 4.0.0
  https://forge.puppet.com/puppetlabs/postgresql/changelog

##2016-05-25 - Release 0.1.25
###Summary

* Sort out version dependencies for stdlib to not be fixed to single version

##2016-05-17 - Release 0.1.24
###Summary

* Fix require to .pgpass use Concat and not File

##2016-02-24 - Release 0.1.23
###Summary

* Fix puppet lint for main config
* Include license
* Update dependancies

##2015-10-27 - Release 0.1.20
###Summary

* Add aspell as optional spellchecker engine

##2015-05-05 - Release 0.1.19
###Summary

* Fix puppet lint
* Update dependancies

##2014-11-20 - Release 0.1.18
###Summary

* Make the default value for rewrite param undef

##2014-11-20 - Release 0.1.17
###Summary

* Fix the pin priority for the backports preferences

##2014-11-20 - Release 0.1.16
###Summary

* Add the ability to add rewrite rules for apache

##2014-11-06 - Release 0.1.15
###Summary

* Directories array of hashes now also includes addhandler hash for compatibility with puppetlabs-apache module version 1.1.1
