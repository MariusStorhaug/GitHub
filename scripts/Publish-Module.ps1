[CmdletBinding()]
param (
    [Parameter()]
    [string] $ModuleName,

    [Parameter()]
    [string] $APIKey
)

# $Info = Invoke-Expression (Get-Content .\src\$ModuleName\$ModuleName.psd1 -Raw)
# foreach ($Module in $Info.RequiredModules) {
#     Write-Verbose "Install module: $($Module.ModuleName)"
#     try {
#         Install-Module -Name $Module.ModuleName -Force -Verbose
#     } catch {
#         Write-Warning 'Unable to install required module.'
#         Write-Warning $_.Exception.Message
#     }
# }

.\scripts\Set-ModuleVersion.ps1 -ModuleName $ModuleName -Verbose
Publish-Module -Path "src/$ModuleName" -NuGetApiKey $APIKey -Verbose

