#
# Module manifest for module 'GitHub'
#
# Generated by: Marius Storhaug
#
# Generated on: 24.12.2021
# https://docs.microsoft.com/en-us/powershell/scripting/developer/module/how-to-write-a-powershell-module-manifest?view=powershell-7.2
#

@{

    # Script module or binary module file associated with this manifest.
    RootModule           = 'GitHub.psm1'

    # Version number of this module.
    ModuleVersion        = '0.0.1'

    # Supported PSEditions
    # CompatiblePSEditions = @()

    # ID used to uniquely identify this module
    GUID                 = '6ba4720b-1b0b-4c26-96b4-45977c885d11'

    # Author of this module
    Author               = 'Marius Storhaug'

    # Company or vendor of this module
    CompanyName          = 'Marius Storhaug'

    # Copyright statement for this module
    Copyright            = '(c) Marius Storhaug. All rights reserved.'

    # Description of the functionality provided by this module
    Description          = 'PowerShell Module for GitHub'

    # Minimum version of the PowerShell engine required by this module
    PowerShellVersion    = '7.1'

    # Name of the PowerShell host required by this module
    # PowerShellHostName = ''

    # Minimum version of the PowerShell host required by this module
    # PowerShellHostVersion = ''

    # Minimum version of Microsoft .NET Framework required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
    # DotNetFrameworkVersion = ''

    # Minimum version of the common language runtime (CLR) required by this module. This prerequisite is valid for the PowerShell Desktop edition only.
    # ClrVersion = ''

    # Processor architecture (None, X86, Amd64) required by this module
    # ProcessorArchitecture = ''

    # Modules that must be imported into the global environment prior to importing this module.
    # This loads any modules listed unless they've already been loaded. For example, some modules
    # may already be loaded by a different module. It's possible to specify a specific version to
    # load using RequiredVersion rather than ModuleVersion. When ModuleVersion is used it will load
    # the newest version available with a minimum of the version specified. You can combine strings
    # and hash tables in the parameter value.
    # Example: RequiredModules = @("MyModule", @{ModuleName = "MyDependentModule"; ModuleVersion = "2.0"; GUID = "cfc45206-1e49-459d-a8ad-5b571ef94857" })
    # Example: RequiredModules = @('MyModule', @{ModuleName = 'MyDependentModule'; RequiredVersion = '1.5'; GUID = 'cfc45206-1e49-459d-a8ad-5b571ef94857' })
    RequiredModules      = @(
        @{
            ModuleName    = 'GitHub.Core'
            ModuleVersion = '0.0.1'
        }
    )

    # Assemblies that must be loaded prior to importing this module
    # RequiredAssemblies = @()

    # Script files (.ps1) that are run in the caller's environment prior to importing this module.
    # ScriptsToProcess = @()

    # Type files (.ps1xml) to be loaded when importing this module
    # TypesToProcess = @()

    # Format files (.ps1xml) to be loaded when importing this module
    # FormatsToProcess = @()

    # Modules to import as nested modules of the module specified in RootModule/ModuleToProcess
    # NestedModules = @()

    # Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
    FunctionsToExport    = '*'

    # Cmdlets to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no cmdlets to export.
    CmdletsToExport      = @()

    # Variables to export from this module
    VariablesToExport    = '*'

    # Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
    AliasesToExport      = @()

    # DSC resources to export from this module
    # DscResourcesToExport = @()

    # List of all modules packaged with this module
    # ModuleList = @()

    # List of all files packaged with this module
    # FileList = @()

    # Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
    PrivateData          = @{

        PSData = @{

            # Tags applied to this module. These help with module discovery in online galleries.
            Tags                       = 'GitHub', 'PowerShell', 'pwsh'

            # A URL to the license for this module.
            LicenseUri                 = 'https://github.com/MariusStorhaug/GitHub/blob/main/LICENSE.md'

            # A URL to the main website for this project.
            ProjectUri                 = 'https://github.com/MariusStorhaug/GitHub'

            # A URL to an icon representing this module.
            IconUri                    = 'https://raw.githubusercontent.com/MariusStorhaug/GitHub/main/icons/GitHubPowerShellModule.png'

            # ReleaseNotes of this module
            ReleaseNotes               = ''

            # Prerelease string of this module
            Prerelease                 = ''

            # Flag to indicate whether the module requires explicit user acceptance for install/update/save
            RequireLicenseAcceptance   = $false

            # External dependent modules of this module
            ExternalModuleDependencies = @()

        }

    }

    # HelpInfo URI of this module
    # HelpInfoURI = ''

    # Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
    # DefaultCommandPrefix = 'GitHub'

}

