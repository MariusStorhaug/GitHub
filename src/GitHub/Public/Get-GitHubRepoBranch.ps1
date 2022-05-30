function Get-GitHubRepoBranch {
    [CmdletBinding()]
    param (
        $Owner = $script:Owner,
        $Repo = $script:Repo,
        $Token = $script:Token
    )

    $Response = Invoke-GitHubAPI -Method Get -APIEndpoint repos/$owner/$repo/branches

    return $Response
}
