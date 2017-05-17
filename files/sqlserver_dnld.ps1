<#
 .SYNOPSIS
   Download a copy of MS SQL Server Windows Server
 .DESCRIPTION
   Downloads remote installation files (silent) on a Windows Server and
   removes the compressed installation file after extracting its contents.
 .PARAMETER <paramName>
   None.
 .EXAMPLE
   Run from Puppet windows_sqlserver.pp
 .AUTHOR
   Jay Weaver
#>

#-- Determine system hostname and primary DNS suffix to determine certname
#---
$objIPProperties = [System.Net.NetworkInformation.IPGlobalProperties]::GetIPGlobalProperties()
$name_components = @($objIPProperties.HostName, $objIPProperties.DomainName) | ? {$_}
$certname = $name_components -Join "."

Function Get-WebPage { Param( $url, $file, [switch]$force)
  if($force) {
    [Net.ServicePointManager]::ServerCertificateValidationCallback = {$true}
  }
  $webclient = New-Object system.net.webclient
  $webclient.DownloadFile($url,$file)
}

$wrk_dir = "C:\DBA\Software"
mkdir $wrk_dir

$destinationPath = "C:\DBA\Software\sqlserver.zip"
$file_source = "http://artifactory.azcender.com/artifactory/application-release-local/windows-server-local/com/puppet/sqlserver/sqlserver.zip"

Get-WebPage -url $file_source -file $destinationPath -force

#-- Uncompress file
#--
Add-Type -assembly "system.io.compression.filesystem"
[io.compression.zipfile]::ExtractToDirectory($destinationPath, $wrk_dir)

#-- REMOVE compressed file
Remove-Item C:\DBA\Software\sqlserver.zip -Force #-Recurse
