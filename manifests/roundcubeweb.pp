class roundcube::roundcubeweb (
  $confdir                   = $roundcube::params::confdir,
  $config_inc_php_erb        = $roundcube::params::config_inc_php_erb,
  $database_host             = $roundcube::params::database_host,
  $database_name             = $roundcube::params::database_name,
  $database_password         = $roundcube::params::database_password,
  $database_port             = $roundcube::params::database_port,
  $database_ssl              = $roundcube::params::database_ssl,
  $database_username         = $roundcube::params::database_username,
  $default_host              = $roundcube::params::default_host,
  $des_key                   = $roundcube::params::des_key,
  $force_https               = $roundcube::params::force_https,
  $imap_auth_type            = $roundcube::params::imap_auth_type,
  $listen_addresses          = $roundcube::params::postgres_listen_address,
  $log_logins                = $roundcube::params::log_logins,
  $plugins                   = $roundcube::params::plugins,
  $reconfigure_command       = $roundcube::params::reconfigure_command,
  $roundcube_backend         = $roundcube::params::roundcube_backend,
  $roundcube_webserver       = $roundcube::params::roundcube_webserver,
  $skin                      = $roundcube::params::skin,
  $smtp_server               = $roundcube::params::smtp_server,
  $smtp_port                 = $roundcube::params::smtp_port,
  $smtp_user                 = $roundcube::params::smtp_user,
  $smtp_pass                 = $roundcube::params::smtp_pass,
  $smtp_auth_type            = $roundcube::params::smtp_auth_type,
  $spellcheck_engine         = $roundcube::params::spellcheck_engine,
  $spellcheck_languages      = $roundcube::params::spellcheck_languages,
  $timezone                  = $roundcube::params::timezone,
  ) inherits roundcube::params {

  include ::roundcube::packages

  if $spellcheck_engine == 'aspell' {
    class { '::roundcube::spellchecker::aspell':
      languagelist => $spellcheck_languages
    }
  }
  else {
    include ::roundcube::spellchecker::pspell
  }

  #Set the defaults
  Ini_setting {
    path    => '/etc/dbconfig-common/roundcube.conf',
    ensure  => present,
    section => '',
    notify  => Exec['reconfigure_roundcube'],
    require => Package['roundcube-core'],
  }

  # TODO: figure out some way to make sure that the ini_file module is installed,
  #  because otherwise these will silently fail to do anything.

  ini_setting {'dbtype':
    setting => 'dbc_dbtype',
    value   => "'${roundcube_backend}'",
  }

  ini_setting {'dbuser':
    setting => 'dbc_dbuser',
    value   => "'${database_username}'",
  }

  ini_setting {'dbpass':
    setting => 'dbc_dbpass',
    value   => "'${database_password}';",
  }

  ini_setting {'dbname':
    setting => 'dbc_dbname',
    value   => "'${database_name}';",
  }

  ini_setting {'dbserver':
    setting => 'dbc_dbserver',
    value   => "'${database_host}';",
  }

  ini_setting {'dbport':
    setting => 'dbc_dbport',
    value   => "'${database_port}';",
  }

  ini_setting {'dbssl':
    setting => 'dbc_ssl',
    value   => "'${database_ssl}';",
  }

  exec { 'reconfigure_roundcube':
    refreshonly => true,
    command     => "${reconfigure_command} roundcube-core",
  }

  file { "${confdir}/config.inc.php":
    owner   => root,
    group   => www-data,
    mode    => '0640',
    content => template($config_inc_php_erb),
  }

}
