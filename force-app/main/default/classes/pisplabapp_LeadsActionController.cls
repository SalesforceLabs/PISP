public with sharing class pisplabapp_LeadsActionController {
    
    ApexPages.StandardSetController setController;
    public List<Lead> selLeads;
    public List<String> leadIds{get;set;}
    
    public integer getLeadRecordsSize() {
        return setController.getRecords().size();
    }
    
    public pisplabapp_LeadsActionController(ApexPages.StandardSetController controller) {
        this.setController = controller;
        leadIds = new List<String>();
        
        selLeads = setController.getSelected();
        System.debug('Get selLeads=' + selLeads);
        for(Lead l : selLeads){
            leadIds.add(l.Id);
        }
    }
    
}