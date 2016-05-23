class resolvconf::params {

  case $::osfamily
  {
    'redhat':
    {
      case $::operatingsystemrelease
      {
        /^[5-7].*$/:
        {
          $resolvfile='/etc/resolv.conf'
          $notifyresolv=undef
          $resolvconfd=false
          $glibcheaders='glibc-headers'
        }
        default: { fail("Unsupported RHEL/CentOS version! - ${::operatingsystemrelease}")  }
      }

    }
    'Debian':
    {
      case $::operatingsystem
      {
        'Ubuntu':
        {
          case $::operatingsystemrelease
          {
            /^14.*$/:
            {
              $resolvfile='/etc/resolvconf/resolv.conf.d/base'
              $notifyresolv=Exec['update resolvconf']
              $resolvconfd=true
              $glibcheaders='libc6-dev'
            }
            default: { fail("Unsupported Ubuntu version! - ${::operatingsystemrelease}")  }
          }
        }
        'Debian': { fail('Unsupported')  }
        default: { fail('Unsupported Debian flavour!')  }
      }
    }
    default: { fail('Unsupported OS!')  }
  }
}
