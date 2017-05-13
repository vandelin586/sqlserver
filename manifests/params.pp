# Parameter file for profile windows_sqlserver_base
# ===========================
#
# This class provides all the parameters need for a SQL Server BASE install for
# the manifest windows_sqlserver_base.pp.
#
# Parameters
# ----------
# $host_name   - Server name hosting the SQL Server Instance.
# $instance    - Name of the SQL Server Instance
# $source      - Location of the SQL Server installation media.
# $features    - Specifies the components to install.  Comma seperated values.
# Supported values: [SQLEngine, Replication, FullText, DQ, AS, AS_SPI, RS, RS_SHP, RS_SHPWFE,
#                   DQC, Conn, IS, BC, SDK, DREPLAY_CTLR, DREPLAY_CLT, SNAC_SDK,
#                   SQLODBC, SQLODBC_SDK, LocalDB, MDS, POLYBASE]
# $sec_mode    - Default is WINDOWS (blank)
# $sa_pwd
# $sa_acct
# $enable_tcp  - Enable tcp for this instance
# $dir_inst    - Specifies a nondefault installation directory for instance-specific components.
# $dir_share   - Specifies a nondefault installation directory for 64-bit shared components.
# $dir_wow     - Specifies a nondefault installation directory for 32-bit shared components.
#                Supported only on a 64-bit system.
# $sql_ver     - Version of SQL server. SQL_2012, SQL_2014, etc.
# $build_ver   - Major build version of SQL Server. 2012 = MSSQL11, 2014 = MSSQL12, etc.
# $environment - 'DEV', 'TST', 'PRD'.
# $app_adm_acct - Account based on the specific application. Supplied by NITC. EDC\<acct>
#
# Variables
# ----------
#  N/A
#
# Examples
# --------
#
# @example
#   In the PE console under classes add, role:windows_sqlserver_base
#
# Authors
# -------
#
# Jay Weaver jayweaver@fs.fed.us
#
# Copyright
# ---------
#
# Copyright 2017 Jay Weaver, US Forest Service.
#
class winsqlserver::params {
  $sql_ver          = 'SQL_2012'
  $instance         = 'TEST'

  # Do ANY instances exist?
  if $::facts['sqlserver_instances'] != undef {
    # See if THIS instance exists on the server
    $fact_check = $::facts['sqlserver_instances']["${sql_ver}"]["${instance}"]
    if $fact_check != undef {
      # An instance already exists
      $install = false
    }
    else {
      # Instace exists, but not with that name
      $install = true
    } # END check THIS instance exists
  }
  else {
    # Brand new install
    $install = true
  } # END ANY instances check
}
