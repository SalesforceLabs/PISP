@isTest
private class pisplabapp_FlowInputInfo_Test {
	@isTest
    private static void testVars(){
        pisplabapp_FlowInputInfo flowInput = new pisplabapp_FlowInputInfo();
        flowInput.idLeads = new List<String>();
        flowInput.segmentName = 'Segment A';
        flowInput.campaignName = 'Campaign A';
        
        System.assertEquals('Segment A', flowInput.segmentName);
    }
}