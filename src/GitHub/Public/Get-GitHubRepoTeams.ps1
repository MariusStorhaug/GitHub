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

.EXAMPLE
An example

.NOTES
https://docs.github.com/en/rest/reference/repos#get-a-repository
#>
function Get-GitHubRepoTeams {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string] $Owner = $script:Owner,

        [Parameter()]
        [string] $Repo = $script:Repo,

        [Parameter()]
        [string] $Token = $script:Token
    )

    $InputObject = @{
        Owner       = $Owner
        Repo        = $Repo
        Token       = $Token
        Method      = 'Get'
        APIEndpoint = "repos/$Owner/$Repo/teams"
    }

    $Response = Invoke-GitHubAPI @InputObject

    return $Response
}
