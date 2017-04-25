
sqlserver_instance{ 'MSSQLSERVER':
    features                => ['SQL'],
    source                  => 'c:/temp',
    sql_sysadmin_accounts   => ['myuser'],
}






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
    }
  }

#}













#sqlserver_instance{ 'MSSQLSERVER':
    #features                => ['SQL'],
    #source                  => 'E:/',
    #sql_sysadmin_accounts   => ['myuser'],
