$logAnalyticsName = Read-Host -Prompt 'Please provide name of Log Analytics Workspace'
$logAnalyticsRG = Read-Host -Prompt 'Please provide resource group of Log Analytics Workspace'
$logAnalyticsSubscription = Read-Host -Prompt 'Please provide subscription ID of Log Analytics Workspace'

$logAnalyticsResourceID = "/subscriptions/"+$logAnalyticsSubscription+"/resourcegroups/"+$logAnalyticsRG+"/providers/microsoft.operationalinsights/workspaces/"+$logAnalyticsName

$apimList = Get-AzApiManagement

foreach ($apimItem in $apimList){
    $diagSettingName = $apimItem.Name+"-diag-01"
    Set-AzDiagnosticSetting -Name $diagSettingName -ResourceId $apimItem.ID -Enabled $true -WorkspaceId $logAnalyticsResourceID -Category GatewayLogs
    $Output = "Diagnostic Setting has been enabled for "+$apimItem.vaultName+" API Management Service"
    $Output
}
