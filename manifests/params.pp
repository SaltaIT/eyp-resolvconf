class resolvconf::params {

  case $::osfamily
  {
    'redhat':
    {
      case $::operatingsystemrelease
      {
        /^[5-8].*$/:
        {
          $resolvfile='/etc/resolv.conf'
          $notifyresolv=undef
          $resolvconfd=false
          $glibcheaders='glibc-headers'
          $use_netplan=false
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
          $resolvfile='/etc/resolvconf/resolv.conf.d/base'
          $notifyresolv=Exec['update resolvconf']
          $resolvconfd=true
          $glibcheaders='libc6-dev'
          case $::operatingsystemrelease
          {
            /^1[46].*$/:
            {
              $use_netplan=false
            }
            /^18.*$/:
            {
              $use_netplan=true
            }
            default: { fail("Unsupported Ubuntu version! - ${::operatingsystemrelease}")  }
          }
        }
        'Debian': { fail('Unsupported')  }
        default: { fail('Unsupported Debian flavour!')  }
      }
    }
    'Suse':
    {
      case $::operatingsystem
      {
        'SLES':
        {
          case $::operatingsystemrelease
          {
            /^1[12].3$/:
            {
              $resolvfile='/etc/resolv.conf'
              $notifyresolv=undef
              $resolvconfd=false
              $glibcheaders='glibc-devel'
            }
            default: { fail("Unsupported operating system ${::operatingsystem} ${::operatingsystemrelease}") }
          }
        }
        default: { fail("Unsupported operating system ${::operatingsystem}") }
      }
    }
    default: { fail('Unsupported OS!')  }
  }
}
