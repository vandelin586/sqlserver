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
#AutoStructure
#
class winsqlserver (
  String $sqluseracct,
  String $sqlsource,
  Array $sqlinstance,
  Array $sqlfeatures,
  String $sqlsvcacct,
  String $sqlsvcpass,
  String $tcpopt,
  String $instdir,
  String $sqlshrfol,
  String $sqlshrwow,
  String $sqldatadir,
  String $sqldirlog,
  String $sqlbackdir,
  String $securemode,
  String $svc_acct,
  String $svc_pwd,
#  String $sa_acct,



){


  class {'::winsqlserver::install':
    sqluseracct        => $sqluseracct,
    source             => $sqlsource,
    features           => $sqlfeatures,
    security_mode      => $securemode,
    sql_svc_account    => $svc_acct,
    sql_svc_password   => $svc_pwd,
    tcpenabled         => $tcpopt,
    sqltempdblogdir    => $sqldirlog,
    sqluserdblogdir    => $sqldirlog,
    sqlbackupdir       => $dir_back,
    sqltempdbdir       => $dir_tmp,
    installsqldatadir  => $sqldatadir,
    instancedir        => $instdir,
    installshareddir   => $sqlshrfol,
    installsharewowdir => $sqlshrwow,
    updateenabled      => 0,

  }

}
