Function Get-GitHubWorkflowRun {
    [CmdletBinding()]
    param (
        $Owner = $script:Owner,
        $Repo = $script:Repo,
        $Token = $script:Token ,
        $Name,
        $ID
    )

    $Results = @()
    $i = 0
    # API Reference
    # https://docs.github.com/en/rest/reference/actions#list-workflow-runs-for-a-repository
    do {
        $i++
        $APICall = @{
            Uri     = "$APIBaseURI/repos/$Owner/$Repo/actions/runs?per_page=100&page=$i"
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
        $WorkflowRuns = $Response.workflow_runs
        $Results += $WorkflowRuns
    } while ($WorkflowRuns.count -eq 100)
    return $Results | Where-Object Name -Match $Name | Where-Object workflow_id -Match $ID
}
