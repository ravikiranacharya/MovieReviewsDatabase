# Set params
$databaseName = "MovieReviewsDatabase"

# Add the DLL
# For 32-bit machines
#Add-Type -path "C:\Program Files\Microsoft SQL Server\110\DAC\bin\Microsoft.SqlServer.Dac.dll"
# For 64-bit machines
Add-Type -path "C:\Program Files\Microsoft SQL Server\150\DAC\bin\Microsoft.SqlServer.Dac.dll"

# Create the connection strnig
$d = New-Object Microsoft.SqlServer.Dac.DacServices "Data Source=LAPTOP-MUF8A1OO\SQLEXPRESS;Integrated Security=True;Persist Security Info=False;Pooling=False;MultipleActiveResultSets=False;Connect Timeout=60;Encrypt=False;TrustServerCertificate=False"

$dacpac = (Get-Location).Path + "\Content\" + $databaseName + ".dacpac"

Write-Host $dacpac

# Load dacpac from file & deploy to database
$dp = [Microsoft.SqlServer.Dac.DacPackage]::Load($dacpac)

# Set the DacDeployOptions
$options = New-Object Microsoft.SqlServer.Dac.DacDeployOptions -Property @{
 'BlockOnPossibleDataLoss' = $true;
 'DropObjectsNotInSource' = $false;
 'ScriptDatabaseOptions' = $true;
 'IgnorePermissions' = $true;
 'IgnoreRoleMembership' = $true
}

# Generate the deplopyment script
$deployScriptName = $databaseName + ".sql"
$deployScript = $d.GenerateDeployScript($dp, $databaseName, $options)

# Return the script to the log
Write-Host $deployScript

# Write the script out to a file
$deployScript | Out-File $deployScriptName

# Deploy the dacpac
$d.Deploy($dp, $databaseName, $true, $options)