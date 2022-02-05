# API Authorization
# https://docs.github.com/en/rest/overview/other-authentication-methods


# https://docs.github.com/en/rest/overview/resources-in-the-rest-api
# https://docs.github.com/en/rest/reference

<#
.SYNOPSIS
Short description

.DESCRIPTION
Long description

.PARAMETER Token
Parameter description

.EXAMPLE
An example

.NOTES
https://docs.github.com/en/rest/reference/meta#github-api-root
#>
function Get-GitHubRoot {
    [CmdletBinding()]
    param (
        $Token = $script:Token
    )

    Invoke-GitHubAPI -Token $Token

    return $Response
}


function Get-GitHubRepo {
    [CmdletBinding()]
    param (
        $Owner = $script:Owner,
        $Repo = $script:Repo,
        $Token = $script:Token
    )

    # API Reference
    # https://docs.github.com/en/rest/reference/repos#get-a-repository
    $APICall = @{
        Uri     = "$APIBaseURI/repos/$Owner/$Repo"
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

function Get-GitHubEmojis {
    [CmdletBinding()]
    param (
        $Token = $script:Token
    )

    # API Reference
    # https://docs.github.com/en/rest/reference/emojis#get-emojis
    $APICall = @{
        Uri     = "$APIBaseURI/emojis"
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

Function Get-GitHubWorkflow {
    [CmdletBinding(
        DefaultParameterSetName = 'ByName'
    )]
    param (
        $Owner = $script:Owner,
        $Repo = $script:Repo,
        $Token = $script:Token ,
        [Parameter(
            ParameterSetName = 'ByName'
        )]
        [string] $Name,
        [Parameter(
            ParameterSetName = 'ByID'
        )]
        [string] $ID,
        [int] $PageSize = 100
    )

    # API Reference
    # https://docs.github.com/en/rest/reference/actions#list-repository-workflows
    $processedPages = 0
    $workflows = @()
    do {
        $processedPages += 1
        $APICall = @{
            Uri     = "$APIBaseURI/repos/$Owner/$Repo/actions/workflows?per_page=$PageSize&page=$processedPages"
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
        $workflows += $Response.workflows | Where-Object name -Match $name | Where-Object id -Match $id
    } while ($Response.total_count -eq 100)

    return $workflows
}

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

Function Enable-GitHubWorkflow {
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
        # https://docs.github.com/en/rest/reference/actions#enable-a-workflow
        $APICall = @{
            Uri     = "$APIBaseURI/repos/$Owner/$Repo/actions/workflows/$ID/enable"
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

function Remove-GitHubWorkflowRun {
    [CmdletBinding()]
    param (
        $Owner = $script:Owner,
        $Repo = $script:Repo,
        $Token = $script:Token ,
        [Parameter(
            Mandatory,
            ValueFromPipelineByPropertyName
        )]
        [string] $ID
    )

    begin {}
    process {
        # API Reference
        # https://docs.github.com/en/rest/reference/actions#delete-a-workflow-run
        $APICall = @{
            Uri     = "$APIBaseURI/repos/$Owner/$Repo/actions/runs/$ID"
            Headers = @{
                Authorization  = "token $Token"
                'Content-Type' = 'application/json'
            }
            Method  = 'DELETE'
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

function Stop-GitHubWorkflowRun {
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
        # https://docs.github.com/en/rest/reference/actions#cancel-a-workflow-run
        $APICall = @{
            Uri     = "$APIBaseURI/repos/$Owner/$Repo/actions/runs/$ID/cancel"
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
    }
    end {}
}

function Start-GitHubWorkflowRun {
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
