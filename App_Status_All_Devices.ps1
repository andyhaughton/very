#This Script gets the status of deployed apps from a list of device names based on application IDS listed below
#The intune_functions script must be fun first!
#input file devices.txt
#export file appstatus.csv
#Author: Andy Haughton
#Date:29-Oct-2000

#Carbon Black 3.6.0.1791                 6f119024-c80c-470a-986c-7ef120b576db         
#Trend Micro Apex One 14.00.8523         e4886368-6fdb-4634-958a-f38bcccbb0d0
#Qualys Cloud Agent 4.00.411             a9edb587-e392-4be4-a58a-231f1554862d
Connect-AzureAD
Connect-MSGraph -AdminConsent
$outfile = 'c:\scripts\appstatus.csv'
If (Test-Path $outfile){
    Remove-Item $outfile
}
$headers = "Software"+ "," + "Device" +"," +"Status"
Add-content $outfile $headers

$groups = ('6f119024-c80c-470a-986c-7ef120b576db','e4886368-6fdb-4634-958a-f38bcccbb0d0','a9edb587-e392-4be4-a58a-231f1554862d')

$devices = Get-IntuneManagedDevice | Get-MSGraphAllPages

foreach($device in $devices)
{
    $IDs += $device.deviceName
}

ForEach($group in $groups)
{
    $app = Get-IntuneApplication | ? {$_.id -eq $group}
    ForEach($Device in $Devices)
    {
        $State = ((Get-IntuneDeviceApp -ApplicationId $group).value | where {$_.devicename -eq $device.deviceName}).installstate
        $line =  $app.displayname + "," + $device.deviceName + "," + $state
        Add-Content $outfile $line
    }

}