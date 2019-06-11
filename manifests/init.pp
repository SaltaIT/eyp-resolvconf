class resolvconf (
                    $resolvers        = [ '8.8.8.8', '8.8.4.4' ],
                    $domain           = undef,
                    $searchlist       = undef,
                    $rotate           = true,
                    $timeout          = '1',
                    $attempts         = '1',
                    $ignoreifconf     = true,
                    $disableimmutable = false,
                ) inherits resolvconf::params {

  $resolverlistsize=size($resolvers)

  Exec {
    path => '/usr/sbin:/usr/bin:/sbin:/bin',
  }

  if($resolvconf::params::use_netplan)
  {
    #
    netplan::interface { 'default DNS all interfaces':
      dev        => 'resolvers_all_interfaces',
      match      => true,
      match_name => '*',
      dns        => [ '1.1.1.1', '8.8.8.8' ],
      search     => $searchlist,
    }
  }
  else
  {
    # needed for eyp_resolvconf_maxns to get MAXNS
    package {  'glibc-headers':
      ensure => present,
      name   => $resolvconf::params::glibcheaders,
    }

    $fact_eyp_resolvconf_maxns = getvar('::eyp_resolvconf_maxns')

    if ( ($fact_eyp_resolvconf_maxns != undef) and ($resolverlistsize > $fact_eyp_resolvconf_maxns) )
    {
      notify { 'resolvconf limits':
        message => "more resolvers configured (${resolverlistsize}) that system's limit (${fact_eyp_resolvconf_maxns})"
      }
    }

    if ($disableimmutable)
    {
      e2fs_immutable { $resolvconf::params::resolvfile:
        ensure => 'absent',
        before => File[$resolvconf::params::resolvfile],
      }
    }

    file { $resolvconf::params::resolvfile:
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      mode    => '0644',
      content => template("${module_name}/resolvconf.erb"),
      notify  => $resolvconf::params::notifyresolv,
    }

    exec { 'update resolvconf':
      command     => 'resolvconf -u',
      refreshonly => true,
    }

    if($ignoreifconf and $resolvconf::params::resolvconfd)
    {
      file { '/etc/resolvconf/interface-order':
        ensure  => 'present',
        owner   => 'root',
        group   => 'root',
        mode    => '0644',
        content => "lo\n",
        notify  => Exec['update resolvconf interface-order'],
      }

      exec { 'update resolvconf interface-order':
        command     => 'resolvconf -u',
        refreshonly => true,
      }
    }
  }

}
