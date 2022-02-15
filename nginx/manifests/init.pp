# manifests/init.pp
class nginx (
  Optional[String] $package_provider,
  Optional[String] $version,
) {
  service { 'nginx':
    ensure  => running,
    enable  => true,
    require => Package['nginx'],
  }
  package { 'nginx':
    ensure   => $version,
    provider => $package_provider,
  }

  notify { 'nginx_version_debug':
    message => "${facts[nginx_version]}"
  }
}
