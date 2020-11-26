#This script lists all applications assigned to a user via group membership
#The intune_functions script must be fun first
$requiredapps=  @()
$availableapps = @()
$assignedapps= @()

Connect-AzureAD
$user = 'andy.haughton@theverygroup.com'
$groups = get-IntuneUserGroups -user $user | where {$_.displayname -match 'VG-Intune'}
$Apps = Get-IntuneApplication 

ForEach($app in $apps)
{
    $assign = Get-ApplicationAssignment -ApplicationId $app.id 
    $assignments = $assign.assignments
    ForEach($assignment in $assignments)
    {
        $assignid = $assignment.id.Substring(0,$assignment.id.length-4)
        ForEach($Group in $Groups)
        {    
            If ($Group.id -match $assignid)
            {
                If($assignment.intent -eq 'required')
                {
                    $requiredapps+=$app.displayName
                }

                If($assignment.intent -eq 'available')
                {
                    $availableapps+=$app.displayName
                }

                 
            }

        }

    }
}


Write-host "Apps Installed for $($user)" -ForegroundColor yellow
ForEach($app in $requiredapps)
{
    write-host $App
}
Write-host
Write-host "Apps available in Company Portal for $($user)" -ForegroundColor yellow
ForEach($app in $availableapps)
{
    write-host $App
}
