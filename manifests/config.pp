
#config the server
class winsqlserver::config(
){

    group { 'Administrators':
    ensure  => present,
    members => [ 'sql' ],
    }


# Profile for SQL Post installation

#  exec { 'sql_post_install':
#    command   => "powershell.exe -File $::{postinstall} $::{host_name} $::{instance}",
#    provider  => powershell,
#    logoutput => true,
#  }

# Remove the setup directory & files

#  file {'remove_directory':
#    ensure  => absent,
#    path    => 'C:/DBA',
#    recurse => true,
#    purge   => true,
#    force   => true,
#  }
}
