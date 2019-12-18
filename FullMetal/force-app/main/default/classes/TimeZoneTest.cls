@isTest
public class TimeZoneTest{
 
    static testMethod void test1() {
        List<Contact> c = new List<Contact>();
        c.add(new Contact(FirstName='Test', LastName='Test', MailingState='California', MailingPostalCode='90020'));
        c.add(new Contact(FirstName='Test', LastName='Test', MailingState='KY', MailingPostalCode='40111'));
        c.add(new Contact(FirstName='Test', LastName='Test', MailingState='ZZ', MailingPostalCode='11111'));
        insert c;
        
        List<Application__c> a = new List<Application__c>();
        a.add(new Application__c(Student__c=c[0].id, Program_Code__c='ASMP'));
        a.add(new Application__c(Student__c=c[1].id, Program_Code__c='ASMP'));
        a.add(new Application__c(Student__c=c[2].id, Program_Code__c='ASMP'));
        insert a;
        
        List<Id> ids = new List<Id>();
        ids.add(c[0].id);
        ids.add(c[1].id);
        
        TimeZone.updateTimeZone(ids);
    }
}