@isTest
private class pisplabapp_FlowOutputInfo_Test {
	@istest
    private static void testVars(){
        pisplabapp_FlowOutputInfo flowOutput = new pisplabapp_FlowOutputInfo();
        
        System.assertEquals(false, flowOutput.hasError);
        System.assertEquals(null, flowOutput.message);
    }
}