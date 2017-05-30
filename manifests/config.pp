
#config the server
class winsqlserver::config(
  String $usracct,
  String $userpw,
){

  user { $usracct:
    ensure   => present,
    password => $userpw,
    groups   => [ 'Administrators' ],
  }

}
