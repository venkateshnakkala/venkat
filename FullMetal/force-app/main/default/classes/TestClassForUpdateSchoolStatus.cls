@isTest
public class TestClassForUpdateSchoolStatus 
{
    
static testmethod void CreateAccount()
    {
    //Create Test Contact
    Contact con = new Contact();
    con.title = 'test Sohaib';
    con.LastName='Ansari';
    con.phone='(816)210-0701';
    insert con;
    
    con.School_Status__c='New Lead';
    update con;
        
    }
    
}