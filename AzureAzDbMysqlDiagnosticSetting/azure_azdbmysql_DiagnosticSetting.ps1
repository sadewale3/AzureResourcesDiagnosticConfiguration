$logAnalyticsName = Read-Host -Prompt 'Please provide name of Log Analytics Workspace'
$logAnalyticsRG = Read-Host -Prompt 'Please provide resource group of Log Analytics Workspace'
$logAnalyticsSubscription = Read-Host -Prompt 'Please provide subscription ID of Log Analytics Workspace'
$contextName = "lawscontext"

$logAnalyticsResourceID = "/subscriptions/"+$logAnalyticsSubscription+"/resourcegroups/"+$logAnalyticsRG+"/providers/microsoft.operationalinsights/workspaces/"+$logAnalyticsName

$azdbmysqlList = Get-AzMySqlServer

foreach ($azdbmysqlItem in $azdbmysqlList){
    $out2 = "testing"
    $out2
    $diagSettingName = $azdbmysqlItem.Name+"-diag-01"
    Set-AzDiagnosticSetting -Name $diagSettingName -ResourceId $azdbmysqlItem.ID -Enabled $true -WorkspaceId $logAnalyticsResourceID -Category MySqlSlowLogs,MySqlAuditLogs 
    $Output = "Diagnostic Setting has been enabled for "+$azdbmysqlItem.Name+" Azure DB for MySQL"
    $Output
}