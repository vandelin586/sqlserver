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
#  String $install,

){


  class {'::winsqlserver::install':
    sqluseracct           => $sqluseracct,
    source                => $sqlsource,
    features              => $sqlfeatures,
    #install                => $install,
    #security_mode         =>,
    #sql_sysadmin_accounts =>,
    #sql_svc_account       =>,
    #sql_svc_password      =>,
    #TCPENABLED            => $tcpopt,
  }

}
