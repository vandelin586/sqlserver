# Ensure .NET and SQL are installed
class winsqlserver::install(
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

  sqlserver_instance{ $instance:

  }
    windowsfeature { 'NET-Framework-Core':
    ensure => present,
    }


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







  #  notify {'default':
  #  message  => $sqluseracct,
  #}

  #notify {'inst':
  #  message  => $install,
  #}

# Ensure .NET3.5 is installled

  }












#sqlserver_instance{ 'MSSQLSERVER':
#  ensure                => 'present',
#  features              => ['SQL'],
#  source                => 'c:/temp',
#  sql_sysadmin_accounts => ['administrator'],









#class sqlserver:install {
# Ensure .NET3.5 is installled
#  windowsfeature { 'NET-Framework-Core':
#    ensure => present,
#  } ->

# Install SQL Server
#  sqlserver_instance{ $instance :
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


#}













#sqlserver_instance{ 'MSSQLSERVER':
    #features                => ['SQL'],
    #source                  => 'E:/',
    #sql_sysadmin_accounts   => ['myuser'],
