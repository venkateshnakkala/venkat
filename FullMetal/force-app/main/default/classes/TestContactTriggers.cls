@isTest
public class TestContactTriggers {
    static testmethod void test()
    {
        
        
        Account acc = New Account(Name = 'Test Account');
        insert acc;
        
        Contact con = New contact ();
        con.FirstName = 'test';
        con.LastName = 'con';
        con.AccountId = acc.Id;
        con.Event_Scheduled_Date__c = system.now();
        con.Lead_Source_Code__c = 'test';
        con.school_status__c = 'Connected';
        insert con;
        
        Contact con2 = New contact ();
        con2.FirstName = 'test';
        con2.LastName = 'con';
        insert con2;
        
        
        datetime eventscheduleddate = con.Event_Scheduled_Date__c;
        datetime newdate = eventscheduleddate.addHours(1);
        
        Test.startTest();
        
        
        
        con.Event_Scheduled_Date__c = newdate;
        con.Lead_Source_Code__c = 'test2';
        con.school_status__c = 'test';
        Update con;
        
        con.school_status__c = 'connected';
        update con;   
        
        
        Test.stopTest();
        
    }
}