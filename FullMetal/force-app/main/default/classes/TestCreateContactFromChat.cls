@isTest
public class TestCreateContactFromChat {
    @isTest
    static void ConfirmContact(){
        Contact con = new Contact(FirstName='Trudy',LastName='Mctesterson',Email='testtrudy@invalid.not');
        Insert con;
        System.assert(con.ID != null);
    }
    @isTest
    static void CheckForContactData() {
        Case c = new Case(Subject = 'Test Case subject', Chat_Email__c = 'test@invalid.not', Chat_First_Name__c = 'Testy', Chat_Last_Name__c = 'McTesterson', Chat_Phone__c = '4065551212' );
        Insert c;
        Contact con = [select Id, FirstName, LastName from Contact where Email = 'test@invalid.not'];
        System.assertEquals('Testy',con.FirstName);
        System.assertEquals('McTesterson',con.LastName);
        // get the case and confirm contacts match
        Case c2 = [select Id, ContactId from Case where Id = :c.Id];
        System.assertEquals(c2.ContactId, con.Id);
    }
}