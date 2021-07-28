@isTest
private class pisplabapp_LeadsActionController_Test {

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
    private static void pisplabapp_LeadsActionController_postitive(){
        List<Lead> listObj = [Select Id from lead];
        System.debug(listObj);
        
        Test.startTest();
        Test.setCurrentPage(Page.pisplabapp_LeadQuickActionVF);
        ApexPages.StandardSetController sc = new ApexPages.StandardSetController(listObj);
		 sc.setSelected(listObj);
        pisplabapp_LeadsActionController controller = new pisplabapp_LeadsActionController(sc);
        Test.stopTest();
        
        System.assertEquals(10, controller.getLeadRecordsSize());
    }
}