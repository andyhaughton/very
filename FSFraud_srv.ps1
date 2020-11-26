#This Script grants the FsFraud_srv account full mailbox acesss to users mailboxes in the VG-Intune-Role | FS | Fraud FS Group
#Author: Andy Haughton
#Date:24-Sep-2000

Connect-AzureAD 
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $Credential -Authentication Basic -AllowRedirection
Import-PSSession $Session -DisableNameChecking -allowclobber

#VG-Intune-Role | FS | Fraud FS Group
$members = Get-AzureADGroupMember -ObjectId 359f6177-0f3c-47a6-9d95-244a3325138a -Top 10000

foreach ($member in $members)

{
 
 Add-MailboxPermission -Identity $member.userprincipalname -user fsFraud_srv -AccessRights fullaccess
}


 