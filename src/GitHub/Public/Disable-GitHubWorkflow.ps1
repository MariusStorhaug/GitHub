Function Disable-GitHubWorkflow {
    [CmdletBinding()]
    param (
        $Owner = $script:Owner,
        $Repo = $script:Repo,
        $Token = $script:Token ,
        [Parameter(
            Mandatory,
            ValueFromPipelineByPropertyName
        )]
        [string[]] $ID
    )

    begin {}
    process {
        # API Reference
        # https://docs.github.com/en/rest/reference/actions#disable-a-workflow
        $APICall = @{
            Uri     = "$APIBaseURI/repos/$Owner/$Repo/actions/workflows/$ID/disable"
            Headers = @{
                Authorization  = "token $Token"
                'Content-Type' = 'application/json'
            }
            Method  = 'PUT'
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
    }
    end {}
}
