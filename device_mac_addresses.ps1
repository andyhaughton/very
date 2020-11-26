$outfile = 'c:\scripts\devices_mac.csv'
If (Test-Path $outfile){
    Remove-Item $outfile
}
$headers = "Device"+ "," + "User" + "," + "Wifi MAC Address" +"," +"Lan MAC Address"
Add-Content $outfile $headers
$devices = import-csv C:\scripts\devices.csv
ForEach($Device in $Devices)
{
   $user.UserPrincipalName = ""
   $device.wifimacaddress = ""
   $device.ethernetMacAddress = ""
   $user = Get-AzureADUser -ObjectId $device.userId 
   $line =  $device.devicename + "," + $user.UserPrincipalName + "," + $device.wifimacaddress + "," + $device.ethernetMacAddress
   Add-Content $outfile $line
}
