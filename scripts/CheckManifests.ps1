$ModuleFolders = Get-ChildItem -Path .\src
$ModuleInfo = @()
foreach ($ModuleFolder in $ModuleFolders) {
    $ManifestFile = $ModuleFolder | Get-ChildItem -Filter *.psd1
    $Info = Invoke-Expression (Get-Content $ManifestFile -Raw)
    $Info.Name = $ModuleFolder.Name
    $ModuleInfo += $Info
}

$ModuleInfo | Select-Object Name, ModuleVersion, GUID | Sort-Object GUID
