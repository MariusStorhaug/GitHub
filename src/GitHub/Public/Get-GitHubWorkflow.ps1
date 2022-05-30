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

.PARAMETER Name
Parameter description

.PARAMETER ID
Parameter description

.PARAMETER PageSize
Parameter description

.EXAMPLE
An example

.NOTES
https://docs.github.com/en/rest/reference/actions#list-repository-workflows
#>
Function Get-GitHubWorkflow {
    [CmdletBinding(
        DefaultParameterSetName = 'ByName'
    )]
    param (
        $Owner = $script:Owner,
        $Repo = $script:Repo,
        $Token = $script:Token ,
        [Parameter(
            ParameterSetName = 'ByName'
        )]
        [string] $Name,
        [Parameter(
            ParameterSetName = 'ByID'
        )]
        [string] $ID,
        [int] $PageSize = 30
    )

    $processedPages = 0
    $workflows = @()
    do {
        $processedPages += 1
        $Response = Invoke-GitHubAPI -Method GET -APIEndpoint "repos/$Owner/$Repo/actions/workflows?per_page=$PageSize&page=$processedPages"
        $workflows += $Response.workflows | Where-Object name -Match $name | Where-Object id -Match $id
    } while ($workflows.count -ne $Response.total_count)

    return $workflows
}
