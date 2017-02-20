class roundcube::params {
  #database params
  $confdir                    = '/etc/roundcube'
  $database_host              = $::fqdn
  $database_port              = '5432'
  $database_name              = 'roundcubedb'
  $database_username          = 'roundcubedb'
  $database_password          = 'roundcubedb'
  $database_ssl               = false
  $postgres_listen_addresses  = $::fqdn
  $roundcube_backend          = 'pgsql'
  $roundcube_webserver        = 'apache'
  $ip_mask_allow_all_users    = '0.0.0.0/0'

  #spellchecker params
  $spellcheck_engine          = 'googie'
  $spellcheck_languages       = []

  #webserver params
  $apt_mirror                 = 'http://ftp.debian.org/debian'
  $main_inc_php_erb           = 'roundcube/main.inc.php.erb'
  $plugins                    = undef
  $default_host               = ''
  $default_vhost_on           = true
  $default_mods               = false
  $default_confd_files        = false
  $des_key                    = 'rcmail-!24ByteDESkey*Str'
  $mpm_module                 = 'prefork'
  $force_https                = false
  $imap_auth_type             = 'null'
  $log_logins                 = false
  $servername                 = $::fqdn
  $serveraliases              = []
  $skin                       = 'larry'
  $smtp_server                = ''
  $smtp_port                  = 25
  $smtp_user                  = ''
  $smtp_pass                  = ''
  $smtp_auth_type             = ''
  $timezone                   = 'auto'
  $documentroot               = '/var/lib/roundcube'
  $purge_configs              = true
  $reconfigure_command        = '/usr/sbin/dpkg-reconfigure'
  $scriptaliases              = [ { alias          => '/program/js/tiny_mce/',
                                    path           => '/usr/share/tinymce/www/' } ]
  $apache_port                = '80'
  $addhandlers                = []
  $ssl                        = false
  $ssl_ca                     = undef
  $ssl_cert                   = undef
  $ssl_key                    = undef
  $redirect_to_ssl            = false
  $suphp_user                 = 'roundcube'
  $suphp_group                = 'roundcube'
  $rewrites                   = undef
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
