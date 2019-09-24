# -------------- 
# Set params
$buildName = "MovieReviewsDatabase"
$DatabaseName = "MovieReviewsDatabase"

Write-Host "This build will deploy: " $buildName " to Server: " $ServerName

try {
# Load in DAC DLL (requires config file to support .NET 4.0)
Add-Type -path "C:\Program Files\Microsoft SQL Server\150\DAC\bin\Microsoft.SqlServer.Dac.dll"

# Make DacServices object
$d = New-Object Microsoft.SqlServer.Dac.DacServices "Data Source=LAPTOP-MUF8A1OO\SQLEXPRESS;Integrated Security=True;Persist Security Info=False;Pooling=False;MultipleActiveResultSets=False;Connect Timeout=60;Encrypt=False;TrustServerCertificate=False";

# Register events (this will write info messages to the Task Log)
Register-ObjectEvent -in $d -EventName Message -Source "msg" -Action { Out-Host -in $Event.SourceArgs[1].Message.Message} | Out-Null

# Get dacpac file
$dacpac = (Get-Location).Path + "\Content\" + $buildName + ".dacpac"
# '\Content\' is from the nuget package that is created. So, you cannot see it on the local directory

# Load dacpac from file & deploy to database
$dp = [Microsoft.SqlServer.Dac.DacPackage]::Load($dacpac)

# Set the DacDeployOptions
$options = New-Object Microsoft.SqlServer.Dac.DacDeployOptions -Property @{
   'BlockOnPossibleDataLoss' = $true;
   'DropObjectsNotInSource' = $false;
   'ScriptDatabaseOptions' = $true;
}

# Generate the deployment script
$deployScriptName = $buildName + ".sql"
$deployScript = $d.GenerateDeployScript($dp, $DatabaseName, $options)

# Write the script out to a file
$deployScript | Out-File $deployScriptName

# Deploy the dacpac
$d.Deploy($dp, $DatabaseName, $true, $options)

# Clean up event
Unregister-Event -Source "msg"

exit 0 # Success
}
catch {
# Called on terminating error. $_ will contain details
exit 1 # Failure
}