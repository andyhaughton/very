#This Script gets the status of deployed apps from a list of device names based on application IDS listed below
#The intune_functions script must be fun first!
#input file devices.txt
#export file appstatus.csv
#Author: Andy Haughton
#Date:29-Oct-2000


#Carbon Black 3.6.0.1791                 6f119024-c80c-470a-986c-7ef120b576db         
#Trend Micro Apex One 14.00.8523         e4886368-6fdb-4634-958a-f38bcccbb0d0
#Qualys Cloud Agent 4.00.411             a9edb587-e392-4be4-a58a-231f1554862d
$outfile = 'c:\scripts\appstatus.csv'
If (Test-Path $outfile){
    Remove-Item $outfile
}
$headers = "Software"+ "," + "Device" +"," +"Status"
Add-content $outfile $headers

$IDs = ('6f119024-c80c-470a-986c-7ef120b576db','e4886368-6fdb-4634-958a-f38bcccbb0d0','a9edb587-e392-4be4-a58a-231f1554862d')

$devices = get-content c:\scripts\devices.txt
ForEach($ID in $IDS)
{
    $app = Get-IntuneApplication | ? {$_.id -eq $ID}
    ForEach($Device in $Devices)
    {
        $State = ((Get-IntuneDeviceApp -ApplicationId $id).value | where {$_.devicename -eq $device}).installstate
        $line =  $app.displayname + "," + $device + "," + $state
        Add-Content $outfile $line
    }

}