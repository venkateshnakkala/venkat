@isTest(SeeAllData=true)
Public class UpdateUsersTest
{
    Public static TestMethod void test1()
    {
        Contact c = new Contact(firstname='testyyy', lastname='testdfsfd', email='fjsdkf243@hfdsjfhsd.esdf');
        insert c;
        
        User newApplicant = new User();      
        newApplicant.Username = 'fjsdkf243@hfdsjfhsd.esdf';
        newApplicant.Email = 'fjsdkf243@hfdsjfhsd.esdf';
        newApplicant.FirstName = 'testyyy';
        newApplicant.LastName = 'testdfsfd';
        newApplicant.alias='tezz';
        newApplicant.TimeZoneSidKey = 'GMT';
        newApplicant.LanguageLocaleKey = 'en_US';
        newApplicant.EmailEncodingKey = 'UTF-8';
        newApplicant.LocaleSidKey = UserInfo.getLocale();
        Profile p =[Select id from Profile where name='Application User'];
        newApplicant.ProfileId=p.id;
        newApplicant.Lead_Source__c = 'LAFSWEBAPP';        
        newApplicant.ContactId = c.id;
        insert newApplicant;
        
        c.email='xxdsqdsad@kfjsk44.eee';
        update c;
    }
}