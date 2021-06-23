$logAnalyticsName = Read-Host -Prompt 'Please provide name of Log Analytics Workspace'
$logAnalyticsRG = Read-Host -Prompt 'Please provide resource group of Log Analytics Workspace'
$logAnalyticsSubscription = Read-Host -Prompt 'Please provide subscription ID of Log Analytics Workspace'

$logAnalyticsResourceID = "/subscriptions/"+$logAnalyticsSubscription+"/resourcegroups/"+$logAnalyticsRG+"/providers/microsoft.operationalinsights/workspaces/"+$logAnalyticsName

$aksList = Get-AzAks

foreach ($aksItem in $aksList){
    $diagSettingName = $aksItem.Name+"-diag-01"
    Set-AzDiagnosticSetting -Name $diagSettingName -ResourceId $aksItem.ID -Enabled $true -WorkspaceId $logAnalyticsResourceID -Category kube-apiserver, kube-audit, kube-audit-admin, kube-controller-manager, kube-scheduler, cluster-autoscaler, guard
    $Output = "Diagnostic Setting has been enabled for "+$aksItem.Name+" Azure Kubernetes Service"
    $Output
}
