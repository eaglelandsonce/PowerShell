﻿function Export-HTML {
    [CmdletBinding(DefaultParameterSetName='Page', HelpUri='http://go.microsoft.com/fwlink/?LinkID=113290', RemotingCapability='None')]
    param(
        [Parameter(ValueFromPipeline=$true)]
        [psobject]
        ${InputObject},

        [Parameter(Position=0)]
        [System.Object[]]
        ${Property},

        [Parameter(ParameterSetName='Page', Position=3)]
        [string[]]
        ${Body},

        [Parameter(ParameterSetName='Page', Position=1)]
        [string[]]
        ${Head},

        [Parameter(ParameterSetName='Page', Position=2)]
        [ValidateNotNullOrEmpty()]
        [string]
        ${Title},

        [ValidateNotNullOrEmpty()]
        [ValidateSet('Table','List')]
        [string]
        ${As},

        [Parameter(ParameterSetName='Page')]
        [Alias('cu','uri')]
        [ValidateNotNullOrEmpty()]
        [uri]
        ${CssUri},

        [Parameter(ParameterSetName='Fragment')]
        [ValidateNotNullOrEmpty()]
        [switch]
        ${Fragment},

        [ValidateNotNullOrEmpty()]
        [string[]]
        ${PostContent},

        [ValidateNotNullOrEmpty()]
        [string[]]
        ${PreContent},
    
        [Parameter(Mandatory=$True)] 
        [ValidateNotNullOrEmpty()] 
        [string] 
        $FilePath
        )

    begin
    {
        try {
            $outBuffer = $null
            if ($PSBoundParameters.TryGetValue('OutBuffer', [ref]$outBuffer))
            {
                $PSBoundParameters['OutBuffer'] = 1
            }
            $wrappedCmd = $ExecutionContext.InvokeCommand.GetCommand('ConvertTo-Html', [System.Management.Automation.CommandTypes]::Cmdlet)
            $PSBoundParameters.Remove('FilePath') | Out-Null 
            $scriptCmd = {& $wrappedCmd @PSBoundParameters | Out-File $FilePath}
            $steppablePipeline = $scriptCmd.GetSteppablePipeline($myInvocation.CommandOrigin)
            $steppablePipeline.Begin($PSCmdlet)
        } catch {
            throw
        }
    }

    process
    {
        try {
            $steppablePipeline.Process($_)
        } catch {
            throw
        }
    }

    end
    {
        try {
            $steppablePipeline.End()
        } catch {
            throw
        }
    }
    <#

    .ForwardHelpTargetName ConvertTo-Html
    .ForwardHelpCategory Cmdlet

    #>
}

