class roundcube::packages (
  $apt_mirror   = $roundcube::params::apt_mirror,
  $apt_release  = $roundcube::params::apt_release, 
  ) inherits roundcube::params {

  $packagelist = ['roundcube', 'roundcube-core', 'roundcube-plugins']

  apt::source { $apt_release:
    location => $apt_mirror,
    repos    => 'main',
  }

  apt::pin { 'roundcube':
    packages => 'roundcube*',
    priority => 1001,
    release  => $apt_release,
  }

  package { "roundcube-${roundcube_backend}":
    ensure  => installed,
  }

  package { $packagelist:
    ensure  => installed,
    require => Package["roundcube-${roundcube_backend}"],
  }

}
