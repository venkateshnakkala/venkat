@isTest(SeeAllData=True)
private class Esignurltest {
    testMethod static void testCallout() {
        test.startTest();
        List<echosign_dev1__SIGN_Agreement__c> SignAgreementList=[SELECT Application__c,echosign_dev1__Document_Key__c,EsignUrl__c,Total_Esign_Url_Records__c,Id,Name FROM echosign_dev1__SIGN_Agreement__c WHERE echosign_dev1__StatusVisible__c='Out for Signature' AND Application__c !=null Order By CreatedDate Limit 1];
        // Set mock callout class 
        Test.setMock(HttpCalloutMock.class, new EsignurlMock());
        adobesignIntegration.Esignurl(SignAgreementList[0].Application__c);

        
        test.stopTest();
    }
        testMethod static void testCallout1() {
        test.startTest();
        List<echosign_dev1__SIGN_Agreement__c> SignAgreementList=[SELECT Application__c,echosign_dev1__Document_Key__c,EsignUrl__c,Total_Esign_Url_Records__c,Id,Name FROM echosign_dev1__SIGN_Agreement__c WHERE echosign_dev1__StatusVisible__c='Out for Signature' AND Application__c !=null Order By CreatedDate Limit 1];
       Test.setMock(HttpCalloutMock.class, new EsignurlMock1());
       adobesignIntegration.Esignurl(SignAgreementList[0].Application__c);
      
        test.stopTest();
    }
    
    
}