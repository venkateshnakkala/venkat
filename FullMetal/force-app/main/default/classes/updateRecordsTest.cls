@isTest
private class updateRecordsTest{
    static testMethod void test1() {
        Contact c = new Contact(firstname='fdsfdsdsfsf', lastname='fksjdfks',ssn__c='000-11-2222', systudentid__c='12345');
        insert c;
        
        updateRecords u = new updateRecords();
        
        Database.executeBatch(u,20);
    }
}