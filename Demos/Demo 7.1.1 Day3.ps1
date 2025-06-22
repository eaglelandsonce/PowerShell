<#
Part 1: This is the buggy command
What will this do? What is the EXPECTATION?
What SHOULD happen? What is the INTENDED OUTPUT?
#>
Get-CimInstance -ClassName Win32_LogicalDisk `
                -Filter "DriveType=3" |
Select-Object -Property DeviceID, Size, FreeSpace |
Sort-Object -Property FreeSpace
