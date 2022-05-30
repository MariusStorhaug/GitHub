function Get-GitHubEnvironmentSecrets {
    [CmdletBinding()]
    param (
        $Owner = $script:Owner,
        $Repo = $script:Repo,
        $Token = $script:Token ,
        [Alias('name')]
        [Parameter(
            Mandatory,
            ValueFromPipelineByPropertyName
        )]
        [string] $EnvironmentName
    )
    begin {}
    process {
        $RepoID = (Get-GitHubRepo).id
        #/repositories/{repository_id}/environments/{environment_name}/secrets/{secret_name}
        #/repositories/{repository_id}/environments/{environment_name}/secrets
        # API Reference
        # https://docs.github.com/en/rest/reference/repos#get-all-environments
        $APICall = @{
            Uri     = "$APIBaseURI/repositories/$RepoID/environments/$EnvironmentName/secrets"
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
        return $Response.secrets
    }
    end {}
}
