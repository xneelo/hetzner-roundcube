class roundcube::spellchecker::aspell (
    $languagelist = ['en']
  ) {

  $langlist = prefix($languagelist, 'aspell-')

  $packagelist = concat(['aspell', 'php-enchant'], $langlist)

  package { $packagelist:
    ensure  => installed,
  }

}
