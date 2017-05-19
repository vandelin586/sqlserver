# Ensure sql install , ensure instace(s) are setup
class winsqlserver::install(
  Array $sqlinstance,
  String $sqluseracct,
  String $source,
  Array $features,
  String $security_mode,
  String $sql_svc_account,
  String $sql_svc_password,
  String $tcpenabled,
  String $sqltempdblogdir,
  String $sqluserdblogdir,
  String $sqlbackupdir,
  String $sqltempdbdir,
  String $installsqldatadir,
  String $instancedir,
  String $installshareddir,
  String $installsharewowdir,
  Integer $updateenabled,
){

  include ::winsqlserver


    # Download SQL Server .zip files and un-compress on server.
    exec { 'sqlserver_dnld':
      command  => file('winsqlserver/SQL_2012.ps1'),
      provider => powershell,
      timeout  => 7200,
      creates  => "C:\\DBA\\Software\\setup.exe",
      before   => sqlserver_instance[$instance],
    }

    # Install SQL Server
    sqlserver_instance{ $instance :
      source                => $source,
      features              => $features,
      security_mode         => $security_mode,
      sql_sysadmin_accounts => $sa_acct,
      sql_svc_account       => $svc_acct,
      sql_svc_password      => $svc_pwd,
      install_switches      => {
        'TCPENABLED'          => $enable_tcp,
        'SQLTEMPDBLOGDIR'     => $dir_log,
        'SQLUSERDBLOGDIR'     => $dir_log,
        'SQLBACKUPDIR'        => $dir_backup,
        'SQLTEMPDBDIR'        => $dir_tmp,
        'INSTALLSQLDATADIR'   => $dir_data,
        'INSTANCEDIR'         => $dir_inst,
        'INSTALLSHAREDDIR'    => $dir_share,
        'INSTALLSHAREDWOWDIR' => $dir_wow,
        'UpdateEnabled'       => 0,
      },
    }

      windowsfeature { 'NET-Framework-Core':
        ensure => present,
      }
    }
