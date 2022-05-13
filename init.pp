
class cowsay {

  package { 'gem':
    ensure   => present,
    provider => 'yum',
  }

  package { 'cowsay':
    ensure          => present,
    provider        => 'gem',
  }
}
