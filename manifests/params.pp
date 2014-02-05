class roundcube::params {
  #database params
  $confdir                    = '/etc/roundcube'
  $database_host              = $::roundcubedb_postgresql_server
  $database_port              = '5432'
  $database_name              = 'roundcubedb'
  $database_username          = 'roundcubedb'
  $database_password          = 'roundcubedb'
  $database_ssl               = false
  $postgres_listen_addresses  = $::roundcubedb_postgresql_server
  $open_postgres_port         = undef
  $roundcube_backend          = 'psql'
  $roundcube_webserver        = 'apache'

  #webserver params
  $apt_mirror                 = 'http://ftp.debian.org/debian'
  $main_inc_php_erb           = 'roundcube/main.inc.php.erb'
  $default_vhost_on           = true
  $default_mods               = false
  $default_confd_files        = false
  $mpm_module                 = 'prefork'
  $servername                 = $::fqdn
  $serveraliases              = []
  $documentroot               = '/var/lib/roundcube'
  $purge_configs              = true
  $scriptaliases              = [ { alias          => '/program/js/tiny_mce/',
                                    path           => '/usr/share/tinymce/www/' } ]
  $apache_port                = '80'
  $addhandlers                = []
  $suphp_user                 = 'roundcube'
  $suphp_group                = 'roundcube'
  $directories                = [ { path           => $documentroot,
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
                                    allow          => 'from all' } ]

}
