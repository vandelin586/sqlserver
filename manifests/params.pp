#Does existing instance exist
class winsqlserver::params {
  #$sql_ver          = 'SQL_2012'
  #$instance         = 'TEST'

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
