max_ns = Facter::Util::Resolution.exec('grep "define MAXNS" /usr/include/resolv.h 2>/dev/null | sed \'s/.*MAXNS\\s\\+\\([0-9]\\+\\).*/\\1/\'')
unless cgroup.nil? or cgroup.empty?
  Facter.add('eyp_resolvconf_maxns') do
      setcode do

      end
  end
end
