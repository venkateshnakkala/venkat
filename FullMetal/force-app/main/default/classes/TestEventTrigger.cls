@isTest
public class TestEventTrigger {
    static testmethod void test()
    {
        Account acc = New Account(Name = 'Test Account');
        insert acc;
        
        Contact con = New contact ();
        con.LastName = 'con';
        con.AccountId = acc.Id;
        insert con;
        
        Event e = new Event();
        e.Subject = 'other';
        e.StartDateTime = system.now();
        e.EndDateTime = system.now();
        e.WhoId = con.id;
        
        insert e;
        
 /*       User us = New User();
        us.RoundRobin__c = 2;
        //us.add(us);
        update us;
 
        
        Test.startTest();
        
        e.subject = 'Tour';
        update e;*/
         Profile p = [SELECT Id FROM Profile WHERE Name='Standard User']; 
         User u = new User(Alias = 'ingsf', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='aaksfdctest', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_US', ProfileId = p.Id, 
            TimeZoneSidKey='America/Los_Angeles', UserName='standarduser@sfdctest.com');
            
            insert u;
         
        
      //  Test.stopTest();
        
    }
}