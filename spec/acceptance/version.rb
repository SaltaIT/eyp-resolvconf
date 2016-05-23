
_osfamily               = fact('osfamily')
_operatingsystem        = fact('operatingsystem')
_operatingsystemrelease = fact('operatingsystemrelease').to_f

case _osfamily
when 'RedHat'
  $resolvfile = '/etc/resolv.conf'

when 'Debian'
  $resolvfile = '/etc/resolvconf/resolv.conf.d/base'

else
  $resolvfile = '-_-'

end
