##########################################################################
#
# Name: Post_Config_Verify.ps1
# Author: Stuart Baker
# Version: 2.1
# Date: 05/09/2016
# Comment: Script to gather VDC Server information for post install.
#
##########################################################################
write-host ""
write-host "Script is now collecting the information needed to complete the post install."
write-host ""
#Gather system basic information
write-host "Gathering information about the Operating System, Network, Processor, Memory, Disks, ACLs, and Administrators Group"
$operatingsystem = (get-wmiobject win32_operatingsystem | select @{Name="Server Name";Expression={$_.__SERVER}}, @{Name="OS Version";Expression={$_.Caption}}, @{Name="OS Architecture";Expression={$_.OSArchitecture}} | format-list| out-string).Trim()
#Gather Network information
$network = (get-wmiobject win32_networkadapterconfiguration | where {$_.IPEnabled -eq "True"} | select IPAddress, @{Name="Default IP Gateway";Expression={$_.DefaultIPGateway}}, @{Name="IP Subnet";Expression={$_.IPSubnet}}, @{Name="DNS Search Order";Expression={$_.DNSServerSearchOrder}}, @{Name="DNS Suffix";Expression={$_.DNSDomainSuffixSearchOrder}} | format-list| out-string).Trim()
#Processor Information
#Gathers information on Computer name, Processor Name, and Number of Cores
$Processor = (get-wmiobject win32_processor | select @{Name="Processor Type";Expression={$_.name}}, @{Name="Number of Cores";Expression={$_.numberofcores}} | Format-List| out-string).Trim()
#Memory Information
#Gathers information about Computer name, Domain, and Total Physical Memory converted to GB
$Memory = (Get-WMIObject -class Win32_ComputerSystem | select @{n='TotalPhysicalMemory' ;e={[int]($_.TotalPhysicalMemory/1gb)}} | format-list| out-string).Trim()
#Disk Drive Information
#Gathers information about Computer name, Device ID, Volume Name, Free space, and Size
$Local_Disk = (get-wmiobject  Win32_LogicalDisk | where {$_.DriveType -eq 3} | select @{Name="Device ID";Expression={$_.DeviceID}}, @{Name="Volume Name";Expression={$_.VolumeName}}, @{Name='FreeSpace in GB';Expression={[int]($_.FreeSpace/1GB)}}, @{Name='Size in GB';Expression={[int]($_.Size/1GB)}} | format-list| out-string).Trim()
#Permissions
#Lists the Access Controls on all the drives that are present
$drives = get-wmiobject win32_logicaldisk | where {$_.DriveType -eq 3} | select DeviceId | foreach {$_.DeviceId}
$ACL = foreach ($drive in $drives) {(get-acl $drive | select @{Name="Device ID";Expression={$_.pschildname}}, @{Name="Access Controls";Expression={$_.accesstostring}} | format-list | out-string).Trim()}
#Get Group Information
#Displays all groups associated with the Administrators group 
$Administrators = net localgroup administrators
write-host ""
#Output
$output = "c:\tmp\Post_Config.txt"
$date = get-date
write-host "Creating the output file Post_Config.txt"
write-host ""
"Post install configuration information:  $date" | out-file -append -noclobber $output
$operatingsystem | out-file -append -noclobber $output
$network | out-file -append -noclobber $output
$network2 | out-file -append -noclobber $output
$Processor | out-file -append -noclobber $output
$Memory | out-file -append -noclobber $output
$Local_Disk | out-file -append -noclobber $output
$ACL | out-file -append -noclobber $output
$Administrators | out-file -append -noclobber $output
#(get-content $output) | ? {$_.trim() -ne ""} | set-content $output
write-host "Post configuration file will be generated and stored at $output"
write-host ""

