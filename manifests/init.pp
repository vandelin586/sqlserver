# --------
#
# @example
#    class { 'sql':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2017
# AutoStructure
#
class winsqlserver (
  String $sqluseracct,
  String $sqlsource,
  Array $sqlinstance,
  Array $sqlfeatures,
  String $sqlsvcpass,
  String $tcpopt,
  String $instdir,
  String $sqlshrfol,
  String $sqlshrwow,
  String $sqldatadir,
  String $sqldirlog,
  String $sqlbackdir,
#  String $securemode,
  String $sqlsvcacct,
  String $sqldirtmp,
){

  class {'::winsqlserver::config':
    usracct => $sqlsvcacct,
    userpw  => $sqlsvcpass,

}


->  class {'::winsqlserver::install':
    sqluseracct        => $sqluseracct,
    source             => $sqlsource,
    features           => $sqlfeatures,
    sqlinstance        => $sqlinstance,
  #  security_mode      => $securemode,
    sql_svc_account    => $sqluseracct,
    sql_svc_password   => $sqlsvcpass,
    tcpenabled         => $tcpopt,
    sqltempdblogdir    => $sqldirlog,
    sqluserdblogdir    => $sqldirlog,
    sqlbackupdir       => $sqlbackdir,
    sqltempdbdir       => $sqldirtmp,
    installsqldatadir  => $sqldatadir,
    instancedir        => $instdir,
    installshareddir   => $sqlshrfol,
    installsharewowdir => $sqlshrwow,
    updateenabled      => 0,

  }

  -> class {'::winsqlserver::service':}

}
