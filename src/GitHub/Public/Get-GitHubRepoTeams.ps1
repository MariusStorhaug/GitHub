function Get-GitHubRepoTeams {
    [CmdletBinding()]
    param (
        $Owner = $script:Owner,
        $Repo = $script:Repo,
        $Token = $script:Token
    )

    # API Reference
    # https://docs.github.com/en/rest/reference/repos#get-a-repository
    $APICall = @{
        Uri     = "$APIBaseURI/repos/$Owner/$Repo/teams"
        Headers = @{
            Authorization  = "token $Token"
            'Content-Type' = 'application/json'
        }
        Method  = 'GET'
        Body    = @{} | ConvertTo-Json -Depth 100
    }
    try {
        if ($PSBoundParameters.ContainsKey('Verbose')) {
            $APICall
        }
        $Response = Invoke-RestMethod @APICall
    } catch {
        throw $_
    }
    return $Response
}
