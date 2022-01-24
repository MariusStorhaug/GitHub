# API Authorization
# https://docs.github.com/en/rest/overview/other-authentication-methods


# https://docs.github.com/en/rest/overview/resources-in-the-rest-api
# https://docs.github.com/en/rest/reference

$script:APIBaseURI = 'https://api.github.com'
$script:Owner = ''
$script:Repo = ''
$script:Token = ''

function Connect-GitHubAccount {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [String]
        $Owner,
        [Parameter(Mandatory = $true, Position = 1)]
        [String]
        $Repo,
        [Parameter(Mandatory = $true, Position = 2)]
        [String]
        $Token,
        [Parameter(Mandatory = $true, Position = 3)]
        [String]
        $APIBaseURI = 'https://api.github.com'
    )

    $script:APIBaseURI = $APIBaseURI
    $script:Owner = $Owner
    $script:Repo = $Repo
    $script:Token = $Token

    Get-GitHubUser


}

function Get-GitHubUser {
    [CmdletBinding()]
    param (
        $Token = $GHToken
    )

    # API Reference
    # https://docs.github.com/en/rest/reference/users#get-the-authenticated-user
    $APICall = @{
        Uri     = "$APIBaseURI/user"
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

function Get-GitHubRoot {
    [CmdletBinding()]
    param (

        $Token = $GHToken
    )

    # API Reference
    # https://docs.github.com/en/rest/reference/meta#github-api-root
    $APICall = @{
        Uri     = "$APIBaseURI/"
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

function Get-GitHubRepo {
    [CmdletBinding()]
    param (
        $Owner = $GHOwner,
        $Repo = $GHRepo,
        $Token = $GHToken
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
        $Owner = $GHOwner,
        $Repo = $GHRepo,
        $Token = $GHToken
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
        $Token = $GHToken
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
        $Owner = $GHOwner,
        $Repo = $GHRepo,
        $Token = $GHToken,
        [Parameter(
            ParameterSetName = 'ByName'
        )]
        [string] $Name,
        [Parameter(
            ParameterSetName = 'ByID'
        )]
        [string] $ID
    )

    # API Reference
    # https://docs.github.com/en/rest/reference/actions#list-workflow-runs-for-a-repository
    $APICall = @{
        Uri     = "$APIBaseURI/repos/$Owner/$Repo/actions/workflows"
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
    return $Response.workflows | Where-Object name -Match $name | Where-Object id -Match $id
}

Function Disable-GitHubWorkflow {
    [CmdletBinding()]
    param (
        $Owner = $GHOwner,
        $Repo = $GHRepo,
        $Token = $GHToken,
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
        $Owner = $GHOwner,
        $Repo = $GHRepo,
        $Token = $GHToken,
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
        $Owner = $GHOwner,
        $Repo = $GHRepo,
        $Token = $GHToken,
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
        $Owner = $GHOwner,
        $Repo = $GHRepo,
        $Token = $GHToken,
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
        $Owner = $GHOwner,
        $Repo = $GHRepo,
        $Token = $GHToken,
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
        $Owner = $GHOwner,
        $Repo = $GHRepo,
        $Token = $GHToken,
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
        $Owner = $GHOwner,
        $Repo = $GHRepo,
        $Token = $GHToken,
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
        $Owner = $GHOwner,
        $Repo = $GHRepo,
        $Token = $GHToken
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
        $Owner = $GHOwner,
        $Repo = $GHRepo,
        $Token = $GHToken,
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
        $Owner = $GHOwner,
        $Repo = $GHRepo,
        $Token = $GHToken,
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
