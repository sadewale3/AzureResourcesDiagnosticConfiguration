$logAnalyticsName = Read-Host -Prompt 'Please provide name of Log Analytics Workspace'
$logAnalyticsRG = Read-Host -Prompt 'Please provide resource group of Log Analytics Workspace'
$logAnalyticsSubscription = Read-Host -Prompt 'Please provide subscription ID of Log Analytics Workspace'
$contextName = "lawscontext"

Set-AzContext -Name $contextName -Subscription $logAnalyticsSubscription -Force
$logAnalyticsResource = Get-AzOperationalInsightsWorkspace -Name $logAnalyticsName -ResourceGroupName $logAnalyticsRG
Remove-AzContext -Name $contextName -Force

$kvList = Get-AzKeyVault


foreach ($kvItem in $kvList){
    $diagSettingName = $kvItem.vaultName+"-diag-01"
    Set-AzDiagnosticSetting -Name $diagSettingName -ResourceId $kvItem.ResourceId -Enabled $true -WorkspaceId $logAnalyticsResource.ResourceId -Category AuditEvent
    $Output = "Diagnostic Setting has been enabled for "+$kvItem.vaultName+" Key Vault"
    $Output
}