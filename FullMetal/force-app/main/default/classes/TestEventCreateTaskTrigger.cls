@isTest
public class TestEventCreateTaskTrigger {
    static testmethod void test()
    {
        
        Contact con = New contact ();
        con.LastName = 'con';
        insert con;
        
        Event evt = New Event ();
        evt.StartDateTime = datetime.now();
        evt.EndDateTime = datetime.now();
        evt.Event_Subject__c = 'Tour';
        insert evt;
        
     
             
        datetime eventscheduleddate = evt.StartDateTime;
        datetime newdate = eventscheduleddate.addHours(-1);       
        
        Test.startTest();
        evt.StartDateTime = newdate;
        evt.Event_Subject__c = 'ATT';
        upsert evt;
               
        
        Test.stopTest();
        
    }
}