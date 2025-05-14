param(
    [string]$LocalServer = "tcp:10.128.0.16,1433",
    [string]$RemoteServer = "34.170.77.150",
    [string]$LocalDB = "aspnet_DB",
    [string]$RemoteDB = "testdb",
    [string]$LocalTable = "asp_user",
    [string]$RemoteTable = "users",
    [string]$User = "sa",
    [string]$Password = "P@ssword@123"
)

$sourceConn = "Server=$LocalServer;Database=$LocalDB;User Id=$User;Password=$Password;"
$destConn   = "Server=$RemoteServer;Database=$RemoteDB;User Id=sqlserver;Password=$Password;"

Write-Host "Fetching data from local SQL Server..."
$data = Invoke-Sqlcmd -Query "SELECT id, user_name, user_email FROM $LocalTable" -ConnectionString $sourceConn

foreach ($row in $data) {
    $insertQuery = "INSERT INTO $RemoteTable (id, user_name, user_email) VALUES ('$($row.id)', '$($row.user_name)', '$($row.user_email)')"
    Invoke-Sqlcmd -Query $insertQuery -ConnectionString $destConn
}

Write-Host "Data copied from $LocalTable to $RemoteTable successfully."
