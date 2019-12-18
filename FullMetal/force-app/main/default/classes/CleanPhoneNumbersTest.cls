@isTest
Public class CleanPhoneNumbersTest{
    Public Static testMethod void  test(){
        Contact c = new Contact();
        c.firstname='fjsdlfjsd';
        c.lastname='fjsghskld';
        c.phone='13524560011';
        insert c;
        
        CleanPhoneNumbers p = new CleanPhoneNumbers();
        Database.ExecuteBatch(p);
    }
}