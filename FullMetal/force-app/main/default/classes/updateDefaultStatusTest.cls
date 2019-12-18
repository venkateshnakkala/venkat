@isTest
class updateDefaultStatusTest
{
    public static testmethod void test1()
    {
        Contact c = new Contact(firstname='Bindu', LastName='Golamari');
        insert c;
        
        Application__c a1 = new Application__c(Student__c=c.id, NSLDS_Status__c='Default', Program_code__c='ASMP');
        insert a1;
        
        System.assertEquals(a1.NSLDS_Status__c, 'Default');
        
        Application__c a2 = new Application__c(Student__c=c.id, Program_code__c='ASMP');
        insert a2;
        
        a2.NSLDS_Status__c='Default';
        update a2;
        
        System.assertEquals(a2.NSLDS_Status__c, 'Default');
        
        List<Contact> con = new List<Contact>();
        con.add(new Contact(firstname='bindu'+Math.random(), lastname='golamari'+Math.random()));
        con.add(new Contact(firstname='bindu'+Math.random(), lastname='golamari'+Math.random()));
        con.add(new Contact(firstname='bindu'+Math.random(), lastname='golamari'+Math.random()));
        con.add(new Contact(firstname='bindu'+Math.random(), lastname='golamari'+Math.random()));
        con.add(new Contact(firstname='bindu'+Math.random(), lastname='golamari'+Math.random()));
        con.add(new Contact(firstname='bindu'+Math.random(), lastname='golamari'+Math.random()));
        con.add(new Contact(firstname='bindu'+Math.random(), lastname='golamari'+Math.random()));
        con.add(new Contact(firstname='bindu'+Math.random(), lastname='golamari'+Math.random()));
        con.add(new Contact(firstname='bindu'+Math.random(), lastname='golamari'+Math.random()));
        con.add(new Contact(firstname='bindu'+Math.random(), lastname='golamari'+Math.random()));
        con.add(new Contact(firstname='bindu'+Math.random(), lastname='golamari'+Math.random()));
        con.add(new Contact(firstname='bindu'+Math.random(), lastname='golamari'+Math.random()));
        con.add(new Contact(firstname='bindu'+Math.random(), lastname='golamari'+Math.random()));
        insert con;
    }
}