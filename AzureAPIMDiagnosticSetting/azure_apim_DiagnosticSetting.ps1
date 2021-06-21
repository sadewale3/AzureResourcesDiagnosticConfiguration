$logAnalyticsName = Read-Host -Prompt 'Please provide name of Log Analytics Workspace'
$logAnalyticsRG = Read-Host -Prompt 'Please provide resource group of Log Analytics Workspace'
$logAnalyticsSubscription = Read-Host -Prompt 'Please provide subscription ID of Log Analytics Workspace'
$contextName = "lawscontext"

Set-AzContext -Name $contextName -Subscription $logAnalyticsSubscription -Force
$logAnalyticsResource = Get-AzOperationalInsightsWorkspace -Name $logAnalyticsName -ResourceGroupName $logAnalyticsRG
Remove-AzContext -Name $contextName -Force

$apimList = Get-AzApiManagement

foreach ($apimItem in $apimList){
    $diagSettingName = $apimItem.Name+"-diag-01"
    Set-AzDiagnosticSetting -Name $diagSettingName -ResourceId $apimItem.ID -Enabled $true -WorkspaceId $logAnalyticsResource.ResourceId -Category GatewayLogs
    $Output = "Diagnostic Setting has been enabled for "+$apimItem.Name+" API Management Service"
    $Output
}