<#
.SYNOPSIS
Get the authenticated user

.DESCRIPTION
If the authenticated user is authenticated through basic authentication or OAuth with the user scope, then the response lists public and private profile information.
If the authenticated user is authenticated through OAuth without the user scope, then the response lists only public profile information.

.PARAMETER Token
Parameter description

.EXAMPLE
An example

.NOTES
https://docs.github.com/en/rest/reference/users#get-the-authenticated-user
#>
function Get-GitHubUser {
    [CmdletBinding()]
    param (
        $Token = $script:Token
    )

    $Response = Invoke-GitHubAPI -APIEndpoint 'user' -Token $Token

    return $Response
}
New-Alias -Name Get-GitHubContext -Value Get-GitHubUser -Force
