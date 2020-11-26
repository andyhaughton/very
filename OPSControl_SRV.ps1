#This Script grants the OPSControl_SRV account full mailbox acesss to users mailboxes in the VG-Intune-Role | FS Users Group
#Author: Andy Haughton
#Date:24-Sep-2000

Connect-AzureAD 
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $Credential -Authentication Basic -AllowRedirection
Import-PSSession $Session -DisableNameChecking -allowclobber

#VG-Intune-Role | FS Users Group
$members = Get-AzureADGroupMember -ObjectId 13d899f1-ee72-40e4-99e0-44fc5162ab75 -Top 10000

foreach ($member in $members)

{
 
 Add-MailboxPermission -Identity $member.userprincipalname -user OPSControl_SRV  -AccessRights fullaccess
 
}


 