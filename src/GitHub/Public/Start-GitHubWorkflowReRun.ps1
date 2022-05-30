function Start-GitHubWorkflowReRun {
    [CmdletBinding()]
    param (
        $Owner = $script:Owner,
        $Repo = $script:Repo,
        $Token = $script:Token ,
        [Alias('workflow_id')]
        [Parameter(
            Mandatory,
            ValueFromPipelineByPropertyName
        )]
        [string] $ID
    )
    begin {}
    process {
        # API Reference
        # https://docs.github.com/en/rest/reference/actions#re-run-a-workflow
        $APICall = @{
            Uri     = "$APIBaseURI/repos/$Owner/$Repo/actions/runs/$ID/rerun"
            Headers = @{
                Authorization  = "token $Token"
                'Content-Type' = 'application/json'
            }
            Method  = 'POST'
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
    end {}
}
