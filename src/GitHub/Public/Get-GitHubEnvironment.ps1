function Get-GitHubEnvironment {
    [CmdletBinding()]
    param (
        $Owner = $script:Owner,
        $Repo = $script:Repo,
        $Token = $script:Token
    )
    begin {}
    process {
        # API Reference
        # https://docs.github.com/en/rest/reference/repos#get-all-environments
        $APICall = @{
            Uri     = "$APIBaseURI/repos/$Owner/$Repo/environments"
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
        return $Response.Environments
    }
    end {}
}
