public with sharing class pisplabapp_Controller {
    
    /*
pisplabapp_FlowInputInfo req = new pisplabapp_FlowInputInfo ();
req.idLeads = new List<Id>(new Map<Id, Lead>([select Id from Lead limit 2]).keySet());
req.segmentName = 'Seg JR - A';
req.campaignName = 'Campaign Jr - A';
pisplabapp_Controller.automatePardotIntegration (req);
*/
    
    @auraEnabled
    
    public static void automatePardotIntegration(pisplabapp_FlowInputInfo req){
        
        
        System.debug('automatePardotIntegration called');
        
        
        Map<String, Object> inputs = new Map<String, Object>();
        
        inputs.put('reqIn', req);
        
        System.debug('automatePardotIntegration before flow');    
        Flow.Interview.pisplabapp.PardotCreateSegProspectTemplateV2 myFlow = 
            new Flow.Interview.pisplabapp.PardotCreateSegProspectTemplateV2(inputs);
        myFlow.start();
        System.debug('automatePardotIntegration after flow');    
        system.debug('isSuccess Variable: ' + myFlow.getVariableValue('isSuccess'));
        
        
    }
    
}