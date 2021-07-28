@isTest
private class pisplabapp_Controller_Test {
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
	@istest
    private static void automatePardotIntegration_positive(){
        pisplabapp_FlowInputInfo req = new pisplabapp_FlowInputInfo ();
        req.idLeads = new List<Id>(new Map<Id, Lead>([select Id from Lead limit 2]).keySet());
        req.segmentName = 'Seg JR - A';
        req.campaignName = 'Campaign Jr - A';
        Test.startTest();
        pisplabapp_Controller.automatePardotIntegration (req);
        test.stopTest();
    }
}