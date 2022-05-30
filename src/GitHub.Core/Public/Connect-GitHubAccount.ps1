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
        [String] $Owner,
        [Parameter()]
        [String] $Repo,
        [Parameter(Mandatory)]
        [String] $Token,
        [Parameter()]
        [String] $APIBaseURI = 'https://api.github.com'
    )

    $script:APIBaseURI = $APIBaseURI
    $script:Owner = $Owner
    $script:Repo = $Repo
    $script:Token = $Token

    Get-GitHubContext

}
