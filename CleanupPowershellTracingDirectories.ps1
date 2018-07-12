#------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Script: CleanupPowershellTracingDirectories.ps1 
#
# Created by metadataconsult@gmail.com, metadataconsulting.blogspot.ca, 2018
#
# Function: 
#
# Removes the Poweshell Script Tracing directories, by strictly matching directories in documents directory that match YYYYMMDD only.
#
# Warranty: 
#
# The  scripts are provided AS IS without warranty of any kind. 
# Metadata Consulting further disclaims all implied warranties including,  
# without limitation, any implied warranties of merchantability or of fitness for 
# a particular purpose. The entire risk arising out of the use or performance of  
# the  scripts and documentation remains with you. 
# Metadata Consulting, its authors, or anyone else involved in the creation, production, or 
# delivery of the scripts be liable for any damages whatsoever (including, 
# without limitation, damages for loss of business profits, business interruption, 
# loss of business information, or other pecuniary loss) arising out of the use 
# of or inability to use the  scripts or documentation, even if  
# has been advised of the possibility of such damages. 
#------------------------------------------------------------------------------------------------------------------------------------------------------------------

$docfolder = "${Env:USERPROFILE}\Documents"

Write-Host "Listing All Poweshell Script Tracing Directories in folder $docfolder" -ForegroundColor Cyan
# https://stackoverflow.com/questions/4766845/yyyymmdd-date-format-regular-expression-to-validate-a-date-in-c-sharp-net - mactches leap years as well
Get-ChildItem $docfolder | Where {$_.Name -Match "^(?:(?:(?:(?:(?:[13579][26]|[2468][048])00)|(?:[0-9]{2}(?:(?:[13579][26])|(?:[2468][048]|0[48]))))(?:(?:(?:09|04|06|11)(?:0[1-9]|1[0-9]|2[0-9]|30))|(?:(?:01|03|05|07|08|10|12)(?:0[1-9]|1[0-9]|2[0-9]|3[01]))|(?:02(?:0[1-9]|1[0-9]|2[0-9]))))|(?:[0-9]{4}(?:(?:(?:09|04|06|11)(?:0[1-9]|1[0-9]|2[0-9]|30))|(?:(?:01|03|05|07|08|10|12)(?:0[1-9]|1[0-9]|2[0-9]|3[01]))|(?:02(?:[01][0-9]|2[0-8])))))$"}

$title = "Delete Poweshell Script Tracing Directories?"
$message = "Choose default Exit,`nor DELETE Selected Powershell Script Tracing Directories,`nor DELETE SILENT All Powershell Script Tracing Directories.`nThis is permanent delete, there is no recycle-bin recovery."
$msg1 = "Exit" 
$msg2 = "DELETE Selected Script Tracing Directories forever, no recycle bin!"
$msg3 = "DELETE All Silently Script Tracing Directories forever, no recycle bin!"
$one = New-Object System.Management.Automation.Host.ChoiceDescription "&Exit", $msg1 
$two = New-Object System.Management.Automation.Host.ChoiceDescription "&Delete Selected", $msg2
$three = New-Object System.Management.Automation.Host.ChoiceDescription "&Delete Silent", $msg3
$options = [System.Management.Automation.Host.ChoiceDescription[]]($one,$two, $three)
$result = $host.ui.PromptForChoice($title, $message, $options, 0) 

Write-Host ""
switch ($result)
    {
        0 {Write-Host "You selected `n1. $msg1" -ForegroundColor Cyan;}
        1 {Write-Host "You selected `n2. $msg2" -ForegroundColor Cyan;}
        2 {Write-Host "You selected `n3. $msg3" -ForegroundColor Cyan;}
        default {Write-Host "You choose something else. Exiting"; exit}
    }

if ($result -eq 1) {

Get-ChildItem $docfolder | Where {$_.Name -Match "^(?:(?:(?:(?:(?:[13579][26]|[2468][048])00)|(?:[0-9]{2}(?:(?:[13579][26])|(?:[2468][048]|0[48]))))(?:(?:(?:09|04|06|11)(?:0[1-9]|1[0-9]|2[0-9]|30))|(?:(?:01|03|05|07|08|10|12)(?:0[1-9]|1[0-9]|2[0-9]|3[01]))|(?:02(?:0[1-9]|1[0-9]|2[0-9]))))|(?:[0-9]{4}(?:(?:(?:09|04|06|11)(?:0[1-9]|1[0-9]|2[0-9]|30))|(?:(?:01|03|05|07|08|10|12)(?:0[1-9]|1[0-9]|2[0-9]|3[01]))|(?:02(?:[01][0-9]|2[0-8])))))$"} | Remove-Item -ErrorAction Stop
Write-Host "Deleted selected Poweshell Script Tracing Directories in folder $docfolder" -ForegroundColor Yellow
Write-Host "Done" -ForegroundColor Cyan

}
elseif ($result -eq 2) {

Get-ChildItem $docfolder | Where {$_.Name -Match "^(?:(?:(?:(?:(?:[13579][26]|[2468][048])00)|(?:[0-9]{2}(?:(?:[13579][26])|(?:[2468][048]|0[48]))))(?:(?:(?:09|04|06|11)(?:0[1-9]|1[0-9]|2[0-9]|30))|(?:(?:01|03|05|07|08|10|12)(?:0[1-9]|1[0-9]|2[0-9]|3[01]))|(?:02(?:0[1-9]|1[0-9]|2[0-9]))))|(?:[0-9]{4}(?:(?:(?:09|04|06|11)(?:0[1-9]|1[0-9]|2[0-9]|30))|(?:(?:01|03|05|07|08|10|12)(?:0[1-9]|1[0-9]|2[0-9]|3[01]))|(?:02(?:[01][0-9]|2[0-8])))))$"} | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
Write-Host "Deleted all Poweshell Script Tracing Directories in folder $docfolder, errors silently ignored." -ForegroundColor Yellow
Write-Host "Done" -ForegroundColor Cyan

}




