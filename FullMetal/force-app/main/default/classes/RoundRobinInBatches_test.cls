@isTest(SeeAllData=true)
global class RoundRobinInBatches_test
{
    public testmethod static void test1()
    {
        List<Contact> con = [select id, firstname, lastname, email, other_email__c, phone, ownerid from contact where ownerid='0051a000002tHWnAAM' limit 5];
        Database.executeBatch(new RoundRobinInBatches(con));
    }
}