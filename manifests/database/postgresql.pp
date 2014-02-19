# Class for creating the RoundCube postgresql database.
class roundcube::database::postgresql (
  $listen_addresses  = $roundcube::params::database_host,
  $database_host     = $roundcube::params::database_host,
  $database_name     = $roundcube::params::database_name,
  $database_username = $roundcube::params::database_username,
  $database_password = $roundcube::params::database_password,
) inherits roundcube::params {

  # get the pg server up and running
  class { '::postgresql::server':
    ip_mask_allow_all_users => '0.0.0.0/0',
    listen_addresses        => $listen_addresses,
    manage_firewall         => $manage_firewall,
  }

  # create the roundcube database
  postgresql::server::db { $database_name:
    user     => $database_username,
    password => $database_password,
  }

  #Create role for database user
  postgresql::server::role { $database_username:
    password_hash => postgresql_password($database_username, $database_password),
  }

  #TODO: This part of the class is scaffold work required to get the schema for the roundcube database
  #      loaded and is pretty gross.  The postgres.initial.sql file was taken from the roundcube github site.
  #      The schema needs to be imported as the user that the database is created with because of the
  #      lacking functionality of the postgresql::server::grant class. So we should probably refactor
  #      once that class is ported to ruby.

  file { '/tmp/postgres.initial.sql':
    ensure => present,
    source => 'puppet:///modules/roundcube/postgres.initial.sql',
  }

  concat { '/var/lib/postgresql/.pgpass':
    ensure  => present,
    mode    => '0600',
    owner   => 'postgres',
    group   => 'postgres',
    require => Postgresql::Server::Db[$database_name],
  }

  concat::fragment { 'pgpass_initial':
    target  => '/var/lib/postgresql/.pgpass',
    content => "$database_host:*:$database_name:$database_username:$database_password\n",
  }

  # create the table structure
  exec { 'create_schema':
    command => "sudo -u postgres -i psql -U $database_username -h $database_host $database_name < /tmp/postgres.initial.sql",
    onlyif  => "sudo -u postgres -i psql $database_name -c \"\\dt\" | grep -c \"No relations found.\"",
    require => [ Postgresql::Server::Db[$database_name], File['/tmp/postgres.initial.sql'], File['/var/lib/postgresql/.pgpass'] ],
  }

}
