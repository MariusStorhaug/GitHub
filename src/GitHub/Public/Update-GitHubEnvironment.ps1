function Update-GitHubEnvironment {
    [CmdletBinding()]
    param (
        $Owner = $script:Owner,
        $Repo = $script:Repo,
        $Token = $script:Token ,
        [Alias('environment_name')]
        [Parameter(
            Mandatory,
            ValueFromPipelineByPropertyName
        )]
        [string] $Name
    )
    begin {}
    process {
        # API Reference
        # https://docs.github.com/en/rest/reference/repos#create-or-update-an-environment
        $APICall = @{
            Uri     = "$APIBaseURI/repos/$Owner/$Repo/environments/$Name"
            Headers = @{
                Authorization  = "token $Token"
                'Content-Type' = 'application/json'
            }
            Method  = 'PUT'
            Body    = @{
                owner            = $Owner
                repo             = $Repo
                environment_name = $Name
            } | ConvertTo-Json -Depth 100
        }
        try {
            if ($PSBoundParameters.ContainsKey('Verbose')) {
                $APICall
            }
            $Response = Invoke-RestMethod @APICall
        } catch {
            throw $_
        }
        $Response
    }
    end {}
}
