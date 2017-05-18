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
    }

      windowsfeature { 'NET-Framework-Core':
        ensure => present,
      }
    }
