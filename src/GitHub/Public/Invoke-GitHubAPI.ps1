function Invoke-GitHubAPI {
    [CmdletBinding()]
    param (
        [Parameter()]
        [ValidateSet('GET', 'POST', 'PATCH', 'DELETE')]
        [String] $Method = 'GET',

        [Parameter()]
        [string] $APIEndpoint,

        [Parameter()]
        [hashtable] $Body = @{},

        [Parameter()]
        [string] $Owner = $script:Owner,

        [Parameter()]
        [string] $Repo = $script:Repo,

        [Parameter()]
        [string] $Token = $script:Token
    )
    $APICall = @{
        Uri     = ("$script:APIBaseURI/$APIEndpoint").Replace('\', '/').Replace('//', '/')
        Headers = @{
            Authorization  = "token $Token"
            'Content-Type' = 'application/vnd.github.v3+json' #'application/json'
        }
        Method  = $Method
        Body    = $Body | ConvertTo-Json -Depth 100
    }
    try {
        $Response = Invoke-RestMethod @APICall
    } catch {
        throw $_
    }
    return $Response
}
