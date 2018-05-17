class { 'resolvconf':
  resolvers  => [ '1.1.1.1', '8.8.8.8' ],
  searchlist => [ 'demo.vm', 'demo2.vm' ],
}
