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

.PARAMETER ID
Parameter description

.EXAMPLE
An example

.NOTES
https://docs.github.com/en/rest/reference/actions#disable-a-workflow
#>
Function Disable-GitHubWorkflow {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string] $Owner = $script:Owner,

        [Parameter()]
        [string] $Repo = $script:Repo,

        [Parameter()]
        [string] $Token = $script:Token,

        [Parameter(
            Mandatory,
            ValueFromPipelineByPropertyName
        )]
        [string[]] $ID
    )

    begin {}

    process {
        $InputObject = @{
            Owner       = $Owner
            Repo        = $Repo
            Token       = $Token
            Method      = 'PUT'
            APIEndpoint = "repos/$Owner/$Repo/actions/workflows/$ID/disable"
        }

        $Response = Invoke-GitHubAPI @InputObject

    }
    end {
        return $Response
    }
}
