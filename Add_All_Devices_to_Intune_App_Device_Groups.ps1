Connect-AzureAD
Connect-MSGraph -AdminConsent
$Ids = @()
$groups = @("87b35f0f-2dfc-43a2-a967-02167db3770c","1c2b7fa7-7a65-4128-ac4a-50213d0d172e")
$assets = Get-IntuneManagedDevice | Get-MSGraphAllPages
$devices = $assets[1100..1356]
foreach($device in $devices)
{
    $IDs += $device.deviceName
}

$IDS | Out-File c:\scripts\devices.txt


       foreach($group in $groups){

        $aadTargetGroup = Get-AzureADGroup -ObjectId $group
        $aadTargetGroupMembers = Get-AzureADGroupMember -ObjectId $group -All $true

           $ids | % {

           $deviceId = (Get-AzureADDevice -All 1 -Filter $("DisplayName eq '"+$_+"'")).ObjectId

                        if (!($aadTargetGroupMembers -Match $deviceId)) {
                              Add-AzureADGroupMember -ObjectId $group -RefObjectId $deviceId -ErrorAction SilentlyContinue
                    write-host $([string]$counter +". $_")
                        } else {
                    write-host $("Already added - $_ `t`t $group")
                }

                 }

       } 

