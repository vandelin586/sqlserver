
#config the server
class winsqlserver::config(
  String $usracct
){

    user { '':
    ensure   => present,
    password => '',
    groups   => [ 'Administrators' ],
    }

}
