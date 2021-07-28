public with sharing class pisplabapp_Prospect{
    /**
    * 
    * List<PardotTenant> pt = [SELECT Id, PardotTenantName,PardotTenantAccountType,PardotTenantId FROM PardotTenant];
    //List<Id> objList = [select Id from Lead limit 2];
    
    List<pisplabapp_Prospect.ProspectUpsertRequest> pr = new List<pisplabapp_Prospect.ProspectUpsertRequest>();
    pisplabapp_Prospect.ProspectUpsertRequest prObj = new pisplabapp_Prospect.ProspectUpsertRequest();
    prObj.idLeads = new List<Id>(new Map<Id, Lead>([select Id from Lead limit 2]).keySet());
    prObj.segmentListId = '21649';
    prObj.businessUnitId = pt[0].Id;
    pr.add(prObj);
    
    System.debug(pisplabapp_Prospect.upsertProspects(pr));
     */
    @InvocableMethod(label='Upsert Propspects')
    public static List<ProspectUpsertRes> UpsertProspects(List<ProspectUpsertRequest> upsertInfo) {
        
        List<ProspectUpsertRes> resList = new List<ProspectUpsertRes>(); 
        
        
        List<Lead> lList = [Select Id,FirstName,LastName,Email from Lead where Id in :upsertInfo[0].idLeads with SECURITY_ENFORCED];
        if(lList.size() > 0){
            String jsonList = '[';
            for(Lead l: lList){
                jsonList += '{"list_'+upsertInfo[0].segmentListId+'": 1,"fid":"'+l.Id+'","email":"'+l.Email+'","first_name":"'+l.FirstName+'","last_name":"'+l.LastName+'"},';
            }
            jsonList = jsonList.removeEnd(',');
            jsonList += ']';
            
            ProspectUpsertRes res = new ProspectUpsertRes();
            res.isSuccess = upsertProspectsViaApi(upsertInfo[0].businessUnitId, jsonList);
            resList.add(res);
            
        }else{
            ProspectUpsertRes res = new ProspectUpsertRes();
            res.isSuccess = false;
            resList.add(res);
        }
        return resList;
    }
    
    /**
     * Upsert prospect
     * This is mainly to add this prospect to Segmentation List
     * But, later on, we may want to update some custom fields and those can be added here
     * 
     * Hence the use of Prospect upsert rather than segmentation List API
     */
    private static Boolean upsertProspectsViaApi(String businessUnitId, String jsonList){
        Boolean retValue = false;
        
        try{
            HttpRequest req = new HttpRequest();
            //Using variables to test callouts in Apex Test
            //https://salesforce.stackexchange.com/questions/75490/mock-testing-with-named-credentials
            String namedCredential = 'Pardot_Integration_NC';
			String path = '/api/prospect/version/4/do/batchUpsert?format=json';
            String uri = (Test.isRunningTest() ? 'http://callout.' + namedCredential + '.com':'callout:' + namedCredential) + path;
                
            System.debug(uri);
            req.setEndpoint(uri);
            req.setMethod('POST');
            req.setHeader('Content-Type','application/x-www-form-urlencoded');
            req.setHeader('Pardot-Business-Unit-Id', businessUnitId);
            
            String body = 'prospects={ "prospects": ' + jsonList + ' }';        
            req.setBody(body);
            System.debug(body);
            
            Http http = new Http();
            HTTPResponse res = http.send(req);
            
    
            Map<String, Object> m =  (Map<String, Object>) JSON.deserializeUntyped(res.getBody());
            if(m.containsKey('@attributes') && ((Map<String,Object>)m.get('@attributes')).containsKey('stat')){
            	Map<String,Object> resultMap = (Map<String,Object>)m.get('@attributes');
                retValue = (resultMap.get('stat') == 'ok')?true:false;
            } 
        }catch(Exception e){
            
        }
        return retValue;
    }
    
    
    
    public class ProspectUpsertRequest {
        @InvocableVariable(label='Lead Ids' description='Lead Ids' required=true)
        public List<Id> idLeads;
        
        @InvocableVariable(label='Segment List Id' description='Segment List Id' required=true)
        public String segmentListId;
        
        @InvocableVariable(label='Pardot Business Unit Id' description='Pardot Business Unit Id' required=true)
        public String businessUnitId;
        
    }
    
    
    public class ProspectUpsertRes {
        @InvocableVariable(label='id' description='id' )
        public String id;
        
        @InvocableVariable(label='isSuccess' description='isSuccess' )
        public Boolean isSuccess=false;
        
    }
    
}