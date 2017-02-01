msmq { 'testmsmq1':
  ensure  => present,
  private => true,
}

msmq { 'testmsmq2':
  ensure  => present,
  private => true,
  journal => true,
}

msmq { 'testmsmq3':
  ensure        => present,
  private       => true,
  journal       => true,
  transactional => true,
}

msmq { 'testmsmq4':
  ensure        => present,
  private       => true,
  journal       => true,
  transactional => true,
}

msmq { 'testmsmq5':
  ensure      => present,
  private     => true,
  permissions => [
  {
    user       => 'testdomain\testuser1', 
    permission => 'FullControl'
  },
  {
    user       => 'testdomain\testuser2', 
    permission => 'FullControl'
  },
  ],
}
