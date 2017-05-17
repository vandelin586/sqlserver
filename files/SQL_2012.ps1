<#
.SYNOPSIS
   Download a copy of MS SQL Server 2012 for Windows Server
 .DESCRIPTION
   Downloads remote installation files and post installation files on a Windows Server and
   removes the compressed installation file after extracting its contents.
 .PARAMETER <paramName>
   None.
 .EXAMPLE
   Run from Puppet windows_sqlserver_base.pp
 .AUTHOR
   Jay Weaver USFS 03/27/2017
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
$zip_dir = "C:\Binary"
mkdir $zip_dir
$wrk_dir = "C:\DBA\Software"
mkdir $wrk_dir

#-- I N S T A L L A T I O N  F I L E S
#--
$destinationPath = "C:\Binary\SQL2012wSP3_64bit.zip"

$file_source = "http://artifactory.azcender.com/artifactory/application-release-local/windows-server-local/com/puppet/sqlserver/SQL2012wSP3_64bit.zip"

Get-WebPage -url $file_source -file $destinationPath -force

#-- Uncompress installation files
#--
Add-Type -assembly "system.io.compression.filesystem"
[io.compression.zipfile]::ExtractToDirectory($destinationPath, $wrk_dir)

#-- P O S T  I N S T A L L A T I O N  F I L E S
#--
$wrk_dir = "C:\DBA\Post_Installation_Scripts"
mkdir $wrk_dir

$destinationPath = "C:\Binary\SQL2012_Post_Install.zip"

$file_source = "http://artifactory.azcender.com/artifactory/application-release-local/windows-server-local/com/puppet/sqlserver/SQL2012_Post_Install.zip"

Get-WebPage -url $file_source -file $destinationPath -force

#-- Uncompress POST installation files
#--
Add-Type -assembly "system.io.compression.filesystem"
[io.compression.zipfile]::ExtractToDirectory($destinationPath, $wrk_dir)

#-- REMOVE compressed fileS
Remove-Item C:\Binary -Force -Recurse
