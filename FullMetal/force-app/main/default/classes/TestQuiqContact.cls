@isTest
public class TestQuiqContact {
    @isTest
    static void ConfirmContact(){
        Contact con = new Contact(FirstName='Trudy',LastName='Mctesterson',Email='testtrudy@invalid.not');
        Insert con;
        System.assert(con.ID != null);
    }
    @isTest
    static void CheckForContactData() {
        Case c = new Case(Subject = 'Test Case subject');
        Insert c;
        Case c2 = [select Id, ContactId from Case where Id = :c.Id];
        c2.Chat_Email__c = 'test@invalid.not';
        c2.Chat_First_Name__c = 'Testy';
        c2.Chat_Last_Name__c = 'McTesterson';
        c2.Chat_Phone__c = '4065551212';
        update c2;
        Case c3 = [select Id, contactID from Case where Id = :c2.Id];
        Contact con2 = [select id, FirstName, LastName from Contact where id = :c3.contactId];
        System.assertEquals('Testy',con2.FirstName);
        System.assertEquals('McTesterson',con2.LastName);
    }
}