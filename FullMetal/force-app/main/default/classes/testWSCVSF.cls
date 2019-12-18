@isTest

private class testWSCVSF {
    @isTest static void testEchoString() {             
        // This causes a fake response to be generated
        Test.setMock(WebServiceMock.class, new testWS());
         
        // Call the method that invokes a callout
        String output = testCallout.callEchoString('Hello World!');
         
        // Verify that a fake result is returned
        System.assertEquals('Test', output);
    }
}