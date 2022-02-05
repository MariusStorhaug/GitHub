# GitHub.Core

$script:APIBaseURI = 'https://api.github.com'
$script:Owner = ''
$script:Repo = ''
$script:Token = ''

function Invoke-GitHubAPI {
    [CmdletBinding()]
    param (
        [Parameter()]
        [ValidateSet('GET', 'POST', 'PATCH', 'DELETE')]
        [String] $Method = 'GET',

        [Parameter()]
        [string] $APIEndpoint,

        [Parameter()]
        [hashtable] $Body = @{},

        [Parameter()]
        [string] $Owner = $script:Owner,

        [Parameter()]
        [string] $Repo = $script:Repo,

        [Parameter()]
        [string] $Token = $script:Token
    )
    $APICall = @{
        Uri     = ("$script:APIBaseURI/$APIEndpoint").Replace('\', '/').Replace('//', '/')
        Headers = @{
            Authorization  = "token $Token"
            'Content-Type' = 'application/vnd.github.v3+json' #'application/json'
        }
        Method  = $Method
        Body    = $Body | ConvertTo-Json -Depth 100
    }
    try {
        $Response = Invoke-RestMethod @APICall
    } catch {
        throw $_
    }
    return $Response
}


<#
.SYNOPSIS
Short description

.DESCRIPTION
Long description

.PARAMETER Owner
Parameter description

.PARAMETER Repo
Parameter description

.PARAMETER Token
Parameter description

.PARAMETER APIBaseURI
Parameter description

.EXAMPLE
An example

.NOTES
https://docs.github.com/en/rest/overview/other-authentication-methods#authenticating-for-saml-sso
#>
function Connect-GitHubAccount {
    [CmdletBinding()]
    param (
        [Parameter()]
        [String]
        $Owner,
        [Parameter()]
        [String]
        $Repo,
        [Parameter(Mandatory)]
        [String]
        $Token,
        [Parameter()]
        [String]
        $APIBaseURI = 'https://api.github.com'
    )

    $script:APIBaseURI = $APIBaseURI
    $script:Owner = $Owner
    $script:Repo = $Repo
    $script:Token = $Token

    Get-GitHubUser

}

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
