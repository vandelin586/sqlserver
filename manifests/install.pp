# Ensure .NET and SQL are installed
class winsqlserver::install(
  String $sqlinstance,
  String $sqluseracct,
  String $source,
  Array $features,
  String $security_mode,
  String $sql_sysadmin_accounts,
  String $sql_svc_account,
  String $sql_svc_password,
  String $tcpenabled,
  String $sqltempdblogdir,
  String $sqluserdblogdir,
  String $sqlbackupdir,
  String $sqltempdbdir,
  String $installsqldatadir,
  String $installsqldatadir,
  String $instancedir,
  String $installshareddir,
  String $installsharewowdir,
  Integer $updateenabled,
)include ::sqlserver::params

  if (::sqlserver::params::install) {
    # Download SQL Server .zip files and un-compress on server.
    $download = 'puppet:///modules/winsqlserver/sql_2012.ps1.ps1'
    exec { 'sqlserver_dnld':
      command  => file($download),
      provider => powershell,
      timeout  => 7200,
    }







  #sqlserver_instance{ $instance:

      #    source                => $source,
      #    features              => $features,
      #    security_mode         => $sec_mode,
      #    sql_sysadmin_accounts => $sa_acct,
      #    sql_svc_account       => $svc_acct,
      #    sql_svc_password      => $svc_pwd,
      #       install_switches      => {
      #    'TCPENABLED'          => $enable_tcp,
      #    'SQLTEMPDBLOGDIR'     => $dir_log,
      #    'SQLUSERDBLOGDIR'     => $dir_log,
      #    'SQLBACKUPDIR'        => $dir_backup,
      #    'SQLTEMPDBDIR'        => $dir_tmp,
      #    'INSTALLSQLDATADIR'   => $dir_data,
      #    'INSTANCEDIR'         => $dir_inst,
      #    'INSTALLSHAREDDIR'    => $dir_share,
      #    'INSTALLSHAREDWOWDIR' => $dir_wow,
      #    'UpdateEnabled'       => 0,
      #      },
      #  }
      #  sqlserver_features { 'Generic Features':
      #    source   => $source,
      #    features => ['IS', 'MDS', 'SSMS'],
      #    install_switches   => {
      #    'UpdateEnabled'  => 0,
          #}
          #}


      windowsfeature { 'NET-Framework-Core':
      ensure => present,
      }
    }


        #    'TCPENABLED'          => $enable_tcp,
        #   'SQLTEMPDBLOGDIR'     => $dir_log,
        #    'SQLUSERDBLOGDIR'     => $dir_log,
        #    'SQLBACKUPDIR'        => $dir_backup,
        #    'SQLTEMPDBDIR'        => $dir_tmp,
        #    'INSTALLSQLDATADIR'   => $dir_data,
        #    'INSTANCEDIR'         => $dir_inst,
        #    'INSTALLSHAREDDIR'    => $dir_share,
        #    'INSTALLSHAREDWOWDIR' => $dir_wow,
        #    'UpdateEnabled'       => 0,









  #  notify {'default':
  #  message  => $sqluseracct,
  #}

  #notify {'inst':
  #  message  => $install,
  #}
