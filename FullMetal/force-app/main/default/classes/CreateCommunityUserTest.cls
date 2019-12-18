@IsTest(SeeAllData=true)
public class CreateCommunityUserTest
{
    public static testmethod void test1()
    {
        Contact c1 = new Contact();
        c1.firstname='hhhhhhhhhh';
        c1.lastname='hhhhhhhhhh';
        c1.email='hhhhh@hhhhh.com';
        
        Contact c2 = new Contact();
        c2.firstname='yyyyyyyyyy';
        c2.lastname='yyyyyyyyy';
        c2.email='yyyyyy@yyyyyy.com';
        
        Contact c3 = new Contact();
        c3.firstname='ttttttttttt';
        c3.lastname='ttttttttt';
        c3.email='yyyyyy@yyyyyy.com';
        
        List<Contact> con = new List<Contact>();
        con.add(c1);
        con.add(c2);
        con.add(c3);
        insert con;
        
        User u = createNewUser(c2,'yyyyyy@yyyyyy.com');
        u.ContactId=c2.Id;
        insert u;
        
        List<Id> ids = new List<Id>();

        ids.add(c1.id);
        ids.add(c2.id);
        ids.add(c3.id);

        CreateCommunityUser b = new CreateCommunityUser(ids);
        Database.ExecuteBatch(b);
    }
    
    public static testmethod void test2()
    {
        Contact c1 = new Contact();
        c1.firstname='xxxxxxxxx';
        c1.lastname='xxxxxxxx';
        c1.email='hhhyyhh@hhhxxhh.com';
        insert c1;
        
        c1.school_status__c='Enrolled';
        update c1;
    }
    
    private static User createNewUser(Contact c, String email)
    {
        User u= new User();      
        u.Username = email;
        u.Email = email;
        u.FirstName = c.FirstName;
        u.LastName = c.LastName;
        
        if(u.email.length()>36){ 
            u.CommunityNickname=email.substring(0,36);
        } 
        else { 
            u.CommunityNickname=email; 
        }
        
        String alias=u.lastname+u.firstname;
        alias.replaceAll(' ','');
        
        u.alias=alias.SubString(0,4);
        
        u.TimeZoneSidKey = 'GMT';
        u.LanguageLocaleKey = 'en_US';
        u.EmailEncodingKey = 'UTF-8';
        u.LocaleSidKey = UserInfo.getLocale();
        Profile p =[Select id from Profile where name='Application User'];
        u.ProfileId=p.id;
        u.Lead_Source__c = c.Lead_Source_Code__c;      
        u.ContactId = c.Id;
        
        return u;
    }
}