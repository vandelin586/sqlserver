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
# Copyright 2017 AutoStructure
#
class winsqlserver (
  String $sqluseracct,
  String $sqlsource,
  Array $sqlinstance,
  String $sqlsvcacct,
  String $sqlsvcpass,
  String $tcpopt,
  String $instdir,
  String $sqlshrfol,
  String $sqlshrwow,
  String $sqldatadir,
  String $sqldirlog,
  String $sqlbackdir,




)inherits ::winsqlserver::params {


class {'::winsqlserver::install':

sqluseracct  => $sqluseracct,}



}
