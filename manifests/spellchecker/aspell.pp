class roundcube::spellchecker::aspell (
    $languagelist = ['en']
  ) {

  $langlist = prefix($languagelist, 'aspell-')

  $packagelist = concat(['aspell', 'php7.0-enchant'], $langlist)

  package { $packagelist:
    ensure  => installed,
  }

}
