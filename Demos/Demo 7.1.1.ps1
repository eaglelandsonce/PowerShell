<#
Part 1: This is the buggy command
What will this do? What is the EXPECTATION?
What SHOULD happen? What is the INTENDED OUTPUT?
#>
Get-CimInstance -class Win32_LogicalDisk `
                -filter "drivetype=3" |
Select -Property DeviceID,Size,FreeSpace |
Sort -Property FreeSpace
