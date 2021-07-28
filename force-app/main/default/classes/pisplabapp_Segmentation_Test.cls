@isTest
private class pisplabapp_Segmentation_Test {
	@isTest
    private static void test_ParseSegmentationResult_postitive(){
        List<String> payloads = new List<String>();
        payloads.add('{"@attributes":{"stat":"ok","version":1},"list":{"id":21943,"name":"Seg A","is_public":false,"is_dynamic":false,"title":"Seg A","description":"Seg A","is_crm_visible":false,"created_at":"2021-07-14 10:41:26","updated_at":"2021-07-14 10:41:26"}}');
        List<pisplabapp_Segmentation.ParseSegmentationResult> segResult = pisplabapp_Segmentation.ParseSegmentationResult(payloads);
        System.assertEquals(1, segResult.size());
        System.assertEquals('21943', segResult[0].Id);
        System.assertEquals(false, segResult[0].hasError);
        
        
    }
    @isTest
    private static void test_ParseSegmentationResult_negative(){
        List<String> payloads = new List<String>();
        payloads.add('{"@attributes":{"stat":"fail","version":1}}');
        List<pisplabapp_Segmentation.ParseSegmentationResult> segResult = pisplabapp_Segmentation.ParseSegmentationResult(payloads);
        System.assertEquals(1, segResult.size());
        
        //Should fail as "list" is not there
        System.assertEquals(true, segResult[0].hasError);
        
        
    }
    @isTest
    private static void test_ParseSegmentationResult_negative_2(){
        List<String> payloads = new List<String>();
        payloads.add('{"@attributes":{"stat":"fail","version":1},"list":{}}');
        
               
        List<pisplabapp_Segmentation.ParseSegmentationResult> segResult = pisplabapp_Segmentation.ParseSegmentationResult(payloads);
        System.assertEquals(1, segResult.size());
        
        //Should fail as "id" is not there
        System.assertEquals(true, segResult[0].hasError);
        
        
    }
    /* */
    @istest
    private static void test_getSegmentationLists_positive(){
        List<PardotTenant> pt = [SELECT Id, PardotTenantName,PardotTenantAccountType,PardotTenantId FROM PardotTenant];
        
        //Set up for callout
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('pardot_segmentation_lists_response_success');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json');
        Test.setMock(HttpCalloutMock.class, mock);

        Test.startTest();
        pisplabapp_segmentationListJson jsonClass = pisplabapp_Segmentation.getSegmentationLists((string)pt[0].Id); 
        Test.stopTest();
        
        System.assertEquals('2', jsonClass.rsp.result.total_results);
    }
}