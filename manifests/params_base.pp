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
class profile::sqlserver::params_base {
  $host_name        = 'pe-201642-win2012r2-nocm'
  $instance         = 'TEST'
  $source           = 'C:/DBA/Software'
  $features         = ['FullText', 'SQLEngine']
  $sec_mode         = undef
  $enable_tcp       = '1'
  $svc_acct         = 'SQLServiceAccount'
  $svc_pwd          = 'p@ssw0rd1234'
  $sql_ver          = 'SQL_2012'
  $dir_inst         = 'C:\\Program Files\\Microsoft SQL Server'
  $dir_share        = 'C:\\Program Files\\Microsoft SQL Server'
  $dir_wow          = 'C:\\Program Files (x86)\\Microsoft SQL Server'
#  $dir_data         = 'E:\\Program Files\\Microsoft SQL Server'
#  $dir_log          = "G:\\Program Files\\Microsoft SQL Server\\MSSQL11.${instance}\\MSSQL\\DATA"
#  $dir_backup       = "F:\\Program Files\\Microsoft SQL Server\\MSSQL11.${instance}\\MSSQL\\Backup"
#  $dir_tmp          = "G:\\Program Files\\Microsoft SQL Server\\MSSQL11.${instance}\\MSSQL\\TempDB"
  $dir_data         = 'H:\\Program Files\\Microsoft SQL Server'
  $dir_log          = "I:\\Program Files\\Microsoft SQL Server\\MSSQL11.${instance}\\MSSQL\\DATA"
  $dir_backup       = "I:\\Program Files\\Microsoft SQL Server\\MSSQL11.${instance}\\MSSQL\\Backup"
  $dir_tmp          = "J:\\Program Files\\Microsoft SQL Server\\MSSQL11.${instance}\\MSSQL\\TempDB"
  $postinstall      = 'C:/DBA/Post_Installation_Scripts/SQL_2012_PostInstall.ps1'
  $environment      = undef   # This is ONLY for testing.
  $app_adm_acct     = 'Application Admin Group'

  # Set the default sa accout with the appropriate AD group
  case $environment {
    'DEV':   { $sa_acct = ['EDC\P_CIOX_DEV_DBAdmin_FS_Role'] }
    'TST':   { $sa_acct = ['EDC\P_CIOX_TST_DBAdmin_FS_Role'] }
    'PRD':   { $sa_acct = ['EDC\P_CIOX_PRD_DBAdmin_FS_Role'] }
    default: { $sa_acct = ['PE-201642-WIN20\vagrant'] } # DEV testing default
  }

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
