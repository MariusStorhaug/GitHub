Function Get-GitHubWorkflowUsage {
    [CmdletBinding(
        DefaultParameterSetName = 'ByName'
    )]
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
        # https://docs.github.com/en/rest/reference/actions#get-workflow-usage
        $APICall = @{
            Uri     = "$APIBaseURI/repos/$Owner/$Repo/actions/workflows/$ID/timing"
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
        return $Response.billable
    }
    end {}
}
