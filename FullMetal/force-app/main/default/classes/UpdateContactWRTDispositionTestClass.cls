@isTest 
private class UpdateContactWRTDispositionTestClass {
    static testMethod void validateGetMethod() {
        Account a = new Account();
        a.Name = 'Test';
        insert a;
        
        Contact c = new Contact();
        c.LastName = 'Test';
        c.Email = 'foo@bar.com';
        c.AccountId = a.Id;
        insert c;
        
        Disposition__c disp = new Disposition__c();
        disp.Name = 'Left Voicemail';
        disp.Status__c = 'Attepmted';
        disp.change_value__c = true;
        insert disp;
        
        //do request
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();

        req.requestURI = '/services/apexrest/Accounts';  
        req.addParameter('SFContactId', c.Id);
        req.addParameter('DispositionName', disp.Name);

        req.httpMethod = 'GET';
        RestContext.request = req;
        RestContext.response = res;

        string result = UpdateContactWRTDispositionController.UpdateContactGet();
        
    }
    
    static testMethod void exceptionInTryBlockPostMethod() {
        Account a = new Account();
        a.Name = 'Test';
        insert a;
        
        Contact c = new Contact();
        c.LastName = 'Test';
        c.Email = 'foo@bar.com';
        c.AccountId = a.Id;
        insert c;
        
        Disposition__c disp = new Disposition__c();
        disp.Name = 'Left Voicemail';
        disp.Status__c = 'Attepmted';
        disp.change_value__c = true;
        insert disp;
        
        //do request
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();

        req.requestURI = '/services/apexrest/Accounts';  
        req.addParameter('SFContactId', c.Id);
        req.addParameter('DispositionName', 'xyz');

        req.httpMethod = 'GET';
        RestContext.request = req;
        RestContext.response = res;

        string result = UpdateContactWRTDispositionController.UpdateContactGet();
        
    }
    
    static testMethod void failPostMethod() {
        Account a = new Account();
        a.Name = 'Test';
        insert a;
        
        Contact c = new Contact();
        c.LastName = 'Test';
        c.Email = 'foo@bar.com';
        c.AccountId = a.Id;
        insert c;
        
        Disposition__c disp = new Disposition__c();
        disp.Name = 'Left Voicemail';
        disp.Status__c = 'Attepmted';
        disp.change_value__c = true;
        insert disp;
        
        //do request
        RestRequest req = new RestRequest(); 
        RestResponse res = new RestResponse();

        req.requestURI = '/services/apexrest/Accounts';  
        req.addParameter('SFContactId', 'abc');
        req.addParameter('DispositionName', 'xyz');

        req.httpMethod = 'GET';
        RestContext.request = req;
        RestContext.response = res;

        string result = UpdateContactWRTDispositionController.UpdateContactGet();
        
    }
}