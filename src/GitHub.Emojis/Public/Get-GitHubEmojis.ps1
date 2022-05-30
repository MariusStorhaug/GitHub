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
https://docs.github.com/en/rest/reference/emojis#get-emojis
#>
function Get-GitHubEmojis {
    [CmdletBinding()]
    param (
        $Destination
    )

    $Response = Invoke-GitHubAPI -Method Get -APIEndpoint emojis

    if (Test-Path -Path $Destination) {
        $Response.PSobject.Properties | ForEach-Object -Parallel {
            Invoke-WebRequest -Uri $_.Value -OutFile "$using:Destination/$($_.Name).png"
        }
    }

    return $Response
}
