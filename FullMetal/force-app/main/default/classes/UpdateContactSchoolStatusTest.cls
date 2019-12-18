@isTest
public class UpdateContactSchoolStatusTest
{
    @isTest
    public static void testSchoolStatus()
    {
        Account acc = new Account(Name = 'Acme');
        insert acc;
        Contact con = new Contact(LastName = 'Test', AccountId = acc.Id, School_Status__c = 'Connected');
        insert con;
        
        con.School_Status__c = 'New Lead';
        update con;
        
        UpdateContactSchoolStatus testBatch = new UpdateContactSchoolStatus();
        testBatch.validSchoolStatus('New Lead');
        testBatch.query = 'select Id, Name from Contact';
        ID batchprocessId = Database.executeBatch(testBatch);
    }
}