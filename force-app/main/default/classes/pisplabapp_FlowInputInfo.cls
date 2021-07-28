/**
 * Used to set Input variables that can be sent and used in Flow
 * Add any new config variables here
 */
public with sharing class pisplabapp_FlowInputInfo {
    
    public pisplabapp_FlowInputInfo(){}

    @AuraEnabled
    public List<String> idLeads;
    @AuraEnabled
    public String segmentName;
    @AuraEnabled
    public String campaignName;
}