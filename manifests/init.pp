# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include nginx
class nginx (
  Optional[String] $package_provider,
  Optional[String] $version,
  Optional[String] $nginx_conf_template,
) {
  case $facts['os']['family'] {
    'windows': {
      $conf_dir = "c:/tools/nginx-${facts['nginx_version']}/conf"
    }
    'RedHat':  { $conf_dir = '/etc/nginx'  }
    default: { fail("Unsupported osfamily: ${facts['os']['family']}") }
  }
  $sites_enabled_dir = "${conf_dir}/sites-enabled"
  $nginx_conf        = "${conf_dir}/nginx.conf"
  service { 'nginx':
    ensure    => running,
    enable    => true,
    require   => Package['nginx'],
    subscribe => File[$nginx_conf],
  }
  package { 'nginx':
    ensure   => $version,
    provider => $package_provider,
  }
  file { 'nginx_conf':
    ensure  => file,
    path    => $nginx_conf,
    content => epp($nginx_conf_template, {
      conf_dir          => $conf_dir,
      sites_enabled_dir => $sites_enabled_dir,
    }),
  }
  file { 'sites_enabled_dir':
    ensure => directory,
    path   => $sites_enabled_dir,
  }
}
