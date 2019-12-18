@isTest
private class CheckinContactTest{
    static testMethod void test() {
        Contact n = new Contact();
        n.lastname='test';
        n.email='abcd@abcd.com';
        insert n;
        
        CheckinContact c = new CheckinContact();
        c.chkLogIn();
        c.email='abcd@abcd.com';
        
        c.cheakEmails();
        c.street='test';
        c.save();
        
        c.email='abcd456@email.com';
        c.cheakEmails();
        c.firstname='tjfksdjf';
        c.lastname='fjskljfsd';
        c.save();
    }
}