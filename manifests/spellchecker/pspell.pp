class roundcube::spellchecker::pspell {

  package { 'php-pspell':
    ensure  => installed,
  }

}
