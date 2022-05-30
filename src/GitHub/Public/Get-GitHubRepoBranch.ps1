function Get-GitHubRepoBranch {
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
        APIEndpoint = "repos/$Owner/$Repo/branches"
    }

    $Response = Invoke-GitHubAPI @InputObject

    return $Response
}
