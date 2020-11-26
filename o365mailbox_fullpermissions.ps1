#This Script grants full mailbox access to a shared mailbox for batch of users
#input file usesr.csv, required field: emailaddress
#Author: Andy Haughton
#Date:24-Sep-2000

Connect-AzureAD
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri https://outlook.office365.com/powershell-liveid/ -Credential $Credential -Authentication Basic -AllowRedirection
Import-PSSession $Session -DisableNameChecking -allowclobber

$users = import-csv C:\scripts\users.csv

foreach ($user in $users)

{

add-MailboxPermission -Identity 'servicedesk, fraud' -User $user.emailaddress -AccessRights full 
Add-RecipientPermission -Identity 'servicedesk, fraud'   -Trustee $user.emailaddress-AccessRights SendAs -Confirm:$false
}


 
