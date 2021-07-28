@isTest
private class pisplabapp_Prospect_Test {
    @testSetup
    private static void createData(){
        List<Lead> listObj = new List<Lead>();
        for(Integer i=0;i<10;i++){
            Lead l = new Lead();
            l.FirstName = 'First ' + i;
            l.LastName = 'Last ' + i;
            l.Email = 'testemail.'+i+'@email.com';
            l.Company = 'Company ' + i;
            listObj.add(l);
        }
        insert listObj;
    }
    @isTest
    private static void UpsertProspects_test_positive(){
        List<PardotTenant> pt = [SELECT Id, PardotTenantName,PardotTenantAccountType,PardotTenantId FROM PardotTenant];
       	List<pisplabapp_Prospect.ProspectUpsertRequest> pr = new List<pisplabapp_Prospect.ProspectUpsertRequest>();
    	pisplabapp_Prospect.ProspectUpsertRequest prObj = new pisplabapp_Prospect.ProspectUpsertRequest();
        prObj.idLeads = new List<Id>(new Map<Id, Lead>([select Id from Lead limit 2]).keySet());
        prObj.segmentListId = '21649';
        prObj.businessUnitId = pt[0].Id;
	    pr.add(prObj);
        
        //Set up for callout
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('pardot_prospect_upsert_response_success');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, mock);

        Test.startTest();
    	List<pisplabapp_Prospect.ProspectUpsertRes> pur =pisplabapp_Prospect.upsertProspects(pr);
        Test.stopTest();
        
        //System.assertEquals('{"@attributes":{"stat":"ok","version":1},"errors":{}}', res.getBody());
        //System.assertEquals(200,res.getStatusCode());
        //System.assertEquals('application/json', res.getHeader('Content-Type')); 
        
		System.assertEquals(true,pur[0].isSuccess);
    }

    @isTest
    private static void UpsertProspects_test_negative(){
        List<PardotTenant> pt = [SELECT Id, PardotTenantName,PardotTenantAccountType,PardotTenantId FROM PardotTenant];
       	List<pisplabapp_Prospect.ProspectUpsertRequest> pr = new List<pisplabapp_Prospect.ProspectUpsertRequest>();
    	pisplabapp_Prospect.ProspectUpsertRequest prObj = new pisplabapp_Prospect.ProspectUpsertRequest();
        prObj.idLeads = new List<Id>();//Empty list, it should fail
        prObj.segmentListId = '21649';
        prObj.businessUnitId = pt[0].Id;
	    pr.add(prObj);
        
        //Set up for callout
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('pardot_prospect_upsert_response_success');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, mock);

        Test.startTest();
    	List<pisplabapp_Prospect.ProspectUpsertRes> pur =pisplabapp_Prospect.upsertProspects(pr);
        Test.stopTest();
        
        //System.assertEquals('{"@attributes":{"stat":"ok","version":1},"errors":{}}', res.getBody());
        //System.assertEquals(200,res.getStatusCode());
        //System.assertEquals('application/json', res.getHeader('Content-Type')); 
        
		System.assertEquals(false,pur[0].isSuccess);
    }
}