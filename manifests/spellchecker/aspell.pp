class roundcube::spellchecker::aspell (
    $languagelist = ['en']
  ) {

  $langlist = prefix($languagelist, 'aspell-')

  $packagelist = concat(['aspell', 'php7.1-enchant'], $langlist)

  package { $packagelist:
    ensure  => installed,
  }

}
