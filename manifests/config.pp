
#config the server
class winsqlserver::config(
){

    user { 'sql':
    ensure   => present,
    password => 'ServerService123!@#',
    groups   => [ 'Administrators' ],
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
