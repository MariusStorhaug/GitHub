<#
.SYNOPSIS
Short description

.DESCRIPTION
Long description

.PARAMETER Token
Parameter description

.EXAMPLE
An example

.NOTES
https://docs.github.com/en/rest/reference/meta#github-api-root
#>
function Get-GitHubRoot {
    [CmdletBinding()]
    param (
        $Token = $script:Token
    )

    Invoke-GitHubAPI -Token $Token

    return $Response
}
