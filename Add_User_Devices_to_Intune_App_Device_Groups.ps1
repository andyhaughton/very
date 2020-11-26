#This Script gets a list of devices based on a CSV import of users, then adds the devices to Intune Application Device Groups
#input file usesr.csv, required field: emailaddress
#export file devices.txt
#Author: Andy Haughton
#Date:29-Oct-2000

Connect-AzureAD
Connect-MSGraph -AdminConsent

$devices = @()
$users = Import-csv C:\scripts\users.csv
ForEach($user in $users)
{
    $device = Get-IntuneManagedDevice | Get-MSGraphAllPages | Where-Object {$_.userprincipalname -eq $user.emailaddress}
    $devices += $device.deviceName

}

$devices | Out-File c:\script\devices.txt


<#
       Apex,Carbon,Qualys
       VG-Intune-Apps | Carbon Black 3.6.0.1791              87b35f0f-2dfc-43a2-a967-02167db3770c
       VG-Intune-Apps | Trend Micro Apex One 14              75e5ee8e-86a4-4739-bb65-3e224d56d71c
       VG-Intune-Apps | Qualys Cloud Agent 4.00.411          1c2b7fa7-7a65-4128-ac4a-50213d0d172e

#>

$groups = @("87b35f0f-2dfc-43a2-a967-02167db3770c","75e5ee8e-86a4-4739-bb65-3e224d56d71c","1c2b7fa7-7a65-4128-ac4a-50213d0d172e")
    $devices = get-content c:\scripts\devices.txt

       foreach($group in $groups){

        $aadTargetGroup = Get-AzureADGroup -ObjectId $group
        $aadTargetGroupMembers = Get-AzureADGroupMember -ObjectId $group -All $true

           $devices | % {

           $deviceId = (Get-AzureADDevice -All 1 -Filter $("DisplayName eq '"+$_+"'")).ObjectId

                        if (!($aadTargetGroupMembers -Match $deviceId)) {
                              Add-AzureADGroupMember -ObjectId $group -RefObjectId $deviceId -ErrorAction SilentlyContinue
                    write-host $([string]$counter +". $_")
                        } else {
                    write-host $("Already added - $_ `t`t $group")
                }

                 }

       } 

