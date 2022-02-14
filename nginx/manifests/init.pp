# @summary A short summary of the purpose of this class
# A description of what this class does
# @example
#   include nginx
class nginx {
  $package_provider = $facts['os']['family'] ? {
    'windows' => 'chocolatey',
    default   => undef,
  }
  service { 'nginx':
    ensure  => running,
    enable  => true,
    require => Package['nginx'],
  }
  package { 'nginx':
    ensure   => latest,
    provider => $package_provider,
  }
}
