$logAnalyticsName = $args[0]
$logAnalyticsRG = $args[1]
$logAnalyticsResource = Get-AzOperationalInsightsWorkspace -Name $logAnalyticsName -ResourceGroupName $logAnalyticsRG
$pubiPList = Get-AzPublicIpAddress

foreach ($pubipItem in $pubipList){
    $diagSettingName = $pubipItem.Name+"-diag-01"
    Set-AzDiagnosticSetting -Name $diagSettingName -ResourceId $pubipItem.ID -Enabled $true -WorkspaceId $logAnalyticsResource.ResourceId -Category DDoSProtectionNotifications,DDoSMitigationFlowLogs,DDoSMitigationReports
    $Output = "Diagnostic Setting has been enabled for "+$pubipItem.Name+" Public IP"
    $Output
}