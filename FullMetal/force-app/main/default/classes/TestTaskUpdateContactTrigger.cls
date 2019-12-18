@isTest
public class TestTaskUpdateContactTrigger
{
    @isTest
    public static void testTask()
    {
        Account acc = new Account(Name = 'Acme');
        insert acc;
        Contact con = new Contact(LastName = 'Test', AccountId = acc.Id, School_Status__c = 'Connected');
        insert con;
        
        con.School_Status__c = 'New Lead';
        update con;
        
        Task t = new Task(WhoId = con.Id, Subject = 'Test', Call_Result__c = 'Attempted');
        
        insert t;
    }
}