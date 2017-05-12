<#
 .SYNOPSIS
   Install a copy of the Oracle Client 64-Bit on a Windows Server
 .DESCRIPTION
   Creates an Oracle Client (64-bit) install answer file, Executes a remote installation 
   (silent) on a Windows Server, creates 2 files for network connection, and finally 
   removes working directories and files.
 .PARAMETER <paramName>
   None.
 .EXAMPLE
   Run from Puppet windows_oracle_cli64 manifest init.pp.
 .AUTHOR
   Jay Weaver
#>

# Determine system hostname and primary DNS suffix to determine certname
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
#-- Copy 64-bit setup file and extract its content
#--
$wrk_dir = "E:\Binary\"
mkdir $wrk_dir

$destinationPath = "E:\Binary\11g_client_for_2012.zip"
$file_source = "http://fsxopsx0057.fdc.fs.usda.gov:8081/artifactory/windows-server-local/com/puppet/oracle_client/11g_client_for_2012.zip"

Get-WebPage -url $file_source -file $destinationPath -force

#-- Uncompress file
#--
Add-Type -assembly "system.io.compression.filesystem"
[io.compression.zipfile]::ExtractToDirectory($destinationPath, $wrk_dir)

#-- Copy response file for 64-bit Oracle Client install USFS.rsp
#--
$wrk_dir = "E:\64bit\response"
mkdir $wrk_dir
$destinationPath = "E:\64bit\response\USFS.rsp"
$file_source = "http://artifactory.fdc.fs.usda.gov/artifactory/windows-server-local/com/puppet/oracle_client/response/64bit/USFS.rsp"

Get-WebPage -url $file_source -file $destinationPath -force

#------------------------------------------------------------------------
#        INSTALL the Oracle 11g 64-bit Client on Windows silently
#------------------------------------------------------------------------
(Start-Process -FilePath "E:\Binary\11g_client_for_2012\setup.exe" -Wait -ArgumentList "-silent -nowait -responseFile E:\64bit\response\USFS.rsp" -Passthru).ExitCode

#------------------------------------------------------------------------
#                        POST installation
#------------------------------------------------------------------------

#-- REMOVE setup directory
Remove-Item E:\Binary -Force -Recurse

#-- REMOVE response files directory
Remove-Item E:\64bit -Force -Recurse

$destinationPath = "C:\product\11.2.0\client_1\NETWORK\ADMIN\"

#-- EDIT or CREATE sqlnet.ora
#--
$fileName = "sqlnet.ora"
if (!(Test-Path "$destinationPath$fileName"))
{
  $wrkString = @"
# This file is actually generated by netca. But if customers choose to
# install "Software Only", this file wont exist and without the native
# authentication, they will not be able to connect to the database on NT.
SQLNET.AUTHENTICATION_SERVICES = (NTS)
names.directory_path=(tnsnames,ldap)
"@
   New-Item -path $destinationPath -name $fileName -type "file" -value $wrkString
   Write-Host "Created new file and text content added"
}
else
{
  Add-Content -path "$destinationPath$fileName" -value "`r","names.directory_path=(tnsnames,ldap)"
  Write-Host "File already exists and new text content added"
}
#--
#-- EDIT or CREATE LDAP.ora
#--
$fileName = "LDAP.ora"
$wrkString = @"
DIRECTORY_SERVERS = (oid.fs.usda.gov:389:636) `n
DEFAULT_ADMIN_CONTEXT = "dc=fs,dc=fed,dc=us" `n
"@
if (!(Test-Path "$destinationPath$fileName"))
{

  New-Item -path $destinationPath -name $fileName -type "file" -value $wrkString
  Write-Host "Created new file and text content added"
}
else
{
  Add-Content -path "$destinationPath$fileName" -value $wrkString
  Write-Host "File already exists and new text content added"
}

