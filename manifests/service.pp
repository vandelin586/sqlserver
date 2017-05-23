#service
#class winsqlserver::service {

#service { 'MSSQL$TEST':
#  ensure => running,
#  enable => true,
#  hasrestart => true,
#  hasstatus  => true,
  # pattern => 'name',
#}
#service { 'SQLBrowser':
#  ensure => running,
#  enable => true,
#  hasrestart => true,
#  hasstatus  => true,
  # pattern => 'name',
#}
#service { 'SQLWriter':
#  ensure => running,
#  enable => true,
#  hasrestart => true,
#  hasstatus  => true,
  # pattern => 'name',
#}
#  Running  MSSQL$TEST         SQL Server (TEST)
#  Stopped  SQLAgent$TEST      SQL Server Agent (TEST)
#  Running  SQLBrowser         SQL Server Browser
#  Running  SQLWriter          SQL Server VSS Writer
#}
