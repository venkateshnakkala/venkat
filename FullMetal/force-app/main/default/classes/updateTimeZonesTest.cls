@isTest
public class updateTimeZonesTest{
    static testMethod void test1() {
        Contact c = new Contact();
        c.firstname='fjskfjsd';
        c.lastname='fsdfsdfs';
        c.MailingStreet='123 fdsfjdskfj';
        c.MailingState='CA';
        c.MailingPostalCode='99999';
        
        insert c;
        updateTimeZones obj = new updateTimeZones();

        Database.executeBatch(obj);
    }
}