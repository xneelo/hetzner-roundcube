roundcube
=========

####Table of Contents

1. [Overview - What is the roundcube module?](#overview)
2. [Module Description - What does the module do?](#module-description)
3. [Setup - The basics of getting started with the roundcube module](#setup)
    * [What the roundcube module affects](#what-roundcube-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with the roundcube module](#beginning-with-roundcube)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

Overview
--------

The roundcube module allows you to easilly manage a roundcube webmail instance.
Please see the roundcube project page for details about the service: www.roundcube.net

Module Description
------------------

Roundcube is a browser-based IMAP client.
This module consists of the classes to implement roundcube.
The default behaviour of the roundcube package installation on Debian, is to install the web frontend packages (and all the dependent packages) and mysql as the default backend service on the same host.
This module was compiled in a way that allows the frontend and backend to be installed on the same or on different hosts.
The frontend classes will install all the required packages on the host that will serve the roundcube web frontend.
The backend classes will ensure that the required data store is configured and ready to serve data to the frontend.
Note that the module, though very configurable by using parameterised classes, makes some assumptions and defaults about the environment that it runs on.

Setup
-----

###What roundcube affects:

* package/service/configuration files for RoundCube
* package/service/configuration files for Apache (optional, but set as default)
* package/service/configuration files for PostgreSQL (optional, but set as default)
* puppet master's runtime (via plugins)
* listened-to ports

###Setup Requirements:

Pluginsync is required if you haven't got all the dependent modules already installed on your puppet implementation.
The following additional modules are installed from the forge as dependencies
* puppetlabs/apache
* puppetlabs/apt
* puppetlabs/postgresql
* puppetlabs/inifile
  
###Beginning with roundcube

Whether you choose a single node or a multi-node setup, a basic setup of Roundcube will cause: 
* PostgreSQL to install on the node if it’s not already there.
* Roundcube postgres database instance and user account to be created
* the postgres connection to be validated and, if successful, Roundcube to be installed and configured
* Roundcube connection to be validated
* Apache to install on the node if it's not already there, mod-php installed and activated
* roundcube virtualhost configuration created with default directories and options
* roundcube-pgsql, roundcube-core and roundcube-plugins packages to be installed

Apply the roundcube::roundcubeweb as well as the roundcube::webservice::apache class on the host that will serve the roundcube web site.
Apply the roundcube::database::postgresql class to the host where you want the database installed.

Usage
-----

###roundcube::roundcubeweb

The roundcubeweb class is the main class that will get your frontend up and running

**Parameters within roundcube::roundcubeweb**

####`apt_mirror`

What apt mirror to use for package installs (defaults to 'http://ftp.debian.org/debian')

####`confdir`

The path containing the roundcube configuration files: db.inc.php and main.inc.php (defaults to /etc/roundcube).

####`roundcube_webserver`

The webserver technology used to host the roundcube site (defaults to apache)

####`roundcube_backend`

The database technology used to host the roundcube database (defaults to postgresql)

####`database_host`

The hostname of the server that will host the roundcube database (defaults to `$::fqdn`)

####`database_port`

The port for the database to listen on (defaults to 5432)

####`database_name`

What to call the roundcube database (defaults to roundcubedb)

####`database_username`

What user to create for access to the roundcube database (defaults to roundcubedb)

####`database_password`

The password to use to access the roundcube database as the database_username (defaults to roundcubedb)

####`database_ssl`

Whether or not to connect to the database via ssl (defaults to false)

####`listen_addresses`

What ip(s) postgresql should listen on (default to `$::fqdn`)

####`open_postgres_port`

Firewall options for the postgresql host (defaults to undef)

####`main_inc_php_erb`

The location of the main.inc.php.erb template file (defaults to 'roundcube/main.inc.php.erb')

**Parameters within roundcube::webservice::apache**

These are the parameters used to configure apache to server the roundcube web

####`default_vhost_on`

Whether or not to create a default virtual host with the apache installation (defaults to false)

####`servername`

What servername to set in the roundcube virtualhost file (defaults to `$::fqdn`)

####`serveraliases`

An array of serveraliases to add to the virtualhost file (defaults to [])

####`documentroot`

The documentroot for the roundcube virtual host (defaults to '/var/lib/roundcube')

####`addhandlers`

An array of handlers to add to the defined directory section in the virtual host (defaults to [])

####`purge_configs`

Removes all other apache configs and vhosts (defaults to true)

####`default_mods`

Whether or not to install OS specific default modules (defaults to false)

####`default_confd_files`

Whether to purge the default configuration files in the apache conf.d directory (defaults to false)

####`mpm_module`

What mpm module to use for apache (defaults to prefork)

####`scriptaliases`

Scriptaliases to include in the virtual host file (defaults to `[ { alias => '/program/js/tiny_mce/', path => '/usr/share/tinymce/www/' } ]`)

####`apache_port`

The port to bind the apache process to (defaults to '80')

####`directories`

What directories to configure for the virtualhost (defaults are as below)     
```
{ path           => $documentroot,
options        => '+FollowSymLinks',
allow_override => 'All',
order          => 'allow,deny',
allow          => 'from all' },

{ path           => "${documentroot}/config",
options        => '-FollowSymLinks',
allow_override => 'None' }, 

{ path           => "${documentroot}/temp",
options        => '-FollowSymLinks',
allow_override => 'None',
order          => 'allow,deny',
deny           => 'from all' }, 

{ path           => "${documentroot}/logs",
options        => '-FollowSymLinks',
allow_override => 'None',
order          => 'allow,deny',
deny           => 'from all' }, 

{ path           => '/usr/share/tinymce/www/',
options        => 'Indexes MultiViews FollowSymLinks',
allow_override => 'None',
order          => 'allow,deny',
allow          => 'from all' }
```

**Parameters within roundcube::database::postgresql**

####`listen_addresses`

The address that the web server should bind to for HTTP requests (defaults to `$::fqdn`)

####`database_host`

The host that runs the roundcube database (defaults to `$::fqdn`)

####`database_name`

The name of the database that roundcube uses (defaults to 'roundcubedb')

####`database_username`

The name of the user configured to access the roundcube database (defaults to 'roundcubedb')

####`database_password`

The password used to access the roundcube database (defaults to 'roundcubedb')

##Limitations

* The module has only been tested and built on Debian7 (Wheezy).
* The wheezy-backports roundcube packages are required and installed, making use of the puppetlabs/apt module to pin them.
* The module defaults to using apache as the web server and uses the puppetlabs/apache module to configure it.
* The module defaults to using mod-php with apache.
* The module defaults to using postgresql as the database server and uses the puppetlabs/postgresql module to configure it.
* The database configuration is modified by using the puppetlabs/inifile module resources and updating the /etc/dbconfig-common/roundcube file
  with all the relevant database config options, then calling dpkg-reconfigure roundcube-core, as per the package documentation/recommendation.
* So far no support for adding and installing additional roundcube plugins has been done, but this will probably happen in the next iteration of the module.

##Development

Feel free and please add compatibility with other platforms, databases and webservers, but please adhere to the puppet modules

You can read the complete module contribution guide [on the Puppet Labs wiki.](http://projects.puppetlabs.com/projects/module-site/wiki/Module_contributing)
