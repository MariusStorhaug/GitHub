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
function Get-GitHubContext {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string] $Token = $script:Token
    )

    $InputObject = @{
        Owner       = $Owner
        Repo        = $Repo
        Token       = $Token
        Method      = 'GET'
        APIEndpoint = 'user'
    }

    $Response = Invoke-GitHubAPI @InputObject

    return $Response
}
New-Alias -Name Get-GitHubUser -Value Get-GitHubContext -Force
