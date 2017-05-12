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
  string $sqlsource,
  array $instance,
  string $sqlsvcacct,
  string $sqlsvcpass,
  string $tcpopt,
  string $instdir,
  string $sqlshrfol,
  string $sqlshrwow,
  string $sqldatadir,
  string $sqldirlog,
  string $sqlbackdir,




)inherits ::winsqlserver::params {


class {'::winsqlserver::install':}



}
