#This Script removes all licenses assigned to indivual users and add the user to
#VG-Intune-Licence | Microsoft 365 E3 and VG-MFA-Enable Groups
#input file user.csv, required field: email address
#Author: Andy Haughton
#Date:24-Sep-2000

Connect-AzureAD
Connect-MsolService
$users = import-csv 'C:\scripts\users4.csv'

ForEach($User in $users)
{
    (get-MsolUser -UserPrincipalName $user.emailaddress).licenses.AccountSkuId |
    foreach{
    #Remove all licenses 
    Set-MsolUserLicense -UserPrincipalName $user.'emailaddress' -RemoveLicenses shopdirect:STANDARDPACK,shopdirect:EMS
           }
    $msoluser = get-msoluser -UserPrincipalName $user.'emailaddress'
    #VG-Intune-Licence | Microsoft 365 E3 
    Add-AzureADGroupMember -ObjectId 4132261e-0a8b-4b85-b91c-65c5a747adf2 -RefObjectId $msoluser.objectid
    #VG-MFA-Enable
    Add-AzureADGroupMember -ObjectId  c380d920-2ce1-45a7-aa36-88d58dcd6927 -RefObjectId $msoluser.objectid

}

