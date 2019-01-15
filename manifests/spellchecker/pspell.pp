class roundcube::spellchecker::pspell {

  package { 'php7.0-pspell':
    ensure  => installed,
  }

}
